package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.CreateCardRequest;
import com.glance.model.entity.HeartCard;
import com.glance.model.entity.MatchRecord;
import com.glance.model.entity.User;
import com.glance.repository.BlockListRepository;
import com.glance.repository.HeartCardRepository;
import com.glance.repository.MatchRecordRepository;
import com.glance.repository.UserRepository;
import com.glance.service.HeartCardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class HeartCardServiceImpl implements HeartCardService {

    private final HeartCardRepository heartCardRepository;
    private final MatchRecordRepository matchRecordRepository;
    private final BlockListRepository blockListRepository;
    private final UserRepository userRepository;

    /** 特征相似度阈值：得分 >= 此值视为匹配 */
    private static final int MATCH_THRESHOLD = 3;

    @Override
    @Transactional
    public ApiResponse<?> createCard(Long userId, CreateCardRequest request) {
        heartCardRepository.expireCards(LocalDateTime.now());

        HeartCard card = HeartCard.builder()
                .userId(userId)
                .scene(request.getScene())
                .sceneLabel(request.getSceneLabel() != null ? request.getSceneLabel() : "")
                .location(request.getLocation() != null ? request.getLocation() : "")
                .occurredAt(request.getOccurredAt())
                .topColor(request.getTopColor() != null ? request.getTopColor() : "")
                .pantsColor(request.getPantsColor() != null ? request.getPantsColor() : "")
                .glasses(request.getGlasses() != null ? request.getGlasses() : 0)
                .hairstyle(request.getHairstyle() != null ? request.getHairstyle() : "")
                .hasBag(request.getHasBag() != null ? request.getHasBag() : 0)
                .shoeColor(request.getShoeColor() != null ? request.getShoeColor() : "")
                .description(request.getDescription() != null ? request.getDescription() : "")
                .build();

        heartCardRepository.save(card);

        // 自动匹配：将卡片描述的特征 与 其他用户的"我的形象"比对
        List<HeartCard> activeCards = heartCardRepository.findActiveCards(LocalDateTime.now(), userId);
        HeartCard bestMatch = null;
        int bestScore = 0;

        for (HeartCard otherCard : activeCards) {
            if (!otherCard.getScene().equals(card.getScene())) continue;
            if (blockListRepository.existsByUserIdAndBlockedId(otherCard.getUserId(), userId)) continue;
            if (blockListRepository.existsByUserIdAndBlockedId(userId, otherCard.getUserId())) continue;

            // 关键修正：用自己的卡片描述 比对 对方（卡片发布者）的实际形象
            User otherUser = userRepository.findById(otherCard.getUserId()).orElse(null);
            if (otherUser == null) continue;

            // 对方卡片描述的应该是"我"，拿我的形象去比对
            User me = userRepository.findById(userId).orElse(null);
            if (me == null) continue;

            // 我的卡片描述对方 → 比对对方的实际形象
            int score1 = calcAppearanceScore(card, otherUser);
            // 对方的卡片描述我 → 比对我的实际形象
            int score2 = calcAppearanceScore(otherCard, me);

            if (score1 >= MATCH_THRESHOLD && score2 >= MATCH_THRESHOLD) {
                int totalScore = score1 + score2;
                if (totalScore > bestScore) {
                    bestScore = totalScore;
                    bestMatch = otherCard;
                }
            }
        }

        if (bestMatch != null) {
            // 双向匹配成立
            card.setStatus(2);
            bestMatch.setStatus(2);
            heartCardRepository.save(card);
            heartCardRepository.save(bestMatch);

            MatchRecord match = MatchRecord.builder()
                    .cardAId(card.getId()).cardBId(bestMatch.getId())
                    .userAId(userId).userBId(bestMatch.getUserId())
                    .build();
            matchRecordRepository.save(match);

            log.info("匹配成功(相似度={}): matchId={}, userA={}, userB={}",
                    bestScore, match.getId(), userId, bestMatch.getUserId());

            Map<String, Object> result = new HashMap<>();
            result.put("match", match);
            result.put("partnerCard", Map.of(
                    "scene", bestMatch.getScene(),
                    "description", bestMatch.getDescription(),
                    "topColor", bestMatch.getTopColor(),
                    "pantsColor", bestMatch.getPantsColor(),
                    "hairstyle", bestMatch.getHairstyle(),
                    "glasses", bestMatch.getGlasses(),
                    "hasBag", bestMatch.getHasBag(),
                    "shoeColor", bestMatch.getShoeColor()
            ));
            result.put("similarityScore", bestScore);
            // 把 myCard 改名为 card 返回给前端
            Map<String, Object> cardMap = new LinkedHashMap<>();
            cardMap.put("id", card.getId());
            cardMap.put("userId", card.getUserId());
            cardMap.put("scene", card.getScene());
            cardMap.put("description", card.getDescription());
            cardMap.put("status", card.getStatus());
            cardMap.put("expireAt", card.getExpireAt().toString());
            cardMap.put("createdAt", card.getCreatedAt().toString());

            return ApiResponse.ok("TA 也刚刚注意到了你。", result);
        }

        log.info("创建心动卡片: cardId={}, userId={}, scene={}", card.getId(), userId, card.getScene());
        return ApiResponse.ok("卡片创建成功，有效期为30分钟", card);
    }

    /** 计算卡片描述 与 用户实际形象的匹配度 */
    private int calcAppearanceScore(HeartCard card, User user) {
        int score = 0;
        if (match(card.getTopColor(), user.getMyTopColor())) score += 2;
        if (match(card.getPantsColor(), user.getMyPantsColor())) score += 2;
        if (match(card.getShoeColor(), user.getMyShoeColor())) score += 1;
        if (match(card.getHairstyle(), user.getMyHairstyle())) score += 1;
        if (card.getGlasses() != null && card.getGlasses() > 0
                && card.getGlasses().equals(user.getMyGlasses())) score += 1;
        if (card.getHasBag() != null && card.getHasBag() > 0
                && card.getHasBag().equals(user.getMyHasBag())) score += 1;
        return score;
    }

    private boolean match(String cardValue, String userValue) {
        return cardValue != null && !cardValue.isEmpty()
                && userValue != null && !userValue.isEmpty()
                && cardValue.equals(userValue);
    }

    @Override
    @Transactional
    public ApiResponse<List<HeartCard>> getNearbyCards(Long userId) {
        heartCardRepository.expireCards(LocalDateTime.now());
        List<HeartCard> cards = heartCardRepository.findActiveCards(LocalDateTime.now(), userId);
        return ApiResponse.ok(cards);
    }

    @Override
    public ApiResponse<List<HeartCard>> getMyCards(Long userId) {
        List<HeartCard> cards = heartCardRepository.findByUserIdAndStatus(userId, 1);
        return ApiResponse.ok(cards);
    }
}
