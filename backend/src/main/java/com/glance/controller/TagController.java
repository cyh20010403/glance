package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.InterestTag;
import com.glance.service.TagService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class TagController {

    private final TagService tagService;

    @GetMapping("/tags")
    public ApiResponse<List<InterestTag>> getAllTags() {
        return tagService.getAllTags();
    }

    @PutMapping("/user/tags")
    public ApiResponse<?> updateUserTags(Authentication auth, @RequestBody Map<String, List<String>> body) {
        Long userId = (Long) auth.getPrincipal();
        return tagService.updateUserTags(userId, body.get("tags"));
    }
}
