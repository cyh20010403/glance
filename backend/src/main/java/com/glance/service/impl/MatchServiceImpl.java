package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.HeartCard;
import com.glance.model.entity.MatchRecord;
import com.glance.model.entity.User;
import com.glance.repository.BlockListRepository;
import com.glance.repository.HeartCardRepository;
import com.glance.repository.MatchRecordRepository;
import com.glance.repository.UserRepository;
import com.glance.service.AiMatchService;
import com.glance.service.MatchService;
import com.glance.websocket.MatchNotificationHandler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class MatchServiceImpl implements MatchService {

    private final HeartCardRepository heartCardRepository;
    private final MatchRecordRepository matchRecordRepository;
    private final BlockListRepository blockListRepository;
    private final UserRepository userRepository;
    private final MatchNotificationHandler matchNotificationHandler;
    private final AiMatchService aiMatchService;
    private final com.fasterxml.jackson.databind.ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper();

    @Override
    @Transactional(readOnly = true)
    public ApiResponse<?> checkMatch(Long userId) {
        List<HeartCard> myCards = heartCardRepository.findByUserIdAndStatus(userId, 2);
        if (myCards.isEmpty()) return ApiResponse.ok(null);

        List<MatchRecord> matches = matchRecordRepository.findByUserAIdOrUserBId(userId, userId);
        MatchRecord latest = matches.stream()
                .filter(m -> m.getStatus() == 1)
                .findFirst().orElse(null);

        if (latest == null) return ApiResponse.ok(null);

        // 获取对方的卡片信息
        Long partnerCardId = latest.getUserAId().equals(userId)
                ? latest.getCardBId() : latest.getCardAId();
        HeartCard partnerCard = heartCardRepository.findById(partnerCardId).orElse(null);

        Map<String, Object> result = new HashMap<>();
        result.put("match", latest);
        if (partnerCard != null) {
            result.put("partnerCard", Map.of(
                    "scene", partnerCard.getScene(),
                    "description", partnerCard.getDescription(),
                    "topColor", partnerCard.getTopColor(),
                    "pantsColor", partnerCard.getPantsColor(),
                    "hairstyle", partnerCard.getHairstyle(),
                    "glasses", partnerCard.getGlasses(),
                    "hasBag", partnerCard.getHasBag(),
                    "shoeColor", partnerCard.getShoeColor()
            ));
        }
        return ApiResponse.ok("TA 也刚刚注意到了你。", result);
    }

    @Override
    @Transactional
    public ApiResponse<MatchRecord> tryMatch(Long userId, Long targetCardId) {
        // 对方的心动卡片
        HeartCard targetCard = heartCardRepository.findById(targetCardId).orElse(null);
        if (targetCard == null || targetCard.getUserId().equals(userId)) {
            return ApiResponse.error("卡片不存在");
        }
        if (targetCard.getStatus() != 1) {
            return ApiResponse.error("该卡片已失效");
        }

        // 检查是否被对方拉黑
        if (blockListRepository.existsByUserIdAndBlockedId(targetCard.getUserId(), userId)) {
            return ApiResponse.error("无法操作");
        }

        // 自动为用户创建一张同场景的卡片
        HeartCard myCard = HeartCard.builder()
                .userId(userId)
                .scene(targetCard.getScene())
                .sceneLabel(targetCard.getSceneLabel())
                .location(targetCard.getLocation())
                .occurredAt(LocalDateTime.now())
                .build();
        heartCardRepository.save(myCard);

        // 在有效卡片中查找来自对方（targetCard 的发布者）的卡片
        List<HeartCard> activeCards = heartCardRepository.findActiveCards(
                LocalDateTime.now(), userId);

        for (HeartCard otherCard : activeCards) {
            // 必须是对方发布的卡片、且同场景
            if (!otherCard.getUserId().equals(targetCard.getUserId())) continue;
            if (!otherCard.getScene().equals(myCard.getScene())) continue;

            // === V2.0 四维加权匹配 ===
            int totalScore = 0;
            List<String> commonPoints = new ArrayList<>();
            commonPoints.add("同一场景"); // 维度1: 场景一致(必须满足)

            // 维度1: 衣着特征相似度 (40%)
            int featureScore = computeFeatureSimilarity(otherCard, myCard);
            totalScore += (int)(featureScore * 0.4);

            // 维度2: 兴趣标签匹配 (30%)
            int tagScore = computeTagOverlap(userId, otherCard.getUserId());
            totalScore += (int)(tagScore * 0.3);
            if (tagScore > 50) commonPoints.add("兴趣相投");

            // 维度3: AI 文本语义匹配 (20%)
            double aiScore = aiMatchService.computeTextSimilarity(
                    myCard.getDescription(), otherCard.getDescription());
            totalScore += (int)(aiScore * 100 * 0.2);

            // 维度4: 时间相近度 (10%)
            long timeDiff = Math.abs(java.time.Duration.between(
                    myCard.getOccurredAt() != null ? myCard.getOccurredAt() : java.time.LocalDateTime.now(),
                    otherCard.getOccurredAt() != null ? otherCard.getOccurredAt() : java.time.LocalDateTime.now()).toMinutes());
            int timeScore = timeDiff < 5 ? 100 : timeDiff < 15 ? 60 : timeDiff < 30 ? 30 : 0;
            totalScore += (int)(timeScore * 0.1);

            log.info("四维匹配得分: userId={}, totalScore={}, feature={}, tag={}, ai={}, time={}",
                    userId, totalScore, featureScore, tagScore, (int)(aiScore * 100), timeScore);

            // 双向匹配成立
            myCard.setStatus(2);
            otherCard.setStatus(2);
            heartCardRepository.save(myCard);
            heartCardRepository.save(otherCard);

            MatchRecord match = MatchRecord.builder()
                    .cardAId(myCard.getId())
                    .cardBId(otherCard.getId())
                    .userAId(userId)
                    .userBId(otherCard.getUserId())
                    .build();

            // 计算共同点和缘分百分比
            List<String> commonPointsList = new ArrayList<>();
            int totalAttrs = 0;
            int matchedAttrs = 0;

            // 场景
            totalAttrs++;
            if (myCard.getScene() != null && !myCard.getScene().isEmpty()
                    && myCard.getScene().equals(otherCard.getScene())) {
                commonPointsList.add("同在" + getSceneLabel(myCard.getScene()));
                matchedAttrs++;
            }

            // 上装颜色
            totalAttrs++;
            if (isNotEmpty(myCard.getTopColor()) && myCard.getTopColor().equals(otherCard.getTopColor())) {
                commonPointsList.add("相似的衣着颜色");
                matchedAttrs++;
            }

            // 裤装颜色
            totalAttrs++;
            if (isNotEmpty(myCard.getPantsColor()) && myCard.getPantsColor().equals(otherCard.getPantsColor())) {
                commonPointsList.add("相似的裤装");
                matchedAttrs++;
            }

            // 发型
            totalAttrs++;
            if (isNotEmpty(myCard.getHairstyle()) && myCard.getHairstyle().equals(otherCard.getHairstyle())) {
                commonPointsList.add("相似的发型");
                matchedAttrs++;
            }

            // 眼镜
            totalAttrs++;
            if (myCard.getGlasses() != null && myCard.getGlasses() > 0
                    && myCard.getGlasses().equals(otherCard.getGlasses())) {
                commonPointsList.add(myCard.getGlasses() == 1 ? "都戴眼镜" : "都不戴眼镜");
                matchedAttrs++;
            }

            // 背包
            totalAttrs++;
            if (myCard.getHasBag() != null && myCard.getHasBag() > 0
                    && myCard.getHasBag().equals(otherCard.getHasBag())) {
                commonPointsList.add(myCard.getHasBag() == 1 ? "都背包" : "都不背包");
                matchedAttrs++;
            }

            // 鞋子颜色
            totalAttrs++;
            if (isNotEmpty(myCard.getShoeColor()) && myCard.getShoeColor().equals(otherCard.getShoeColor())) {
                commonPointsList.add("相似的鞋色");
                matchedAttrs++;
            }

            // 确保至少有一个共同点
            if (commonPointsList.isEmpty()) {
                commonPointsList.add("在" + getSceneLabel(myCard.getScene()) + "相遇");
            }

            int score = totalAttrs > 0
                    ? Math.max(60, (int) Math.round((double) matchedAttrs / totalAttrs * 100))
                    : 80;

            try {
                match.setCommonPoints(objectMapper.writeValueAsString(commonPointsList));
            } catch (Exception e) {
                log.warn("Failed to serialize common points", e);
            }
            match.setScorePercent(score);

            matchRecordRepository.save(match);

            // WebSocket 推送匹配通知给双方
            matchNotificationHandler.pushMatchNotification(userId, match.getId(), myCard.getId());
            matchNotificationHandler.pushMatchNotification(otherCard.getUserId(), match.getId(), otherCard.getId());

            log.info("匹配成功: matchId={}, userA={}, userB={}", match.getId(), userId, otherCard.getUserId());
            return ApiResponse.ok("TA 也刚刚注意到了你。", match);
        }

        return ApiResponse.ok("卡片已发布，等待对方回应", null);
    }

    @Override
    public ApiResponse<List<MatchRecord>> getMyMatches(Long userId) {
        List<MatchRecord> matches = matchRecordRepository.findByUserAIdOrUserBId(userId, userId);
        return ApiResponse.ok(matches);
    }

    @Override
    @Transactional
    public ApiResponse<?> unmatch(Long userId, Long matchId) {
        MatchRecord match = matchRecordRepository.findById(matchId).orElse(null);
        if (match == null) return ApiResponse.error("匹配记录不存在");
        if (!match.getUserAId().equals(userId) && !match.getUserBId().equals(userId)) {
            return ApiResponse.error("无权操作");
        }
        match.setStatus(2);
        matchRecordRepository.save(match);
        return ApiResponse.ok("已解除匹配", null);
    }

    @Override
    public ApiResponse<?> getCeremonyDetail(Long userId, Long matchId) {
        MatchRecord match = matchRecordRepository.findById(matchId).orElse(null);
        if (match == null) return ApiResponse.error("匹配记录不存在");
        if (!match.getUserAId().equals(userId) && !match.getUserBId().equals(userId)) {
            return ApiResponse.error("无权查看");
        }

        Long partnerId = match.getUserAId().equals(userId)
                ? match.getUserBId() : match.getUserAId();
        User partner = userRepository.findById(partnerId).orElse(null);

        // 共同点计算
        List<String> commonPoints = new ArrayList<>();
        if (match.getCommonPoints() != null && !match.getCommonPoints().isEmpty()) {
            try {
                commonPoints = objectMapper.readValue(match.getCommonPoints(),
                        new com.fasterxml.jackson.core.type.TypeReference<List<String>>() {});
            } catch (Exception ignored) {}
        }

        // 破冰提示
        String icebreaker = "你们都在这里相遇了……聊聊今天的心情吧";
        HeartCard card = heartCardRepository.findById(
                match.getUserAId().equals(userId) ? match.getCardBId() : match.getCardAId()
        ).orElse(null);
        if (card != null) {
            icebreaker = "你们都在" + getSceneLabel(card.getScene())
                    + "里邂逅……聊聊今天的" + getSceneLabel(card.getScene()) + "体验？";
        }

        Map<String, Object> result = new HashMap<>();
        result.put("matchId", matchId);
        result.put("commonPoints", commonPoints);
        result.put("scorePercent", match.getScorePercent() != null ? match.getScorePercent() : 80);
        result.put("icebreaker", icebreaker);
        result.put("partnerNickname", partner != null ? partner.getNickname() : "");
        result.put("partnerMood", "");

        return ApiResponse.ok(result);
    }

    private String getSceneLabel(String scene) {
        return switch (scene) {
            case "subway" -> "地铁"; case "library" -> "图书馆";
            case "cafe" -> "咖啡店"; case "campus" -> "校园";
            default -> "城市某处";
        };
    }

    private boolean isNotEmpty(String s) {
        return s != null && !s.isEmpty();
    }

    /** 计算衣着特征相似度 (0-100) */
    private int computeFeatureSimilarity(HeartCard a, HeartCard b) {
        int score = 0;
        int total = 6;
        if (eq(a.getTopColor(), b.getTopColor())) score++;
        if (eq(a.getPantsColor(), b.getPantsColor())) score++;
        if (eq(a.getShoeColor(), b.getShoeColor())) score++;
        if (a.getGlasses() != null && a.getGlasses().equals(b.getGlasses())) score++;
        if (eq(a.getHairstyle(), b.getHairstyle())) score++;
        if (a.getHasBag() != null && a.getHasBag().equals(b.getHasBag())) score++;
        return score * 100 / total;
    }

    /** 计算兴趣标签重叠度 (0-100) */
    private int computeTagOverlap(Long userAId, Long userBId) {
        try {
            var ua = userRepository.findById(userAId).orElse(null);
            var ub = userRepository.findById(userBId).orElse(null);
            if (ua == null || ub == null || ua.getTags() == null || ub.getTags() == null)
                return 0;
            List<String> tagsA = objectMapper.readValue(ua.getTags(), List.class);
            List<String> tagsB = objectMapper.readValue(ub.getTags(), List.class);
            if (tagsA.isEmpty() || tagsB.isEmpty()) return 0;
            long overlap = tagsA.stream().filter(tagsB::contains).count();
            return (int)(overlap * 100 / Math.max(tagsA.size(), tagsB.size()));
        } catch (Exception e) {
            return 0;
        }
    }

    private boolean eq(String a, String b) {
        return a != null && !a.isEmpty() && a.equals(b);
    }
}
