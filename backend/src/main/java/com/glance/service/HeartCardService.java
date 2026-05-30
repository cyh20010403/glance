package com.glance.service;

import com.glance.model.dto.request.CreateCardRequest;
import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.HeartCard;

import java.util.List;

public interface HeartCardService {
    /** 创建心动卡片 */
    ApiResponse<?> createCard(Long userId, CreateCardRequest request);
    /** 获取附近的有效卡片（排除自己） */
    ApiResponse<List<HeartCard>> getNearbyCards(Long userId);
    /** 获取自己发布的卡片 */
    ApiResponse<List<HeartCard>> getMyCards(Long userId);
}
