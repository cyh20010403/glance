package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.CreateCardRequest;
import com.glance.model.entity.HeartCard;
import com.glance.service.HeartCardService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cards")
@RequiredArgsConstructor
public class HeartCardController {

    private final HeartCardService heartCardService;

    @PostMapping
    public ApiResponse<?> createCard(Authentication auth,
                                              @Valid @RequestBody CreateCardRequest request) {
        Long userId = (Long) auth.getPrincipal();
        return heartCardService.createCard(userId, request);
    }

    @GetMapping("/nearby")
    public ApiResponse<List<HeartCard>> getNearbyCards(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return heartCardService.getNearbyCards(userId);
    }

    /** 获取某场景下的在线人数 */
    @GetMapping("/online-count")
    public ApiResponse<?> getOnlineCount(@RequestParam(defaultValue = "campus") String scene) {
        // 统计有有效卡片的用户数（去重）
        var cards = heartCardService.getNearbyCards(0L).getData();
        long count = cards != null ? cards.stream()
                .filter(c -> c.getScene().equals(scene))
                .map(HeartCard::getUserId)
                .distinct()
                .count() : 0;
        return ApiResponse.ok(count);
    }

    @GetMapping("/mine")
    public ApiResponse<List<HeartCard>> getMyCards(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return heartCardService.getMyCards(userId);
    }
}
