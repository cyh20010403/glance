package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "match_record")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MatchRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "card_a_id", nullable = false)
    private Long cardAId;

    @Column(name = "card_b_id", nullable = false)
    private Long cardBId;

    @Column(name = "user_a_id", nullable = false)
    private Long userAId;

    @Column(name = "user_b_id", nullable = false)
    private Long userBId;

    @Column(nullable = false)
    @Builder.Default
    private Integer status = 1; // 1-已匹配 2-已解除

    @Column(name = "common_points", columnDefinition = "JSON")
    private String commonPoints; // JSON 数组字符串: ["同校","都喜欢咖啡"]

    @Column(name = "score_percent")
    @Builder.Default
    private Integer scorePercent = 0;

    @Column(name = "matched_at", nullable = false, updatable = false)
    private LocalDateTime matchedAt;

    @PrePersist
    protected void onCreate() {
        matchedAt = LocalDateTime.now();
    }
}
