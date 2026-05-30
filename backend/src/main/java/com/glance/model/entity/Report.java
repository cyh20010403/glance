package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "report")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Report {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "reporter_id", nullable = false)
    private Long reporterId;

    @Column(name = "target_id", nullable = false)
    private Long targetId;

    @Column(nullable = false, length = 50)
    private String reason;

    @Column(length = 500)
    @Builder.Default
    private String detail = "";

    @Column(nullable = false)
    @Builder.Default
    private Integer status = 0; // 0-待处理 1-已处理 2-已驳回

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "handled_at")
    private LocalDateTime handledAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
