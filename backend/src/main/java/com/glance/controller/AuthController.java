package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.LoginRequest;
import com.glance.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;

    @PostMapping("/login")
    public ApiResponse<?> login(@Valid @RequestBody LoginRequest request) {
        return userService.login(request);
    }

    /** MVP阶段：任意6位数字即为有效验证码 */
    @PostMapping("/send-code")
    public ApiResponse<?> sendCode(@RequestParam String phone) {
        // MVP阶段模拟发送验证码
        return ApiResponse.ok("验证码已发送");
    }
}
