package com.glance.model.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class SendMessageRequest {
    @NotNull
    private Long matchId;
    @NotBlank
    private String content;
    private Integer msgType = 1;
}
