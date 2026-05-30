package com.glance.model.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class MoodUpdateRequest {
    @NotBlank(message = "情绪类型不能为空")
    private String mood; // expect / miss / happy / quiet / bored
}
