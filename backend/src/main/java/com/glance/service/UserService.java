package com.glance.service;

import com.glance.model.dto.request.CreateCardRequest;
import com.glance.model.dto.request.LoginRequest;
import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.SendMessageRequest;
import com.glance.model.entity.*;

import java.util.*;

public interface UserService {
    ApiResponse<?> login(LoginRequest request);
    ApiResponse<?> updateProfile(Long userId, String nickname, String avatar, String signature, List<String> tags);
    ApiResponse<?> updateMyLook(Long userId, Map<String, Object> body);
    User getUserById(Long userId);
}
