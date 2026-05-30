package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "heart_card")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HeartCard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(nullable = false, length = 50)
    private String scene; // subway/library/cafe/other

    @Column(name = "scene_label", length = 100)
    @Builder.Default
    private String sceneLabel = "";

    @Column(length = 200)
    @Builder.Default
    private String location = "";

    @Column(name = "occurred_at", nullable = false)
    private LocalDateTime occurredAt;

    @Column(name = "top_color", length = 20)
    @Builder.Default
    private String topColor = "";

    @Column(name = "pants_color", length = 20)
    @Builder.Default
    private String pantsColor = "";

    @Column(nullable = false)
    @Builder.Default
    private Integer glasses = 0; // 0-未知 1-有 2-无

    @Column(length = 30)
    @Builder.Default
    private String hairstyle = "";

    @Column(name = "has_bag")
    @Builder.Default
    private Integer hasBag = 0; // 0-未知 1-有 2-无

    @Column(name = "shoe_color", length = 20)
    @Builder.Default
    private String shoeColor = "";

    @Column(length = 300)
    @Builder.Default
    private String description = "";

    @Column(nullable = false)
    @Builder.Default
    private Integer status = 1; // 1-有效 2-已匹配 3-已过期

    @Column(name = "expire_at", nullable = false)
    private LocalDateTime expireAt;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        if (expireAt == null) {
            expireAt = createdAt.plusMinutes(30);
        }
    }
}
