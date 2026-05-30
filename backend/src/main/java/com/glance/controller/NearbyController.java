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

    // 内存缓存：记录 BLE 扫描到的设备数（最近 5 分钟）
    private final Map<String, LocalDateTime> blePings = new LinkedHashMap<>();

    @GetMapping("/stats")
    public ApiResponse<NearbyStatsResponse> getStats(Authentication auth) {
        // 清理过期 BLE 记录
        LocalDateTime cutoff = LocalDateTime.now().minusMinutes(5);
        blePings.entrySet().removeIf(e -> e.getValue().isBefore(cutoff));

        int bleCount = blePings.size();

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

        // 在线人数取 BLE 扫描数 和 活跃情绪数 的最大值
        int onlineCount = Math.max(total, bleCount);

        return ApiResponse.ok(NearbyStatsResponse.builder()
                .onlineCount(onlineCount)
                .moodDistribution(distribution)
                .build());
    }

    /** 移动端 BLE 扫描心跳上报 */
    @PostMapping("/ble-ping")
    public ApiResponse<?> blePing(Authentication auth, @RequestBody Map<String, String> body) {
        String deviceId = body.getOrDefault("deviceId",
                auth.getPrincipal().toString());
        blePings.put(deviceId, LocalDateTime.now());
        return ApiResponse.ok(Map.of("nearby", blePings.size()));
    }
}
