package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "user")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 20, unique = true)
    private String phone;

    @Column(nullable = false, length = 50)
    @Builder.Default
    private String nickname = "";

    @Column(length = 500)
    @Builder.Default
    private String avatar = "";

    @Column(nullable = false)
    @Builder.Default
    private Integer gender = 0; // 0-未知 1-男 2-女

    @Column(nullable = false)
    @Builder.Default
    private Integer age = 0;

    @Column(columnDefinition = "JSON")
    private String tags; // JSON字符串存储兴趣标签列表

    @Column(length = 200)
    @Builder.Default
    private String signature = "";

    // === 我的形象（用于双向匹配比对） ===
    @Column(name = "my_top_color", length = 20)
    @Builder.Default
    private String myTopColor = "";

    @Column(name = "my_pants_color", length = 20)
    @Builder.Default
    private String myPantsColor = "";

    @Column(name = "my_shoe_color", length = 20)
    @Builder.Default
    private String myShoeColor = "";

    @Column(name = "my_hairstyle", length = 30)
    @Builder.Default
    private String myHairstyle = "";

    @Column(name = "my_glasses")
    @Builder.Default
    private Integer myGlasses = 0; // 0-未设置 1-有 2-无

    @Column(name = "my_has_bag")
    @Builder.Default
    private Integer myHasBag = 0;

    @Column(nullable = false)
    @Builder.Default
    private Integer status = 1; // 1-正常 0-禁用

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
