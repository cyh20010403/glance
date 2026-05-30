package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.response.NearbyStatsResponse;
import com.glance.repository.MoodStatusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@RestController
@RequestMapping("/api/v1/nearby")
@RequiredArgsConstructor
public class NearbyController {

    private final MoodStatusRepository moodStatusRepository;

    @GetMapping("/stats")
    public ApiResponse<NearbyStatsResponse> getStats(Authentication auth) {
        LocalDateTime since = LocalDateTime.now().minusMinutes(30);
        List<Object[]> rows = moodStatusRepository.countMoodDistribution(since);

        Map<String, Long> distribution = new LinkedHashMap<>();
        int total = 0;
        for (Object[] row : rows) {
            String mood = (String) row[0];
            Long count = (Long) row[1];
            distribution.put(mood, count);
            total += count;
        }

        return ApiResponse.ok(NearbyStatsResponse.builder()
                .onlineCount(Math.max(total, 0))
                .moodDistribution(distribution)
                .build());
    }
}
