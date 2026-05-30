package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "message")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "match_id", nullable = false)
    private Long matchId;

    @Column(name = "sender_id", nullable = false)
    private Long senderId;

    @Column(name = "receiver_id", nullable = false)
    private Long receiverId;

    @Column(nullable = false, length = 1000)
    private String content;

    @Column(name = "msg_type", nullable = false)
    @Builder.Default
    private Integer msgType = 1; // 1-文本 2-Emoji

    @Column(name = "is_read", nullable = false)
    @Builder.Default
    private Integer isRead = 0;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
