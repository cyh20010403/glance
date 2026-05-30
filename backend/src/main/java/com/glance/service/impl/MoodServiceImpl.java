package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.MoodStatus;
import com.glance.repository.MoodStatusRepository;
import com.glance.service.MoodService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
public class MoodServiceImpl implements MoodService {

    private static final Set<String> VALID_MOODS = Set.of("expect", "miss", "happy", "quiet", "bored");

    private final MoodStatusRepository moodStatusRepository;

    @Override
    @Transactional
    public ApiResponse<?> updateMood(Long userId, String mood) {
        if (mood == null || !VALID_MOODS.contains(mood)) {
            return ApiResponse.error("无效的情绪类型");
        }
        MoodStatus status = moodStatusRepository.findByUserId(userId)
                .orElse(MoodStatus.builder().userId(userId).build());
        status.setMood(mood);
        moodStatusRepository.save(status);
        log.info("用户 {} 更新情绪状态: {}", userId, mood);
        return ApiResponse.ok("情绪状态已更新");
    }

    @Override
    public ApiResponse<?> getMyMood(Long userId) {
        return moodStatusRepository.findByUserId(userId)
                .map(ms -> ApiResponse.ok(Map.of("mood", ms.getMood(), "createdAt", ms.getCreatedAt().toString())))
                .orElse(ApiResponse.ok(null));
    }

    @Override
    public ApiResponse<?> getUserMood(Long targetUserId) {
        return moodStatusRepository.findByUserId(targetUserId)
                .map(ms -> ApiResponse.ok(Map.of("mood", ms.getMood())))
                .orElse(ApiResponse.ok(Map.of("mood", "")));
    }
}
