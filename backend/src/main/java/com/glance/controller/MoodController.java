package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.MoodUpdateRequest;
import com.glance.service.MoodService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/mood")
@RequiredArgsConstructor
public class MoodController {

    private final MoodService moodService;

    @PostMapping
    public ApiResponse<?> updateMood(Authentication auth, @Valid @RequestBody MoodUpdateRequest request) {
        Long userId = (Long) auth.getPrincipal();
        return moodService.updateMood(userId, request.getMood());
    }

    @GetMapping
    public ApiResponse<?> getMyMood(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return moodService.getMyMood(userId);
    }

    @GetMapping("/{userId}")
    public ApiResponse<?> getUserMood(@PathVariable Long userId) {
        return moodService.getUserMood(userId);
    }
}
