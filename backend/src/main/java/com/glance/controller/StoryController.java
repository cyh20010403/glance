package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.response.StoryResponse;
import com.glance.service.StoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/story")
@RequiredArgsConstructor
public class StoryController {

    private final StoryService storyService;

    @GetMapping("/today")
    public ApiResponse<StoryResponse> getTodayStory(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return storyService.getTodayStory(userId);
    }

    @GetMapping("/history")
    public ApiResponse<List<StoryResponse>> getHistory(
            Authentication auth,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        Long userId = (Long) auth.getPrincipal();
        return storyService.getStoryHistory(userId, page, size);
    }
}
