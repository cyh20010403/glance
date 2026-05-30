package com.glance.service;

import com.glance.model.dto.ApiResponse;

public interface MoodService {
    ApiResponse<?> updateMood(Long userId, String mood);
    ApiResponse<?> getMyMood(Long userId);
    ApiResponse<?> getUserMood(Long targetUserId);
}
