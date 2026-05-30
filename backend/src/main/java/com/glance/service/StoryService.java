package com.glance.service;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.response.StoryResponse;

import java.util.List;

public interface StoryService {
    ApiResponse<StoryResponse> getTodayStory(Long userId);
    ApiResponse<List<StoryResponse>> getStoryHistory(Long userId, int page, int size);
}
