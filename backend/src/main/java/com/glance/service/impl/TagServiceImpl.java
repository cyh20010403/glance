package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.InterestTag;
import com.glance.model.entity.User;
import com.glance.repository.InterestTagRepository;
import com.glance.repository.UserRepository;
import com.glance.service.TagService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {

    private final InterestTagRepository interestTagRepository;
    private final UserRepository userRepository;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public ApiResponse<List<InterestTag>> getAllTags() {
        return ApiResponse.ok(interestTagRepository.findAllByOrderBySortOrderAsc());
    }

    @Override
    @Transactional
    public ApiResponse<?> updateUserTags(Long userId, List<String> tags) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return ApiResponse.error("用户不存在");
        }
        try {
            user.setTags(objectMapper.writeValueAsString(tags));
            userRepository.save(user);
            log.info("用户 {} 更新兴趣标签", userId);
            return ApiResponse.ok("标签已更新");
        } catch (Exception e) {
            log.error("标签格式错误, userId={}", userId, e);
            return ApiResponse.error("标签格式错误");
        }
    }
}
