package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.HeartCard;
import com.glance.model.entity.MatchRecord;
import com.glance.repository.BlockListRepository;
import com.glance.repository.HeartCardRepository;
import com.glance.repository.MatchRecordRepository;
import com.glance.service.MatchService;
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
            matchRecordRepository.save(match);

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
}
