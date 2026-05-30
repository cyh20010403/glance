package com.glance.service;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.InterestTag;

import java.util.List;

public interface TagService {
    ApiResponse<List<InterestTag>> getAllTags();
    ApiResponse<?> updateUserTags(Long userId, List<String> tags);
}
