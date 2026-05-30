package com.glance.model.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NearbyStatsResponse {
    private int onlineCount;
    private Map<String, Long> moodDistribution;
}
