package com.glance.service;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.MatchRecord;

import java.util.List;

public interface MatchService {
    /** 尝试匹配：检查是否存在双向心动 */
    ApiResponse<MatchRecord> tryMatch(Long userId, Long cardId);
    /** 获取用户的所有匹配 */
    ApiResponse<List<MatchRecord>> getMyMatches(Long userId);
    /** 检查用户是否有未通知的匹配（用于轮询） */
    ApiResponse<?> checkMatch(Long userId);

    /** 解除匹配 */
    ApiResponse<?> unmatch(Long userId, Long matchId);

    /** 获取匹配仪式详情（共同点/缘分百分比/破冰提示） */
    ApiResponse<?> getCeremonyDetail(Long userId, Long matchId);
}
