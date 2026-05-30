package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.LoginRequest;
import com.glance.model.entity.User;
import com.glance.repository.UserRepository;
import com.glance.security.JwtTokenProvider;
import com.glance.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;

    @Override
    @Transactional
    public ApiResponse<?> login(LoginRequest request) {
        // MVP阶段：简化验证码校验，任意6位数字码通过
        if (request.getCode() == null || request.getCode().length() != 6) {
            return ApiResponse.error("验证码格式错误");
        }

        User user = userRepository.findByPhone(request.getPhone())
                .orElseGet(() -> {
                    User newUser = User.builder()
                            .phone(request.getPhone())
                            .nickname("用户" + System.currentTimeMillis() % 100000)
                            .build();
                    return userRepository.save(newUser);
                });

        String token = jwtTokenProvider.generateToken(user.getId(), user.getPhone());
        Map<String, Object> data = new HashMap<>();
        data.put("token", token);
        data.put("userId", user.getId());
        data.put("nickname", user.getNickname());
        data.put("isNewUser", user.getCreatedAt().equals(user.getUpdatedAt()));

        log.info("用户登录成功: userId={}, phone={}", user.getId(), user.getPhone());
        return ApiResponse.ok(data);
    }

    @Override
    @Transactional
    public ApiResponse<?> updateProfile(Long userId, String nickname, String avatar,
                                         String signature, List<String> tags) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return ApiResponse.error("用户不存在");
        }
        if (nickname != null && !nickname.isBlank()) user.setNickname(nickname);
        if (avatar != null) user.setAvatar(avatar);
        if (signature != null) user.setSignature(signature);
        if (tags != null) user.setTags(String.join(",", tags));
        userRepository.save(user);
        return ApiResponse.ok("更新成功", null);
    }

    @Override
    @Transactional
    public ApiResponse<?> updateMyLook(Long userId, Map<String, Object> body) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) return ApiResponse.error("用户不存在");

        if (body.containsKey("myTopColor")) user.setMyTopColor((String) body.get("myTopColor"));
        if (body.containsKey("myPantsColor")) user.setMyPantsColor((String) body.get("myPantsColor"));
        if (body.containsKey("myShoeColor")) user.setMyShoeColor((String) body.get("myShoeColor"));
        if (body.containsKey("myHairstyle")) user.setMyHairstyle((String) body.get("myHairstyle"));
        if (body.containsKey("myGlasses")) user.setMyGlasses((Integer) body.get("myGlasses"));
        if (body.containsKey("myHasBag")) user.setMyHasBag((Integer) body.get("myHasBag"));

        userRepository.save(user);
        return ApiResponse.ok("形象已更新", null);
    }

    @Override
    public User getUserById(Long userId) {
        return userRepository.findById(userId).orElse(null);
    }
}
