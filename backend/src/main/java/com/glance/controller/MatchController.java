package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.MatchRecord;
import com.glance.service.MatchService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/matches")
@RequiredArgsConstructor
public class MatchController {

    private final MatchService matchService;

    @PostMapping("/try/{cardId}")
    public ApiResponse<MatchRecord> tryMatch(Authentication auth, @PathVariable Long cardId) {
        Long userId = (Long) auth.getPrincipal();
        return matchService.tryMatch(userId, cardId);
    }

    @GetMapping("/check")
    public ApiResponse<?> checkMatch(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return matchService.checkMatch(userId);
    }

    @GetMapping
    public ApiResponse<List<MatchRecord>> getMyMatches(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return matchService.getMyMatches(userId);
    }

    @DeleteMapping("/{matchId}")
    public ApiResponse<?> unmatch(Authentication auth, @PathVariable Long matchId) {
        Long userId = (Long) auth.getPrincipal();
        return matchService.unmatch(userId, matchId);
    }

    @GetMapping("/{matchId}/detail")
    public ApiResponse<?> getCeremonyDetail(Authentication auth, @PathVariable Long matchId) {
        Long userId = (Long) auth.getPrincipal();
        return matchService.getCeremonyDetail(userId, matchId);
    }
}
