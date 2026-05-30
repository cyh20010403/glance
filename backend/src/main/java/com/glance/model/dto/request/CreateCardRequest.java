package com.glance.model.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CreateCardRequest {
    @NotBlank
    private String scene;
    private String sceneLabel;
    private String location;
    @NotNull
    private LocalDateTime occurredAt;
    // 对方特征
    private String topColor;
    private String pantsColor;
    private Integer glasses;
    private String hairstyle;
    private Integer hasBag;
    private String shoeColor;
    private String description;
    private String imageUrl;
}
