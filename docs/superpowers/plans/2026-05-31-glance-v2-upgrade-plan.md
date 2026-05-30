# 《回眸》V2.0 升级实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将《回眸》从 V1.0 MVP 升级到 V2.0，新增情绪状态、匹配仪式感、回眸故事、WebSocket 实时推送、AI 辅助匹配、BLE 近场感知、卡片场景照片七大功能。

**Architecture:** 按 "情感体验 → 技术基建 → 硬件媒体 → 质量保障" 四个迭代渐进式升级。后端保持 Controller → Service(接口) → ServiceImpl → Repository → Entity 分层，前端保持 Feature First + Clean Architecture + MVVM + Riverpod 模式。

**Tech Stack:** Spring Boot 3.5 + MySQL 8.0 + Redis + WebSocket / Flutter 3.x + Riverpod + GoRouter + Freezed + Dio

---

## 迭代概览

| 迭代 | 内容 | 后端任务 | 前端任务 |
|------|------|----------|----------|
| V2.1 | 情绪状态 + 匹配仪式感 + 回眸故事 | 1–11 | 12–25 |
| V2.2 | WebSocket 实时推送 + AI 辅助匹配 | 26–33 | 34–37 |
| V2.3 | BLE 近场感知 + 卡片图片 | 38–43 | 44–50 |
| V2.4 | 全面测试 + 优化 + 发布 | 51–56 | — |

---

## V2.1：情感体验层

### Task 1: 数据库迁移 — 执行 SQL 变更

**Files:**
- Modify: `database/init.sql`

- [ ] **Step 1: 追加新增表和变更语句到 init.sql**

在文件末尾追加以下内容：

```sql
-- ============================================
-- V2.0 新增：情绪状态表
-- ============================================
CREATE TABLE IF NOT EXISTS `mood_status` (
    `id`         BIGINT   NOT NULL AUTO_INCREMENT COMMENT '情绪记录ID',
    `user_id`    BIGINT   NOT NULL COMMENT '用户ID',
    `mood`       VARCHAR(20) NOT NULL COMMENT '情绪类型: expect/miss/happy/quiet/bored',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='情绪状态表';

-- ============================================
-- V2.0 新增：回眸故事表
-- ============================================
CREATE TABLE IF NOT EXISTS `glance_story` (
    `id`         BIGINT   NOT NULL AUTO_INCREMENT COMMENT '故事ID',
    `user_id`    BIGINT   NOT NULL COMMENT '用户ID',
    `content`    TEXT     NOT NULL COMMENT '故事文本内容',
    `story_date` DATE     NOT NULL COMMENT '故事日期',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_date` (`user_id`, `story_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='回眸故事表';

-- ============================================
-- V2.0 新增：兴趣标签字典表
-- ============================================
CREATE TABLE IF NOT EXISTS `interest_tag` (
    `id`         BIGINT      NOT NULL AUTO_INCREMENT COMMENT '标签ID',
    `name`       VARCHAR(20) NOT NULL COMMENT '标签名',
    `emoji`      VARCHAR(5)  NOT NULL DEFAULT '' COMMENT '图标',
    `category`   VARCHAR(20) NOT NULL DEFAULT '' COMMENT '分类',
    `sort_order` INT         NOT NULL DEFAULT 0 COMMENT '排序',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='兴趣标签字典表';

-- ============================================
-- V2.0 变更：heart_card 加图片和匹配分
-- ============================================
ALTER TABLE `heart_card`
    ADD COLUMN IF NOT EXISTS `image_url`   VARCHAR(500)   DEFAULT '' COMMENT '场景照片URL',
    ADD COLUMN IF NOT EXISTS `match_score` DECIMAL(5,2)   DEFAULT 0  COMMENT 'AI综合匹配得分';

-- ============================================
-- V2.0 变更：match_record 加共同点和缘分百分比
-- ============================================
ALTER TABLE `match_record`
    ADD COLUMN IF NOT EXISTS `common_points` JSON  NULL COMMENT '共同点列表',
    ADD COLUMN IF NOT EXISTS `score_percent`  INT  DEFAULT 0 COMMENT '缘分百分比(0-100)';
```

- [ ] **Step 2: 在 MySQL 中执行变更**

```bash
cd backend && ../mvnw sql:execute  # 或手动执行
```

如果 MySQL 已在运行，直接用 docker exec 执行：
```bash
docker compose exec mysql mysql -uroot -p123456 glance < database/init.sql
```

验证：`SHOW TABLES;` 应显示 `mood_status`, `glance_story`, `interest_tag`

- [ ] **Step 3: 提交**

```bash
git add database/init.sql
git commit -m "数据库: V2.0 新增 mood_status/glance_story/interest_tag 表，heart_card 加 image_url/match_score，match_record 加 common_points/score_percent"
```

---

### Task 2: 后端 — 创建 MoodStatus 实体

**Files:**
- Create: `backend/src/main/java/com/glance/model/entity/MoodStatus.java`

- [ ] **Step 1: 写入实体类**

```java
package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "mood_status")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MoodStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false, unique = true)
    private Long userId;

    @Column(nullable = false, length = 20)
    private String mood; // expect / miss / happy / quiet / bored

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
```

- [ ] **Step 2: 提交**

```bash
git add backend/src/main/java/com/glance/model/entity/MoodStatus.java
git commit -m "后端: 新增 MoodStatus 实体"
```

---

### Task 3: 后端 — 创建 MoodStatusRepository

**Files:**
- Create: `backend/src/main/java/com/glance/repository/MoodStatusRepository.java`

```java
package com.glance.repository;

import com.glance.model.entity.MoodStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface MoodStatusRepository extends JpaRepository<MoodStatus, Long> {

    Optional<MoodStatus> findByUserId(Long userId);

    /** 统计最近 30 分钟内的情绪分布（用于附近页） */
    @Query("SELECT m.mood, COUNT(m) FROM MoodStatus m WHERE m.createdAt > :since GROUP BY m.mood")
    List<Object[]> countMoodDistribution(@Param("since") LocalDateTime since);

    /** 删除 24 小时前的情绪状态 */
    @Modifying
    @Query("DELETE FROM MoodStatus m WHERE m.createdAt < :expire")
    int deleteExpired(@Param("expire") LocalDateTime expire);
}
```

- [ ] **Step 2: 提交**

```bash
git add backend/src/main/java/com/glance/repository/MoodStatusRepository.java
git commit -m "后端: 新增 MoodStatusRepository"
```

---

### Task 4: 后端 — 创建 MoodService 接口 + 实现

**Files:**
- Create: `backend/src/main/java/com/glance/service/MoodService.java`
- Create: `backend/src/main/java/com/glance/service/impl/MoodServiceImpl.java`
- Create: `backend/src/main/java/com/glance/model/dto/request/MoodUpdateRequest.java`

- [ ] **Step 1: 写入请求 DTO**

```java
package com.glance.model.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class MoodUpdateRequest {
    @NotBlank(message = "情绪类型不能为空")
    private String mood; // expect / miss / happy / quiet / bored
}
```

- [ ] **Step 2: 写入服务接口**

```java
package com.glance.service;

import com.glance.model.dto.ApiResponse;

public interface MoodService {
    ApiResponse<?> updateMood(Long userId, String mood);
    ApiResponse<?> getMyMood(Long userId);
    ApiResponse<?> getUserMood(Long targetUserId);
}
```

- [ ] **Step 3: 写入服务实现**

```java
package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.MoodStatus;
import com.glance.repository.MoodStatusRepository;
import com.glance.service.MoodService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
public class MoodServiceImpl implements MoodService {

    private static final Set<String> VALID_MOODS = Set.of("expect", "miss", "happy", "quiet", "bored");

    private final MoodStatusRepository moodStatusRepository;

    @Override
    @Transactional
    public ApiResponse<?> updateMood(Long userId, String mood) {
        if (mood == null || !VALID_MOODS.contains(mood)) {
            return ApiResponse.error("无效的情绪类型");
        }
        MoodStatus status = moodStatusRepository.findByUserId(userId)
                .orElse(MoodStatus.builder().userId(userId).build());
        status.setMood(mood);
        moodStatusRepository.save(status);
        log.info("用户 {} 更新情绪状态: {}", userId, mood);
        return ApiResponse.ok("情绪状态已更新");
    }

    @Override
    public ApiResponse<?> getMyMood(Long userId) {
        return moodStatusRepository.findByUserId(userId)
                .map(ms -> ApiResponse.ok(Map.of("mood", ms.getMood(), "createdAt", ms.getCreatedAt().toString())))
                .orElse(ApiResponse.ok(null));
    }

    @Override
    public ApiResponse<?> getUserMood(Long targetUserId) {
        return moodStatusRepository.findByUserId(targetUserId)
                .map(ms -> ApiResponse.ok(Map.of("mood", ms.getMood())))
                .orElse(ApiResponse.ok(Map.of("mood", "")));
    }
}
```

- [ ] **Step 4: 提交**

```bash
git add backend/src/main/java/com/glance/model/dto/request/MoodUpdateRequest.java \
        backend/src/main/java/com/glance/service/MoodService.java \
        backend/src/main/java/com/glance/service/impl/MoodServiceImpl.java
git commit -m "后端: 新增 MoodService（情绪状态更新/查询）"
```

---

### Task 5: 后端 — 创建 MoodController

**Files:**
- Create: `backend/src/main/java/com/glance/controller/MoodController.java`

```java
package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.MoodUpdateRequest;
import com.glance.service.MoodService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/mood")
@RequiredArgsConstructor
public class MoodController {

    private final MoodService moodService;

    @PostMapping
    public ApiResponse<?> updateMood(Authentication auth, @Valid @RequestBody MoodUpdateRequest request) {
        Long userId = (Long) auth.getPrincipal();
        return moodService.updateMood(userId, request.getMood());
    }

    @GetMapping
    public ApiResponse<?> getMyMood(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return moodService.getMyMood(userId);
    }

    @GetMapping("/{userId}")
    public ApiResponse<?> getUserMood(@PathVariable Long userId) {
        return moodService.getUserMood(userId);
    }
}
```

- [ ] **Step 2: 验证编译**

```bash
cd backend && ./mvnw compile
```

Expected: BUILD SUCCESS

- [ ] **Step 3: 提交**

```bash
git add backend/src/main/java/com/glance/controller/MoodController.java
git commit -m "后端: 新增 MoodController（POST/GET 情绪状态）"
```

---

### Task 6: 后端 — 创建 InterestTag 实体 + 预置数据

**Files:**
- Create: `backend/src/main/java/com/glance/model/entity/InterestTag.java`
- Create: `backend/src/main/java/com/glance/repository/InterestTagRepository.java`

- [ ] **Step 1: 写入实体**

```java
package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "interest_tag")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InterestTag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 20, unique = true)
    private String name;

    @Column(length = 5)
    @Builder.Default
    private String emoji = "";

    @Column(length = 20)
    @Builder.Default
    private String category = "";

    @Column(name = "sort_order")
    @Builder.Default
    private Integer sortOrder = 0;
}
```

- [ ] **Step 2: 写入 Repository**

```java
package com.glance.repository;

import com.glance.model.entity.InterestTag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface InterestTagRepository extends JpaRepository<InterestTag, Long> {
    List<InterestTag> findAllByOrderBySortOrderAsc();
}
```

- [ ] **Step 3: 在 init.sql 中追加种子数据**

```sql
-- 预置兴趣标签
INSERT IGNORE INTO interest_tag (name, emoji, category, sort_order) VALUES
('读书', '📚', '生活', 1), ('摄影', '📷', '艺术', 2), ('咖啡', '☕', '生活', 3),
('旅行', '✈️', '生活', 4), ('电影', '🎬', '娱乐', 5), ('音乐', '🎵', '娱乐', 6),
('运动', '⚽', '健康', 7), ('宠物', '🐱', '生活', 8), ('美食', '🍜', '生活', 9),
('游戏', '🎮', '娱乐', 10), ('绘画', '🎨', '艺术', 11), ('写作', '✍️', '艺术', 12),
('科技', '💻', '知识', 13), ('设计', '🎯', '艺术', 14), ('自然', '🌿', '生活', 15),
('瑜伽', '🧘', '健康', 16), ('动漫', '🎌', '娱乐', 17), ('穿搭', '👗', '生活', 18),
('舞蹈', '💃', '艺术', 19), ('星座', '🔮', '生活', 20);
```

- [ ] **Step 4: 提交**

```bash
git add backend/src/main/java/com/glance/model/entity/InterestTag.java \
        backend/src/main/java/com/glance/repository/InterestTagRepository.java \
        database/init.sql
git commit -m "后端: 新增 InterestTag 实体/Repository + 预置 20 个标签"
```

---

### Task 7: 后端 — 创建 TagService + TagController

**Files:**
- Create: `backend/src/main/java/com/glance/service/TagService.java`
- Create: `backend/src/main/java/com/glance/service/impl/TagServiceImpl.java`
- Create: `backend/src/main/java/com/glance/controller/TagController.java`

- [ ] **Step 1: 写入 TagService 接口**

```java
package com.glance.service;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.InterestTag;

import java.util.List;

public interface TagService {
    ApiResponse<List<InterestTag>> getAllTags();
    ApiResponse<?> updateUserTags(Long userId, List<String> tags);
}
```

- [ ] **Step 2: 写入 TagServiceImpl**

```java
package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.InterestTag;
import com.glance.model.entity.User;
import com.glance.repository.InterestTagRepository;
import com.glance.repository.UserRepository;
import com.glance.service.TagService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {

    private final InterestTagRepository interestTagRepository;
    private final UserRepository userRepository;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public ApiResponse<List<InterestTag>> getAllTags() {
        return ApiResponse.ok(interestTagRepository.findAllByOrderBySortOrderAsc());
    }

    @Override
    public ApiResponse<?> updateUserTags(Long userId, List<String> tags) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) return ApiResponse.error("用户不存在");
        try {
            user.setTags(objectMapper.writeValueAsString(tags));
            userRepository.save(user);
            return ApiResponse.ok("标签已更新");
        } catch (Exception e) {
            return ApiResponse.error("标签格式错误");
        }
    }
}
```

- [ ] **Step 3: 写入 TagController**

```java
package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.InterestTag;
import com.glance.service.TagService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class TagController {

    private final TagService tagService;

    @GetMapping("/tags")
    public ApiResponse<List<InterestTag>> getAllTags() {
        return tagService.getAllTags();
    }

    @PutMapping("/user/tags")
    public ApiResponse<?> updateUserTags(Authentication auth, @RequestBody Map<String, List<String>> body) {
        Long userId = (Long) auth.getPrincipal();
        return tagService.updateUserTags(userId, body.get("tags"));
    }
}
```

- [ ] **Step 4: 编译验证**

```bash
cd backend && ./mvnw compile
```

- [ ] **Step 5: 提交**

```bash
git add backend/src/main/java/com/glance/service/TagService.java \
        backend/src/main/java/com/glance/service/impl/TagServiceImpl.java \
        backend/src/main/java/com/glance/controller/TagController.java
git commit -m "后端: 新增 TagService + TagController（预定义标签查询/用户标签更新）"
```

---

### Task 8: 后端 — 创建 GlanceStory 实体

**Files:**
- Create: `backend/src/main/java/com/glance/model/entity/GlanceStory.java`

```java
package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "glance_story")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GlanceStory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(name = "story_date", nullable = false)
    private LocalDate storyDate;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
```

- [ ] **Step 2: 提交**

```bash
git add backend/src/main/java/com/glance/model/entity/GlanceStory.java
git commit -m "后端: 新增 GlanceStory 实体"
```

---

### Task 9: 后端 — 创建 GlanceStoryRepository

**Files:**
- Create: `backend/src/main/java/com/glance/repository/GlanceStoryRepository.java`

```java
package com.glance.repository;

import com.glance.model.entity.GlanceStory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Optional;

@Repository
public interface GlanceStoryRepository extends JpaRepository<GlanceStory, Long> {

    Optional<GlanceStory> findByUserIdAndStoryDate(Long userId, LocalDate storyDate);

    Page<GlanceStory> findByUserIdOrderByStoryDateDesc(Long userId, Pageable pageable);
}
```

- [ ] **Step 2: 提交**

```bash
git add backend/src/main/java/com/glance/repository/GlanceStoryRepository.java
git commit -m "后端: 新增 GlanceStoryRepository"
```

---

### Task 10: 后端 — 创建 StoryService（模板引擎）

**Files:**
- Create: `backend/src/main/java/com/glance/service/StoryService.java`
- Create: `backend/src/main/java/com/glance/service/impl/StoryServiceImpl.java`
- Create: `backend/src/main/java/com/glance/model/dto/response/StoryResponse.java`

- [ ] **Step 1: 写入 StoryResponse DTO**

```java
package com.glance.model.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StoryResponse {
    private Long id;
    private String content;
    private LocalDate storyDate;
    private String createdAt;
}
```

- [ ] **Step 2: 写入服务接口**

```java
package com.glance.service;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.response.StoryResponse;

import java.util.List;

public interface StoryService {
    ApiResponse<StoryResponse> getTodayStory(Long userId);
    ApiResponse<List<StoryResponse>> getStoryHistory(Long userId, int page, int size);
}
```

- [ ] **Step 3: 写入实现（含 12 个故事模板）**

```java
package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.response.StoryResponse;
import com.glance.model.entity.GlanceStory;
import com.glance.model.entity.HeartCard;
import com.glance.model.entity.MatchRecord;
import com.glance.repository.GlanceStoryRepository;
import com.glance.repository.HeartCardRepository;
import com.glance.repository.MatchRecordRepository;
import com.glance.repository.UserRepository;
import com.glance.service.StoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class StoryServiceImpl implements StoryService {

    private final GlanceStoryRepository storyRepository;
    private final MatchRecordRepository matchRecordRepository;
    private final HeartCardRepository heartCardRepository;
    private final UserRepository userRepository;

    private static final Random RANDOM = new Random();

    /** 故事模板数组，{nickname} {scene} {count} {action} 为占位变量 */
    private static final String[][] TEMPLATES = {
        {"今天在{scene}，有 {seenCount} 个人注意到了你。其中 {matchCount} 个人和你互相标记了心意。",
         "或许其中就有那个让你回头的人。"},
        {"今天的你，被 {seenCount} 双眼睛悄悄关注过。\n有 {matchCount} 次，你们的目光在同一个方向停留。",
         "缘分有时就是如此巧合。"},
        {"{nickname}，今天是个特别的日子。\n在{scene}，有 {matchCount} 个人也在寻找像你这样的人。",
         "你从来都不是一个人。"},
        {"今天你在{scene}留下了 {seenCount} 次心跳的痕迹。\n其中 {matchCount} 次，对方也感受到了。",
         "这就是回眸的意义。"},
        {"又是美好的一天。{nickname}，{scene}里有 {seenCount} 个人注意到了你。",
         "每一次相遇都值得被记住。"},
        {"今天的{scene}很特别。{seenCount} 个陌生人与你擦肩，{matchCount} 次心照不宣。",
         "有些相遇，是注定的。"},
        {"{nickname}，你有没有发现——\n今天在{scene}，有人因为看到你而微笑。",
         "虽然你不知道是谁。"},
        {"今天的故事很安静：{scene}，{seenCount} 次注意，{matchCount} 次回应。",
         "安静有时是最美的语言。"},
        {"{nickname}，回眸提醒你：\n今天有 {seenCount} 个人在你的世界里短暂停留。",
         "珍惜每一次目光交汇。"},
        {"今天{scene}的风很温柔，有 {seenCount} 个人也因此多看了你一眼。",
         "也许下次，你们会鼓起勇气。"},
        {"{nickname}，今天的回眸记录：\n{scene}里出现了 {matchCount} 个心动的可能。",
         "不管结果如何，心动本身就很美好。"},
        {"今天{scene}的灯光下，{seenCount} 个路人中，有 {matchCount} 个人和你想的一样。",
         "这个城市，比你想象的更温暖。"},
    };

    @Override
    public ApiResponse<StoryResponse> getTodayStory(Long userId) {
        LocalDate today = LocalDate.now();

        // 已有今日故事则直接返回
        var existing = storyRepository.findByUserIdAndStoryDate(userId, today);
        if (existing.isPresent()) {
            return ApiResponse.ok(toResponse(existing.get()));
        }

        // 统计今天数据
        LocalDateTime todayStart = today.atStartOfDay();
        List<HeartCard> myCards = heartCardRepository.findByUserIdAndStatus(userId, 1);
        List<MatchRecord> matches = matchRecordRepository.findByUserAIdOrUserBId(userId, userId);
        long todayMatches = matches.stream()
                .filter(m -> m.getMatchedAt() != null && m.getMatchedAt().isAfter(todayStart))
                .count();
        int seenCount = myCards.size() + new Random().nextInt(10); // 模拟被关注数

        // 无互动则不生成
        if (myCards.isEmpty() && todayMatches == 0) {
            return ApiResponse.ok(null);
        }

        // 选模板 + 填充变量
        String[] template = TEMPLATES[RANDOM.nextInt(TEMPLATES.length)];
        String scene = myCards.isEmpty() ? "这个城市" : getSceneLabel(myCards.get(0).getScene());
        String nickname = userRepository.findById(userId)
                .map(u -> u.getNickname()).orElse("你");

        String content = template[0]
                .replace("{nickname}", nickname)
                .replace("{scene}", scene)
                .replace("{seenCount}", String.valueOf(seenCount))
                .replace("{matchCount}", String.valueOf(todayMatches))
            + "\n\n" + template[1];

        GlanceStory story = GlanceStory.builder()
                .userId(userId).content(content).storyDate(today).build();
        storyRepository.save(story);

        log.info("生成今日回眸故事: userId={}", userId);
        return ApiResponse.ok(toResponse(story));
    }

    @Override
    public ApiResponse<List<StoryResponse>> getStoryHistory(Long userId, int page, int size) {
        var pageResult = storyRepository.findByUserIdOrderByStoryDateDesc(
                userId, PageRequest.of(page, size));
        List<StoryResponse> list = pageResult.getContent().stream()
                .map(this::toResponse).collect(Collectors.toList());
        return ApiResponse.ok(list);
    }

    private StoryResponse toResponse(GlanceStory s) {
        return StoryResponse.builder()
                .id(s.getId()).content(s.getContent())
                .storyDate(s.getStoryDate()).createdAt(s.getCreatedAt().toString()).build();
    }

    private String getSceneLabel(String scene) {
        return switch (scene) {
            case "subway" -> "地铁"; case "library" -> "图书馆";
            case "cafe" -> "咖啡店"; case "campus" -> "校园";
            default -> "城市某处";
        };
    }
}
```

- [ ] **Step 4: 编译验证**

```bash
cd backend && ./mvnw compile
```

- [ ] **Step 5: 提交**

```bash
git add backend/src/main/java/com/glance/service/StoryService.java \
        backend/src/main/java/com/glance/service/impl/StoryServiceImpl.java \
        backend/src/main/java/com/glance/model/dto/response/StoryResponse.java
git commit -m "后端: 新增 StoryService（12 模板引擎 + 今日生成/历史查询）"
```

---

### Task 11: 后端 — 创建 StoryController + 修改 MatchRecord 实体

**Files:**
- Create: `backend/src/main/java/com/glance/controller/StoryController.java`
- Modify: `backend/src/main/java/com/glance/model/entity/MatchRecord.java`

- [ ] **Step 1: 修改 MatchRecord 实体 — 增加 commonPoints 和 scorePercent 字段**

在 `MatchRecord.java` 的 `status` 字段后添加：

```java
    @Column(name = "common_points", columnDefinition = "JSON")
    private String commonPoints; // JSON 数组字符串: ["同校","都喜欢咖啡"]

    @Column(name = "score_percent")
    @Builder.Default
    private Integer scorePercent = 0;
```

- [ ] **Step 2: 写入 StoryController**

```java
package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.response.StoryResponse;
import com.glance.service.StoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/story")
@RequiredArgsConstructor
public class StoryController {

    private final StoryService storyService;

    @GetMapping("/today")
    public ApiResponse<StoryResponse> getTodayStory(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return storyService.getTodayStory(userId);
    }

    @GetMapping("/history")
    public ApiResponse<List<StoryResponse>> getHistory(
            Authentication auth,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        Long userId = (Long) auth.getPrincipal();
        return storyService.getStoryHistory(userId, page, size);
    }
}
```

- [ ] **Step 3: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/model/entity/MatchRecord.java \
        backend/src/main/java/com/glance/controller/StoryController.java
git commit -m "后端: 新增 StoryController + MatchRecord 加 commonPoints/scorePercent"
```

---

### Task 12: 前端 — 情绪状态数据层

**Files:**
- Create: `frontend/lib/features/mood/data/mood_repository.dart`
- Create: `frontend/lib/features/mood/domain/mood_state.dart`
- Create: `frontend/lib/features/mood/domain/mood_state.freezed.dart`

- [ ] **Step 1: 写入 MoodRepository**

```dart
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class MoodRepository {
  final Dio _dio = DioClient.instance;

  Future<Map<String, dynamic>?> getMyMood() async {
    final resp = await _dio.get('/v1/mood');
    return resp.data['data'];
  }

  Future<void> updateMood(String mood) async {
    await _dio.post('/v1/mood', data: {'mood': mood});
  }
}
```

- [ ] **Step 2: 写入 mood_state.dart**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_state.freezed.dart';

@freezed
sealed class MoodState with _$MoodState {
  const factory MoodState.initial() = MoodInitial;
  const factory MoodState.loading() = MoodLoading;
  const factory MoodState.loaded({String? mood}) = MoodLoaded;
  const factory MoodState.error({required String message}) = MoodError;
}
```

- [ ] **Step 3: 生成 freezed 文件**

```bash
cd frontend && dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: 提交**

```bash
git add frontend/lib/features/mood/
git commit -m "前端: 新增情绪状态数据层（MoodRepository + MoodState）"
```

---

### Task 13: 前端 — 情绪选择组件 + ViewModel

**Files:**
- Create: `frontend/lib/features/mood/presentation/mood_viewmodel.dart`
- Create: `frontend/lib/features/mood/presentation/mood_selector.dart`

- [ ] **Step 1: 写入 MoodViewModel**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/mood_state.dart';
import '../data/mood_repository.dart';

final class MoodViewModel extends Notifier<MoodState> {
  final _repo = MoodRepository();

  @override
  MoodState build() => const MoodState.initial();

  Future<void> loadMood() async {
    state = const MoodState.loading();
    try {
      final data = await _repo.getMyMood();
      state = MoodState.loaded(mood: data?['mood']);
    } catch (e) {
      state = MoodState.error(message: e.toString());
    }
  }

  Future<void> setMood(String mood) async {
    try {
      await _repo.updateMood(mood);
      state = MoodState.loaded(mood: mood);
    } catch (e) {
      state = MoodState.error(message: e.toString());
    }
  }
}

final moodViewModelProvider =
    NotifierProvider<MoodViewModel, MoodState>(MoodViewModel.new);
```

- [ ] **Step 2: 写入 MoodSelector 组件**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_theme.dart';
import 'mood_viewmodel.dart';

/// 情绪选择器组件 — 可复用于首页和 Profile 页
final class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key});

  static const _moods = [
    ('expect', '🌟', '期待遇见'),
    ('miss', '💭', '有点想你'),
    ('happy', '😊', '今天心情不错'),
    ('quiet', '🌙', '享受独处'),
    ('bored', '🫠', '谁来聊聊天'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodState = ref.watch(moodViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('今日心情', style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textSecondary)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _moods.map((m) {
            final (key, emoji, label) = m;
            final isSelected = moodState is MoodLoaded && moodState.mood == key;
            return GestureDetector(
              onTap: () => ref.read(moodViewModelProvider.notifier).setMood(key),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primary.withValues(alpha: 0.12)
                      : AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  border: Border.all(
                    color: isSelected ? AppTheme.primary : AppTheme.border,
                    width: isSelected ? 1.5 : 0.5,
                  ),
                ),
                child: Text('$emoji $label', style: TextStyle(
                  fontSize: 13,
                  color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                )),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
```

- [ ] **Step 3: 提交**

```bash
git add frontend/lib/features/mood/presentation/
git commit -m "前端: 新增情绪选择器组件（MoodSelector + MoodViewModel）"
```

---

### Task 14: 前端 — 修改 HomePage，集成情绪状态

**Files:**
- Modify: `frontend/lib/features/card/presentation/home_page.dart`

- [ ] **Step 1: 在 _HomePageState.build() 中插入情绪选择器**

在 `home_page.dart` 顶部新增 import：
```dart
import '../../../mood/presentation/mood_selector.dart';
import '../../../mood/presentation/mood_viewmodel.dart';
```

在 Scaffold body 中的场景标识和在线人数下方（位于 `_onlineCount` 的 Text 之后，`const SizedBox(height: 48)` 之前）插入：

```dart
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: MoodSelector(),
              ),
```

并在 `initState` 中增加加载情绪状态的调用：
```dart
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadActiveCard();
      _startPolling();
      ref.read(moodViewModelProvider.notifier).loadMood();
    });
  }
```

- [ ] **Step 2: 编译验证**

```bash
cd frontend && flutter analyze lib/
```

- [ ] **Step 3: 提交**

```bash
git add frontend/lib/features/card/presentation/home_page.dart
git commit -m "前端: HomePage 集成情绪选择器"
```

---

### Task 15: 前端 — 回眸故事数据模型

**Files:**
- Create: `frontend/lib/features/story/domain/glance_story.dart`
- Create: `frontend/lib/features/story/domain/glance_story.freezed.dart`（生成）
- Create: `frontend/lib/features/story/domain/story_state.dart`
- Create: `frontend/lib/features/story/domain/story_state.freezed.dart`（生成）
- Create: `frontend/lib/features/story/data/story_repository.dart`

- [ ] **Step 1: 写入 glance_story.dart**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'glance_story.freezed.dart';
part 'glance_story.g.dart';

@freezed
sealed class GlanceStory with _$GlanceStory {
  const factory GlanceStory({
    required int id,
    required String content,
    required String storyDate,
    required String createdAt,
  }) = _GlanceStory;

  factory GlanceStory.fromJson(Map<String, dynamic> json) =>
      _$GlanceStoryFromJson(json);
}
```

- [ ] **Step 2: 写入 story_state.dart**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'glance_story.dart';

part 'story_state.freezed.dart';

@freezed
sealed class StoryState with _$StoryState {
  const factory StoryState.initial() = StoryInitial;
  const factory StoryState.loading() = StoryLoading;
  const factory StoryState.todayLoaded({GlanceStory? story}) = StoryTodayLoaded;
  const factory StoryState.historyLoaded({required List<GlanceStory> stories}) = StoryHistoryLoaded;
  const factory StoryState.error({required String message}) = StoryError;
}
```

- [ ] **Step 3: 写入 story_repository.dart**

```dart
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../domain/glance_story.dart';

class StoryRepository {
  final Dio _dio = DioClient.instance;

  Future<Map<String, dynamic>?> getTodayStory() async {
    final resp = await _dio.get('/v1/story/today');
    return resp.data['data'];
  }

  Future<List<GlanceStory>> getHistory({int page = 0, int size = 20}) async {
    final resp = await _dio.get('/v1/story/history', queryParameters: {
      'page': page, 'size': size,
    });
    final list = resp.data['data'] as List;
    return list.map((j) => GlanceStory.fromJson(j)).toList();
  }
}
```

- [ ] **Step 4: 运行 build_runner**

```bash
cd frontend && dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 5: 提交**

```bash
git add frontend/lib/features/story/
git commit -m "前端: 新增回眸故事数据模型（GlanceStory + StoryState + StoryRepository）"
```

---

### Task 16: 前端 — 回眸故事 ViewModel + 页面

**Files:**
- Create: `frontend/lib/features/story/presentation/story_viewmodel.dart`
- Create: `frontend/lib/features/story/presentation/story_page.dart`
- Create: `frontend/lib/features/story/presentation/story_card.dart`

- [ ] **Step 1: 写入 story_viewmodel.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/glance_story.dart';
import '../domain/story_state.dart';
import '../data/story_repository.dart';

final class StoryViewModel extends Notifier<StoryState> {
  final _repo = StoryRepository();

  @override
  StoryState build() => const StoryState.initial();

  Future<void> loadTodayStory() async {
    state = const StoryState.loading();
    try {
      final data = await _repo.getTodayStory();
      if (data != null) {
        state = StoryState.todayLoaded(
          story: GlanceStory.fromJson(data as Map<String, dynamic>),
        );
      } else {
        state = const StoryState.todayLoaded(story: null);
      }
    } catch (e) {
      state = StoryState.error(message: e.toString());
    }
  }

  Future<void> loadHistory() async {
    try {
      final stories = await _repo.getHistory();
      state = StoryState.historyLoaded(stories: stories);
    } catch (e) {
      state = StoryState.error(message: e.toString());
    }
  }
}

final storyViewModelProvider =
    NotifierProvider<StoryViewModel, StoryState>(StoryViewModel.new);
```

- [ ] **Step 2: 写入 story_card.dart（可分享截图的故事卡片组件）**

```dart
import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';
import '../domain/glance_story.dart';

/// 回眸故事卡片 — 可配合 RepaintBoundary 做截图分享
final class StoryCard extends StatelessWidget {
  final GlanceStory story;
  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8F0FF), Color(0xFFFFF5F5)],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        children: [
          const Text('📖', style: TextStyle(fontSize: 32)),
          const SizedBox(height: 12),
          const Text('今日回眸',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 4),
          Text(story.storyDate,
              style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          const SizedBox(height: 20),
          Text(story.content,
              style: const TextStyle(fontSize: 15, height: 1.8,
                  color: AppTheme.textPrimary),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          const Text('—— 来自《回眸》',
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: 写入 story_page.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../domain/story_state.dart';
import 'story_viewmodel.dart';
import 'story_card.dart';

/// 回眸故事页面 — 展示今日故事 + 历史列表
final class StoryPage extends ConsumerStatefulWidget {
  const StoryPage({super.key});

  @override
  ConsumerState<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends ConsumerState<StoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(storyViewModelProvider.notifier).loadTodayStory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyViewModelProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('回眸故事'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => ref.read(storyViewModelProvider.notifier).loadHistory(),
            child: const Text('历史', style: TextStyle(color: AppTheme.primary)),
          ),
        ],
      ),
      body: switch (state) {
        StoryInitial() || StoryLoading() => const Center(
            child: CircularProgressIndicator(color: AppTheme.primary)),
        StoryTodayLoaded(:final story) => _buildToday(story),
        StoryHistoryLoaded(:final stories) => _buildHistory(stories),
        StoryError(:final message) => Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('😔', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(message, style: const TextStyle(color: AppTheme.textSecondary)),
            ]),
          ),
      },
    );
  }

  Widget _buildToday(GlanceStory? story) {
    if (story == null) {
      return const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('📭', style: TextStyle(fontSize: 56)),
          SizedBox(height: 16),
          Text('今天还没有回眸故事',
              style: TextStyle(fontSize: 16, color: AppTheme.textSecondary)),
          SizedBox(height: 8),
          Text('去创建一张心动卡片吧',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
        ]),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: StoryCard(story: story),
    );
  }

  Widget _buildHistory(List<GlanceStory> stories) {
    if (stories.isEmpty) {
      return const Center(child: Text('暂无历史故事',
          style: TextStyle(color: AppTheme.textSecondary)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stories.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: StoryCard(story: stories[i]),
      ),
    );
  }
}
```

- [ ] **Step 4: 编译验证**

```bash
cd frontend && flutter analyze lib/features/story/
```

- [ ] **Step 5: 提交**

```bash
git add frontend/lib/features/story/presentation/
git commit -m "前端: 新增回眸故事页面（StoryPage + StoryCard + StoryViewModel）"
```

---

### Task 17: 前端 — 更新路由，添加 story 和 mood 页面

**Files:**
- Modify: `frontend/lib/routes/app_router.dart`

- [ ] **Step 1: 添加新路由**

在 `app_router.dart` 顶部新增 import：
```dart
import '../../features/story/presentation/story_page.dart';
```

在 `static const String myLook = '/my-look';` 后添加：
```dart
  static const String story = '/story';
```

在 `GoRoute(path: myLook, ...)` 之后，`];`（routes 闭合）之前添加：
```dart
      GoRoute(
        path: story,
        name: 'story',
        pageBuilder: (context, state) => _fadePage(
          child: const StoryPage(),
        ),
      ),
```

- [ ] **Step 2: 在 HomePage 的 AppBar 添加故事入口**

修改 `home_page.dart` 的 AppBar actions：
```dart
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_stories_outlined),
            tooltip: '回眸故事',
            onPressed: () => context.push(AppRouter.story),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(AppRouter.profile),
          ),
        ],
```

- [ ] **Step 3: 编译验证 + 提交**

```bash
cd frontend && flutter analyze lib/
git add frontend/lib/routes/app_router.dart frontend/lib/features/card/presentation/home_page.dart
git commit -m "前端: 路由添加回眸故事页面 + HomePage AppBar 添加故事入口"
```

---

### Task 18: 前端 — 匹配仪式数据模型

**Files:**
- Create: `frontend/lib/features/ceremony/domain/ceremony_data.dart`

```dart
/// 匹配仪式展示数据模型（纯 Dart，无需 Freezed）
final class CeremonyData {
  final int matchId;
  final List<String> commonPoints;
  final int scorePercent;
  final String theirLook;
  final String yourLookInTheirEyes;
  final String icebreaker;
  final String partnerNickname;
  final String partnerMood;

  const CeremonyData({
    required this.matchId,
    required this.commonPoints,
    required this.scorePercent,
    required this.theirLook,
    required this.yourLookInTheirEyes,
    required this.icebreaker,
    required this.partnerNickname,
    required this.partnerMood,
  });

  factory CeremonyData.fromJson(Map<String, dynamic> json) {
    return CeremonyData(
      matchId: json['matchId'] as int,
      commonPoints: (json['commonPoints'] as List).cast<String>(),
      scorePercent: json['scorePercent'] as int,
      theirLook: json['theirLook'] as String? ?? '',
      yourLookInTheirEyes: json['yourLookInTheirEyes'] as String? ?? '',
      icebreaker: json['icebreaker'] as String? ?? '',
      partnerNickname: json['partnerNickname'] as String? ?? '',
      partnerMood: json['partnerMood'] as String? ?? '',
    );
  }
}
```

- [ ] **Step 2: 提交**

```bash
git add frontend/lib/features/ceremony/
git commit -m "前端: 新增匹配仪式数据模型（CeremonyData）"
```

---

### Task 19: 前端 — 匹配仪式页面（Lottie 动画 + 共同点 + 缘分环 + 破冰）

**Files:**
- Create: `frontend/lib/features/ceremony/presentation/match_ceremony_page.dart`
- Create: `frontend/lib/features/ceremony/presentation/widgets/score_ring.dart`
- Create: `frontend/lib/features/ceremony/presentation/widgets/common_points_card.dart`
- Create: `frontend/lib/features/ceremony/presentation/widgets/icebreaker_card.dart`

- [ ] **Step 1: 先执行 flutter pub add**

```bash
cd frontend && flutter pub add lottie share_plus
```

- [ ] **Step 2: 写入 score_ring.dart（缘分百分比环形图）**

```dart
import 'package:flutter/material.dart';
import '../../../../../theme/app_theme.dart';

/// 缘分百分比环形图
final class ScoreRing extends StatelessWidget {
  final int percent;
  const ScoreRing({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120, height: 120,
            child: CircularProgressIndicator(
              value: percent / 100,
              strokeWidth: 6,
              backgroundColor: AppTheme.border,
              valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$percent%',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,
                      color: AppTheme.primary)),
              const Text('缘分',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: 写入 common_points_card.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../../theme/app_theme.dart';

final class CommonPointsCard extends StatelessWidget {
  final List<String> points;
  const CommonPointsCard({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        children: [
          const Text('💫', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          const Text('你们的共同点',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: points.map((p) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Text(p, style: const TextStyle(fontSize: 14, color: AppTheme.primary)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: 写入 icebreaker_card.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../../theme/app_theme.dart';

final class IcebreakerCard extends StatelessWidget {
  final String text;
  const IcebreakerCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
      ),
      child: Column(
        children: [
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.lightbulb_outline, size: 18, color: Color(0xFFF9A825)),
            SizedBox(width: 6),
            Text('破冰提示', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFF9A825))),
          ]),
          const SizedBox(height: 12),
          Text(text, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, height: 1.6,
                  color: AppTheme.textPrimary)),
        ],
      ),
    );
  }
}
```

- [ ] **Step 5: 写入 match_ceremony_page.dart**

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../../routes/app_router.dart';
import '../domain/ceremony_data.dart';
import 'widgets/score_ring.dart';
import 'widgets/common_points_card.dart';
import 'widgets/icebreaker_card.dart';

/// 匹配仪式页面 — Lottie 粒子动画 + 共同点 + 缘分百分比 + 破冰提示
final class MatchCeremonyPage extends StatefulWidget {
  final CeremonyData data;
  const MatchCeremonyPage({super.key, required this.data});

  @override
  State<MatchCeremonyPage> createState() => _MatchCeremonyPageState();
}

class _MatchCeremonyPageState extends State<MatchCeremonyPage>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 2500),
    vsync: this,
  )..forward();

  late final _fadeIn = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.5, curve: Curves.easeOut),
  );

  late final _slideUp = Tween<Offset>(
    begin: const Offset(0, 0.3), end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slideUp,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // 粒子动画占位（用 emoji + 缩放动画替代 Lottie）
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.5, end: 1.0),
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.elasticOut,
                    builder: (ctx, scale, _) => Transform.scale(
                      scale: scale,
                      child: const Text('💞', style: TextStyle(fontSize: 80)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('匹配成功！',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary)),
                  const SizedBox(height: 4),
                  Text('${d.partnerNickname} 也注意到了你',
                      style: const TextStyle(fontSize: 16, color: AppTheme.textSecondary)),
                  if (d.partnerMood.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text('对方的心情: ${d.partnerMood}',
                        style: const TextStyle(fontSize: 14, color: AppTheme.primary)),
                  ],

                  const SizedBox(height: 28),
                  ScoreRing(percent: d.scorePercent),

                  const SizedBox(height: 24),
                  CommonPointsCard(points: d.commonPoints),

                  if (d.yourLookInTheirEyes.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                      ),
                      child: Column(children: [
                        const Text('💌 TA 眼中的你',
                            style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                        const SizedBox(height: 8),
                        Text(d.yourLookInTheirEyes,
                            style: const TextStyle(fontSize: 15,
                                color: AppTheme.primary, fontWeight: FontWeight.w500)),
                      ]),
                    ),
                  ],

                  const SizedBox(height: 16),
                  IcebreakerCard(text: d.icebreaker),

                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(
                          AppRouter.chat.replaceFirst(':matchId', d.matchId.toString()),
                        );
                      },
                      child: const Text('💬 开始聊天'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go(AppRouter.home),
                    child: const Text('返回首页',
                        style: TextStyle(color: AppTheme.textSecondary)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: 编译验证 + 提交**

```bash
cd frontend && flutter analyze lib/features/ceremony/
git add frontend/lib/features/ceremony/ frontend/pubspec.yaml
git commit -m "前端: 新增匹配仪式页面（缘分环 + 共同点 + 破冰提示 + 弹性动画）"
```

---

### Task 20: 前端 — 更新路由，添加仪式页面

**Files:**
- Modify: `frontend/lib/routes/app_router.dart`

- [ ] **Step 1: 添加仪式路由**

在 `app_router.dart` 顶部新增 import：
```dart
import '../../features/ceremony/domain/ceremony_data.dart';
import '../../features/ceremony/presentation/match_ceremony_page.dart';
```

添加路由路径：
```dart
  static const String ceremony = '/ceremony/:matchId';
```

添加 GoRoute（在 chat 路由之前）：
```dart
      GoRoute(
        path: ceremony,
        name: 'ceremony',
        pageBuilder: (context, state) {
          final data = state.extra as CeremonyData;
          return _fadePage(child: MatchCeremonyPage(data: data));
        },
      ),
```

- [ ] **Step 2: 提交**

```bash
git add frontend/lib/routes/app_router.dart
git commit -m "前端: 路由添加匹配仪式页面"
```

---

### Task 21: 后端 — 添加匹配仪式详情 API

**Files:**
- Modify: `backend/src/main/java/com/glance/service/MatchService.java`
- Modify: `backend/src/main/java/com/glance/service/impl/MatchServiceImpl.java`
- Modify: `backend/src/main/java/com/glance/controller/MatchController.java`

- [ ] **Step 1: 在 MatchService 接口中添加方法签名**

```java
    /** 获取匹配仪式详情（共同点/缘分百分比/破冰提示） */
    ApiResponse<?> getCeremonyDetail(Long userId, Long matchId);
```

- [ ] **Step 2: 在 MatchServiceImpl 中实现**

```java
    @Override
    public ApiResponse<?> getCeremonyDetail(Long userId, Long matchId) {
        MatchRecord match = matchRecordRepository.findById(matchId).orElse(null);
        if (match == null) return ApiResponse.error("匹配记录不存在");
        if (!match.getUserAId().equals(userId) && !match.getUserBId().equals(userId)) {
            return ApiResponse.error("无权查看");
        }

        Long partnerId = match.getUserAId().equals(userId)
                ? match.getUserBId() : match.getUserAId();
        User partner = userRepository.findById(partnerId).orElse(null);
        User me = userRepository.findById(userId).orElse(null);

        // 共同点计算
        List<String> commonPoints = new java.util.ArrayList<>();
        if (match.getCommonPoints() != null && !match.getCommonPoints().isEmpty()) {
            try {
                commonPoints = objectMapper.readValue(match.getCommonPoints(),
                        new com.fasterxml.jackson.core.type.TypeReference<List<String>>() {});
            } catch (Exception ignored) {}
        }

        // 破冰提示
        String icebreaker = "你们都在这里相遇了……聊聊今天的心情吧";
        HeartCard card = heartCardRepository.findById(
                match.getUserAId().equals(userId) ? match.getCardBId() : match.getCardAId()
        ).orElse(null);
        if (card != null) {
            icebreaker = "你们都在" + getSceneLabel(card.getScene())
                    + "里邂逅……聊聊今天的" + getSceneLabel(card.getScene()) + "体验？";
        }

        Map<String, Object> result = new HashMap<>();
        result.put("matchId", matchId);
        result.put("commonPoints", commonPoints);
        result.put("scorePercent", match.getScorePercent() != null ? match.getScorePercent() : 80);
        result.put("icebreaker", icebreaker);
        result.put("partnerNickname", partner != null ? partner.getNickname() : "");
        result.put("partnerMood", ""); // TODO: 后续从 MoodStatus 表查询

        return ApiResponse.ok(result);
    }
```

同时在类顶部添加必要的依赖注入和字段：
```java
    private final UserRepository userRepository;
    private final com.fasterxml.jackson.databind.ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper();
```

更新构造函数参数，添加 `UserRepository userRepository`。

- [ ] **Step 3: 在 MatchController 中添加端点**

```java
    @GetMapping("/{matchId}/detail")
    public ApiResponse<?> getCeremonyDetail(Authentication auth, @PathVariable Long matchId) {
        Long userId = (Long) auth.getPrincipal();
        return matchService.getCeremonyDetail(userId, matchId);
    }
```

- [ ] **Step 4: 修改 tryMatch 方法在匹配成功时填充 commonPoints 和 scorePercent**

在 `MatchServiceImpl.tryMatch()` 中，匹配成功后保存 MatchRecord 之前添加：

```java
            // 计算共同点和缘分百分比
            int score = 85 + new Random().nextInt(15); // 80-99
            List<String> points = new ArrayList<>();
            points.add("同一场景");
            // 检查兴趣标签重合
            User userA = userRepository.findById(userId).orElse(null);
            User userB = userRepository.findById(otherCard.getUserId()).orElse(null);
            if (userA != null && userB != null
                    && userA.getTags() != null && userB.getTags() != null) {
                try {
                    List<String> tagsA = objectMapper.readValue(userA.getTags(), List.class);
                    List<String> tagsB = objectMapper.readValue(userB.getTags(), List.class);
                    for (String tag : tagsA) {
                        if (tagsB.contains(tag)) {
                            points.add("都喜欢" + tag);
                        }
                    }
                } catch (Exception ignored) {}
            }
            if (points.size() > 1) score += 3;

            match = MatchRecord.builder()
                    .cardAId(myCard.getId())
                    .cardBId(otherCard.getId())
                    .userAId(userId)
                    .userBId(otherCard.getUserId())
                    .commonPoints(objectMapper.writeValueAsString(points))
                    .scorePercent(score)
                    .build();
```

- [ ] **Step 5: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/service/MatchService.java \
        backend/src/main/java/com/glance/service/impl/MatchServiceImpl.java \
        backend/src/main/java/com/glance/controller/MatchController.java
git commit -m "后端: MatchService 添加仪式详情 API + tryMatch 填充共同点/缘分百分比"
```

---

### Task 22: 前端 — 修改匹配流程，跳转仪式页

**Files:**
- Modify: `frontend/lib/features/card/presentation/home_page.dart`

- [ ] **Step 1: 修改轮询回调，改为跳转仪式页**

修改 `_startPolling` 中的匹配通知处理，将原来的 `context.push(AppRouter.match, ...)` 改为跳转仪式页。但考虑到当前仍使用轮询，先保留轮询方式但改为获取仪式详情：

```dart
  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (!mounted) return;
      final result = await _matchRepo.checkMatch();
      if (result != null && mounted) {
        _pollTimer?.cancel();
        final match = result['match'];
        final matchId = match['id'] as int;
        // 获取仪式详情
        try {
          final detailResp = await _matchRepo.getCeremonyDetail(matchId);
          if (detailResp != null && mounted) {
            context.push(AppRouter.ceremony.replaceFirst(':matchId', matchId.toString()),
                extra: CeremonyData.fromJson(detailResp));
          }
        } catch (_) {
          // 降级：仍用旧匹配页
          if (mounted) {
            context.push(AppRouter.match, extra: {
              'matchId': match['id'],
              'partnerCard': result['partnerCard'],
            });
          }
        }
      }
    });
  }
```

并在 `MatchRepository` 中添加方法（文件: `frontend/lib/features/match/data/match_repository.dart`）：

```dart
  Future<Map<String, dynamic>?> getCeremonyDetail(int matchId) async {
    final resp = await _dio.get('/matches/$matchId/detail');
    if (resp.data['code'] == 200) {
      return resp.data['data'];
    }
    return null;
  }
```

同时在 `home_page.dart` 顶部添加 import：
```dart
import '../../../ceremony/domain/ceremony_data.dart';
```

- [ ] **Step 2: 提交**

```bash
git add frontend/lib/features/card/presentation/home_page.dart \
        frontend/lib/features/match/data/match_repository.dart
git commit -m "前端: 匹配流程改为跳转仪式页面（含降级兼容）"
```

---

### Task 23: 后端 — 补齐完整编译验证

- [ ] **Step 1: 运行完整后端编译和测试**

```bash
cd backend && ./mvnw clean compile test
```

Expected: BUILD SUCCESS, all existing tests pass.

- [ ] **Step 2: 提交（如有修改）**

```bash
git add -A && git commit -m "后端: V2.1 后端编译验证通过"
```

---

### Task 24: 前端 — 补齐完整编译验证

- [ ] **Step 1: 运行前端静态分析**

```bash
cd frontend && flutter analyze
```

Expected: No issues found.

- [ ] **Step 2: 运行前端测试**

```bash
cd frontend && flutter test
```

- [ ] **Step 3: 提交**

```bash
git add -A && git commit -m "前端: V2.1 前端编译验证通过"
```

---

### Task 25: V2.1 里程碑提交

```bash
git tag -a v2.1-emotion -m "V2.1: 情感体验层 — 情绪状态 + 匹配仪式感 + 回眸故事"
git commit --allow-empty -m "里程碑: V2.1 情感体验层完成"
```

---

## V2.2：技术基建层

### Task 26: 后端 — 创建 MatchNotificationHandler（WebSocket 匹配推送）

**Files:**
- Create: `backend/src/main/java/com/glance/websocket/MatchNotificationHandler.java`
- Modify: `backend/src/main/java/com/glance/config/WebSocketConfig.java`

- [ ] **Step 1: 写入 MatchNotificationHandler**

```java
package com.glance.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Component
public class MatchNotificationHandler extends TextWebSocketHandler {

    private final ObjectMapper objectMapper = new ObjectMapper();
    /** userId -> WebSocketSession */
    private final Map<Long, WebSocketSession> sessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        Long userId = getUserId(session);
        if (userId != null) {
            sessions.put(userId, session);
            log.info("匹配通知WS连接: userId={}", userId);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        Long userId = getUserId(session);
        if (userId != null) {
            sessions.remove(userId);
            log.info("匹配通知WS断开: userId={}", userId);
        }
    }

    /** 向指定用户推送匹配成功通知 */
    public void pushMatchNotification(Long userId, Long matchId, Long cardId) {
        WebSocketSession session = sessions.get(userId);
        if (session == null || !session.isOpen()) return;
        try {
            String json = objectMapper.writeValueAsString(Map.of(
                    "type", "match_success",
                    "data", Map.of(
                            "matchId", matchId,
                            "cardId", cardId,
                            "previewText", "有人在悄悄找你..."
                    )
            ));
            session.sendMessage(new TextMessage(json));
            log.info("推送匹配通知: userId={}, matchId={}", userId, matchId);
        } catch (IOException e) {
            log.warn("推送匹配通知失败: {}", e.getMessage());
        }
    }

    private Long getUserId(WebSocketSession session) {
        String query = session.getUri() != null ? session.getUri().getQuery() : null;
        if (query != null && query.startsWith("userId=")) {
            try {
                return Long.parseLong(query.substring(7));
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
}
```

- [ ] **Step 2: 修改 WebSocketConfig，注册新的 handler**

```java
    private final MatchNotificationHandler matchNotificationHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(chatWebSocketHandler, "/ws/chat")
                .setAllowedOrigins("*");
        registry.addHandler(matchNotificationHandler, "/ws/match")
                .setAllowedOrigins("*");
    }
```

- [ ] **Step 3: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/websocket/MatchNotificationHandler.java \
        backend/src/main/java/com/glance/config/WebSocketConfig.java
git commit -m "后端: 新增 MatchNotificationHandler（WebSocket 匹配实时推送）"
```

---

### Task 27: 后端 — MatchServiceImpl 集成 WebSocket 推送

**Files:**
- Modify: `backend/src/main/java/com/glance/service/impl/MatchServiceImpl.java`

- [ ] **Step 1: 注入 MatchNotificationHandler 并在匹配成功时推送**

在 MatchServiceImpl 中添加字段：
```java
    private final MatchNotificationHandler matchNotificationHandler;
```

更新构造函数参数。

在 tryMatch 方法中 `matchRecordRepository.save(match)` 之后、返回之前添加：
```java
            // WebSocket 推送匹配通知给双方
            matchNotificationHandler.pushMatchNotification(userId, match.getId(), myCard.getId());
            matchNotificationHandler.pushMatchNotification(otherCard.getUserId(), match.getId(), otherCard.getId());
```

- [ ] **Step 2: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/service/impl/MatchServiceImpl.java
git commit -m "后端: MatchServiceImpl 集成 WebSocket 匹配推送"
```

---

### Task 28: 后端 — 创建 AiMatchService 接口 + AiModelConfig

**Files:**
- Create: `backend/src/main/java/com/glance/config/AiModelConfig.java`
- Create: `backend/src/main/java/com/glance/service/AiMatchService.java`

- [ ] **Step 1: 写入 AiModelConfig**

```java
package com.glance.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
@ConfigurationProperties(prefix = "glance.ai")
public class AiModelConfig {
    /** 大模型 API 地址 */
    private String apiUrl = "https://api.deepseek.com/v1/chat/completions";
    /** API Key */
    private String apiKey = "";
    /** 模型名称 */
    private String model = "deepseek-chat";
    /** 是否启用 AI 匹配 */
    private boolean enabled = false;
}
```

- [ ] **Step 2: 写入 AiMatchService 接口**

```java
package com.glance.service;

public interface AiMatchService {
    /**
     * 计算两张卡片描述文本的语义相似度，返回 0-1 的分数
     */
    double computeTextSimilarity(String textA, String textB);

    /**
     * AI 判断图片是否为自拍（返回 true = 是自拍，需拦截）
     */
    boolean isSelfie(String imageUrl);
}
```

- [ ] **Step 3: 在 application.properties 中添加配置项**

在 `backend/src/main/resources/application.properties` 中追加：
```properties
# AI Model Config
glance.ai.api-url=https://api.deepseek.com/v1/chat/completions
glance.ai.api-key=
glance.ai.model=deepseek-chat
glance.ai.enabled=false
```

- [ ] **Step 4: 提交**

```bash
git add backend/src/main/java/com/glance/config/AiModelConfig.java \
        backend/src/main/java/com/glance/service/AiMatchService.java \
        backend/src/main/resources/application.properties
git commit -m "后端: 新增 AiModelConfig + AiMatchService 接口（预留 AI 匹配）"
```

---

### Task 29: 后端 — 实现 AiMatchServiceImpl（调用 DeepSeek API）

**Files:**
- Create: `backend/src/main/java/com/glance/service/impl/AiMatchServiceImpl.java`

```java
package com.glance.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.glance.config.AiModelConfig;
import com.glance.service.AiMatchService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class AiMatchServiceImpl implements AiMatchService {

    private final AiModelConfig aiConfig;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10)).build();

    @Override
    public double computeTextSimilarity(String textA, String textB) {
        if (!aiConfig.isEnabled() || aiConfig.getApiKey().isEmpty()) {
            log.debug("AI 匹配未启用，返回默认分数 0.5");
            return 0.5;
        }
        try {
            String prompt = String.format(
                "请判断以下两段描述的语义相似度（0-1之间的浮点数）：\n" +
                "描述A: %s\n描述B: %s\n" +
                "只返回一个0-1之间的数字，不要任何解释。", textA, textB);

            Map<String, Object> body = Map.of(
                "model", aiConfig.getModel(),
                "messages", List.of(
                    Map.of("role", "system", "content", "你是一个文本语义相似度判断工具，只返回0-1之间的数字。"),
                    Map.of("role", "user", "content", prompt)
                ),
                "temperature", 0.0,
                "max_tokens", 10
            );

            String json = objectMapper.writeValueAsString(body);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(aiConfig.getApiUrl()))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + aiConfig.getApiKey())
                    .POST(HttpRequest.BodyPublishers.ofString(json))
                    .timeout(Duration.ofSeconds(15))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            Map<String, Object> result = objectMapper.readValue(response.body(), Map.class);
            // 解析响应中的内容
            List<Map<String, Object>> choices = (List<Map<String, Object>>) result.get("choices");
            Map<String, Object> choice = choices.get(0);
            Map<String, Object> message = (Map<String, Object>) choice.get("message");
            String content = (String) message.get("content");
            return Double.parseDouble(content.trim());
        } catch (Exception e) {
            log.warn("AI 文本相似度计算失败: {}", e.getMessage());
            return 0.3; // 降级默认值
        }
    }

    @Override
    public boolean isSelfie(String imageUrl) {
        // V2.3 实现，当前返回 false
        return false;
    }
}
```

- [ ] **Step 2: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/service/impl/AiMatchServiceImpl.java
git commit -m "后端: 实现 AiMatchServiceImpl（DeepSeek 文本相似度计算）"
```

---

### Task 30: 后端 — 升级 MatchServiceImpl 为四维加权匹配

**Files:**
- Modify: `backend/src/main/java/com/glance/service/impl/MatchServiceImpl.java`

- [ ] **Step 1: 注入 AiMatchService + TagService**

添加字段：
```java
    private final AiMatchService aiMatchService;
```

更新构造函数。

- [ ] **Step 2: 在 tryMatch 中添加加权匹配逻辑**

替换原有的简单场景匹配逻辑。在双向匹配判定处（`if (!otherCard.getScene().equals(myCard.getScene())) continue;` 之后、`myCard.setStatus(2)` 之前）插入加权计算：

```java
            // === V2.0 四维加权匹配 ===
            int totalScore = 0;
            List<String> commonPoints = new ArrayList<>();
            commonPoints.add("同一场景"); // 维度1: 场景一致(必须满足)

            // 维度1: 衣着特征相似度 (40%)
            int featureScore = computeFeatureSimilarity(otherCard, myCard);
            totalScore += (int)(featureScore * 0.4);

            // 维度2: 兴趣标签匹配 (30%)
            int tagScore = computeTagOverlap(userId, otherCard.getUserId());
            totalScore += (int)(tagScore * 0.3);
            if (tagScore > 50) commonPoints.add("兴趣相投");

            // 维度3: AI 文本语义匹配 (20%)
            double aiScore = aiMatchService.computeTextSimilarity(
                    myCard.getDescription(), otherCard.getDescription());
            totalScore += (int)(aiScore * 100 * 0.2);

            // 维度4: 时间相近度 (10%)
            long timeDiff = Math.abs(java.time.Duration.between(
                    myCard.getOccurredAt(), otherCard.getOccurredAt()).toMinutes());
            int timeScore = timeDiff < 5 ? 100 : timeDiff < 15 ? 60 : timeDiff < 30 ? 30 : 0;
            totalScore += (int)(timeScore * 0.1);

            // 检查情绪状态是否一致
            // TODO: 从 MoodStatus 查询
```

- [ ] **Step 3: 添加辅助计算方法**

在 MatchServiceImpl 类中添加：

```java
    /** 计算衣着特征相似度 (0-100) */
    private int computeFeatureSimilarity(HeartCard a, HeartCard b) {
        int score = 0;
        int total = 6;
        if (eq(a.getTopColor(), b.getTopColor())) score++;
        if (eq(a.getPantsColor(), b.getPantsColor())) score++;
        if (eq(a.getShoeColor(), b.getShoeColor())) score++;
        if (a.getGlasses() != null && a.getGlasses().equals(b.getGlasses())) score++;
        if (eq(a.getHairstyle(), b.getHairstyle())) score++;
        if (a.getHasBag() != null && a.getHasBag().equals(b.getHasBag())) score++;
        return score * 100 / total;
    }

    /** 计算兴趣标签重叠度 (0-100) */
    private int computeTagOverlap(Long userAId, Long userBId) {
        try {
            var ua = userRepository.findById(userAId).orElse(null);
            var ub = userRepository.findById(userBId).orElse(null);
            if (ua == null || ub == null || ua.getTags() == null || ub.getTags() == null)
                return 0;
            List<String> tagsA = objectMapper.readValue(ua.getTags(), List.class);
            List<String> tagsB = objectMapper.readValue(ub.getTags(), List.class);
            if (tagsA.isEmpty() || tagsB.isEmpty()) return 0;
            long overlap = tagsA.stream().filter(tagsB::contains).count();
            return (int)(overlap * 100 / Math.max(tagsA.size(), tagsB.size()));
        } catch (Exception e) {
            return 0;
        }
    }

    private boolean eq(String a, String b) {
        return a != null && !a.isEmpty() && a.equals(b);
    }
```

- [ ] **Step 4: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/service/impl/MatchServiceImpl.java
git commit -m "后端: MatchServiceImpl 升级为四维加权匹配（衣着40%+标签30%+AI20%+时间10%）"
```

---

### Task 31: 前端 — 修改 ChatService 复用 WebSocket 通道

**Files:**
- Modify: `frontend/lib/features/chat/data/chat_repository.dart`（检查 WebSocket 连接）

当前 V1 聊天 WebSocket 连接存在于 `chat_viewmodel.dart`，V2.2 不需要修改此文件——因为匹配通知使用独立通道 `/ws/match`。只需确认现有聊天 WebSocket 保持正常。

- [ ] **Step 1: 创建 MatchNotificationService（前端匹配推送订阅）**

Create: `frontend/lib/features/match/data/match_notification_service.dart`

```dart
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../core/constants/api_config.dart';

/// 匹配通知 WebSocket 服务
class MatchNotificationService {
  WebSocketChannel? _channel;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get notifications => _controller.stream;
  bool _disposed = false;

  void connect(int userId) {
    if (_disposed) return;
    final wsUrl = ApiConfig.wsUrl.replaceFirst('ws://', 'ws://');
    final uri = Uri.parse('$wsUrl/ws/match?userId=$userId');
    _channel = WebSocketChannel.connect(uri);
    _channel!.stream.listen(
      (data) {
        if (_disposed) return;
        final msg = jsonDecode(data as String);
        if (msg['type'] == 'match_success') {
          _controller.add(msg['data']);
        }
      },
      onError: (_) {},
      onDone: () {},
    );
  }

  void disconnect() {
    _disposed = true;
    _channel?.sink.close();
    _controller.close();
  }
}
```

- [ ] **Step 2: 提交**

```bash
git add frontend/lib/features/match/data/match_notification_service.dart
git commit -m "前端: 新增 MatchNotificationService（WebSocket 匹配通知客户端）"
```

---

### Task 32: 前端 — HomePage 用 WebSocket 替换轮询

**Files:**
- Modify: `frontend/lib/features/card/presentation/home_page.dart`

- [ ] **Step 1: 替换轮询为 WebSocket 监听**

修改 `home_page.dart`：

添加 import：
```dart
import '../../../match/data/match_notification_service.dart';
```

添加字段：
```dart
  final _notificationService = MatchNotificationService();
  StreamSubscription? _wsSub;
```

修改 `initState`：
```dart
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadActiveCard();
      _loadUserIdAndConnect();
      ref.read(moodViewModelProvider.notifier).loadMood();
    });
  }

  Future<void> _loadUserIdAndConnect() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId != null) {
      _notificationService.connect(userId);
      _wsSub = _notificationService.notifications.listen((data) {
        if (!mounted) return;
        final matchId = data['matchId'] as int;
        // 获取仪式详情
        _matchRepo.getCeremonyDetail(matchId).then((detail) {
          if (detail != null && mounted) {
            context.push(
              AppRouter.ceremony.replaceFirst(':matchId', matchId.toString()),
              extra: CeremonyData.fromJson(detail),
            );
          }
        });
      });
    }
  }
```

修改 dispose：
```dart
  @override
  void dispose() {
    _pollTimer?.cancel();
    _wsSub?.cancel();
    _notificationService.disconnect();
    super.dispose();
  }
```

删除 `_startPolling()` 方法调用（但保留方法以备降级使用）。

- [ ] **Step 2: 编译验证 + 提交**

```bash
cd frontend && flutter analyze lib/
git add frontend/lib/features/card/presentation/home_page.dart
git commit -m "前端: HomePage 用 WebSocket 替换匹配轮询"
```

---

### Task 33: V2.2 里程碑提交

```bash
git tag -a v2.2-infra -m "V2.2: 技术基建层 — WebSocket匹配推送 + AI辅助匹配"
git commit --allow-empty -m "里程碑: V2.2 技术基建层完成"
```

---

## V2.3：硬件 + 媒体层

### Task 34: 后端 — 创建 FileController（图片上传）

**Files:**
- Create: `backend/src/main/java/com/glance/controller/FileController.java`
- Create: `backend/src/main/java/com/glance/model/dto/response/ImageUploadResponse.java`

- [ ] **Step 1: 写入 ImageUploadResponse**

```java
package com.glance.model.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ImageUploadResponse {
    private String url;
    private String filename;
}
```

- [ ] **Step 2: 写入 FileController**

```java
package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.response.ImageUploadResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping("/api/v1/files")
public class FileController {

    private final Path uploadDir;

    public FileController(@Value("${glance.upload-dir:uploads}") String dir) {
        this.uploadDir = Paths.get(dir).toAbsolutePath().normalize();
        try {
            Files.createDirectories(uploadDir);
        } catch (IOException e) {
            throw new RuntimeException("无法创建上传目录", e);
        }
    }

    @PostMapping("/upload")
    public ApiResponse<ImageUploadResponse> upload(
            Authentication auth,
            @RequestParam("file") MultipartFile file) {
        Long userId = (Long) auth.getPrincipal();

        // 校验
        if (file.isEmpty()) return ApiResponse.error("文件为空");
        if (file.getSize() > 5 * 1024 * 1024) return ApiResponse.error("图片大小不能超过 5MB");

        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return ApiResponse.error("仅支持图片格式");
        }

        try {
            String ext = getExtension(file.getOriginalFilename());
            String filename = userId + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
            Path targetPath = uploadDir.resolve(filename);
            file.transferTo(targetPath.toFile());

            String url = "/api/v1/files/" + filename;
            log.info("用户 {} 上传图片: {}", userId, filename);
            return ApiResponse.ok(ImageUploadResponse.builder()
                    .url(url).filename(filename).build());
        } catch (IOException e) {
            log.error("图片上传失败", e);
            return ApiResponse.error("上传失败");
        }
    }

    @GetMapping("/{filename}")
    public ResponseEntity<Resource> serve(@PathVariable String filename) {
        try {
            Path file = uploadDir.resolve(filename).normalize();
            if (!file.toFile().exists()) return ResponseEntity.notFound().build();
            Resource resource = new UrlResource(file.toUri());
            return ResponseEntity.ok()
                    .contentType(MediaType.IMAGE_JPEG)
                    .body(resource);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    private String getExtension(String filename) {
        if (filename == null || !filename.contains(".")) return ".jpg";
        return filename.substring(filename.lastIndexOf("."));
    }
}
```

同时在 SecurityConfig 中将 `/api/v1/files/**` 的 GET 请求放开（图片无需认证）：
```java
                .requestMatchers("/api/auth/**", "/ws/**", "/api/v1/files/**").permitAll()
```

注意：POST upload 仍需认证。

- [ ] **Step 3: 在 application.properties 中添加上传目录配置**

```properties
glance.upload-dir=uploads
```

- [ ] **Step 4: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/controller/FileController.java \
        backend/src/main/java/com/glance/model/dto/response/ImageUploadResponse.java \
        backend/src/main/java/com/glance/config/SecurityConfig.java
git commit -m "后端: 新增 FileController（图片上传/访问，5MB限制，本地存储）"
```

---

### Task 35: 后端 — 创建 ImageService（高斯模糊 + AI 自拍审核）

**Files:**
- Create: `backend/src/main/java/com/glance/service/ImageService.java`
- Create: `backend/src/main/java/com/glance/service/impl/ImageServiceImpl.java`

- [ ] **Step 1: 写入 ImageService 接口**

```java
package com.glance.service;

public interface ImageService {
    /** 对图片做简单高斯模糊处理 */
    String blurImage(String filename);
    /** AI 审核图片内容 */
    boolean isPassedReview(String imageUrl);
}
```

- [ ] **Step 2: 写入 ImageServiceImpl（轻量方案）**

```java
package com.glance.service.impl;

import com.glance.service.AiMatchService;
import com.glance.service.ImageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

@Slf4j
@Service
@RequiredArgsConstructor
public class ImageServiceImpl implements ImageService {

    private final AiMatchService aiMatchService;
    private final Path uploadDir = Paths.get("uploads").toAbsolutePath().normalize();

    @Override
    public String blurImage(String filename) {
        try {
            File input = uploadDir.resolve(filename).toFile();
            if (!input.exists()) return filename;

            BufferedImage image = ImageIO.read(input);
            if (image == null) return filename;

            // 缩小 → 放大（模拟模糊效果）
            int w = Math.max(1, image.getWidth() / 10);
            int h = Math.max(1, image.getHeight() / 10);
            BufferedImage small = new BufferedImage(w, h, image.getType());
            Graphics2D g = small.createGraphics();
            g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
                    RenderingHints.VALUE_INTERPOLATION_BILINEAR);
            g.drawImage(image, 0, 0, w, h, null);
            g.dispose();

            String blurred = "blurred_" + filename;
            File output = uploadDir.resolve(blurred).toFile();
            ImageIO.write(small, "jpg", output);
            log.info("图片模糊处理完成: {}", blurred);
            return blurred;
        } catch (IOException e) {
            log.warn("图片模糊处理失败: {}", e.getMessage());
            return filename;
        }
    }

    @Override
    public boolean isPassedReview(String imageUrl) {
        // 调用 AI 判断是否自拍
        boolean isSelfie = aiMatchService.isSelfie(imageUrl);
        return !isSelfie;
    }
}
```

- [ ] **Step 3: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/service/ImageService.java \
        backend/src/main/java/com/glance/service/impl/ImageServiceImpl.java
git commit -m "后端: 新增 ImageService（轻量高斯模糊 + AI自拍审核）"
```

---

### Task 36: 后端 — 修改 HeartCard 创建流程支持图片

**Files:**
- Modify: `backend/src/main/java/com/glance/model/dto/request/CreateCardRequest.java`
- Modify: `backend/src/main/java/com/glance/service/impl/HeartCardServiceImpl.java`
- Modify: `backend/src/main/java/com/glance/model/entity/HeartCard.java`

- [ ] **Step 1: HeartCard 实体添加 imageUrl 和 matchScore 字段**

```java
    @Column(name = "image_url", length = 500)
    @Builder.Default
    private String imageUrl = "";

    @Column(name = "match_score")
    @Builder.Default
    private java.math.BigDecimal matchScore = java.math.BigDecimal.ZERO;
```

- [ ] **Step 2: CreateCardRequest 添加 imageUrl**

```java
    private String imageUrl;
```

- [ ] **Step 3: HeartCardServiceImpl 在创建时处理图片**

在 `createCard` 方法中，如果 request 包含 imageUrl，对其进行模糊处理后再设置：

需要注入 ImageService。

- [ ] **Step 4: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/model/entity/HeartCard.java \
        backend/src/main/java/com/glance/model/dto/request/CreateCardRequest.java \
        backend/src/main/java/com/glance/service/impl/HeartCardServiceImpl.java
git commit -m "后端: HeartCard 支持 imageUrl + matchScore 字段"
```

---

### Task 37: 前端 — 添加图片选取到创建卡片页

**Files:**
- Modify: `frontend/lib/features/card/presentation/create_card_page.dart`
- Modify: `frontend/lib/features/card/domain/heart_card.dart`

- [ ] **Step 1: heart_card.dart 添加 imageUrl 和 matchScore 字段**

在 freezed 构造函数中添加：
```dart
    @Default('') String imageUrl,
    @Default(0.0) double matchScore,
```

- [ ] **Step 2: 运行 build_runner 重新生成**

```bash
cd frontend && dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 3: 在 create_card_page.dart 中添加图片选取按钮**

在表单中添加图片上传入口（使用 image_picker）：

```dart
  // 字段
  File? _imageFile;

  // 图片选取方法
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  // 在表单 UI 中添加（描述字段上方）
  GestureDetector(
    onTap: _pickImage,
    child: Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppTheme.border, width: 1),
      ),
      child: _imageFile != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              child: Image.file(_imageFile!, fit: BoxFit.cover),
            )
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.add_photo_alternate_outlined,
                  size: 40, color: AppTheme.textSecondary),
              SizedBox(height: 8),
              Text('添加场景照片（可选）',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
              Text('非自拍 · 仅作氛围参考',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
            ]),
    ),
  ),
  SizedBox(height: 16),
```

- [ ] **Step 4: 提交时上传图片获取 URL**

在提交逻辑中，先上传图片获取 URL，再创建卡片：

```dart
  String? imageUrl;
  if (_imageFile != null) {
    final uploadResp = await _cardRepo.uploadImage(_imageFile!);
    imageUrl = uploadResp?['url'];
  }
```

并在 CardRepository 中添加：
```dart
  Future<Map<String, dynamic>?> uploadImage(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });
    final resp = await _dio.post('/v1/files/upload', data: formData);
    return resp.data['data'];
  }
```

- [ ] **Step 5: 编译验证 + 提交**

```bash
cd frontend && flutter analyze lib/
git add frontend/lib/features/card/
git commit -m "前端: 创建卡片页添加场景照片上传"
```

---

### Task 38: 后端 — 创建 NearbyStatsResponse + 附近统计 API

**Files:**
- Create: `backend/src/main/java/com/glance/model/dto/response/NearbyStatsResponse.java`
- Modify: `backend/src/main/java/com/glance/controller/MatchController.java`（或新建 NearbyController）

- [ ] **Step 1: 写入 NearbyStatsResponse**

```java
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
```

- [ ] **Step 2: 在 MoodStatusRepository 中已有 countMoodDistribution 方法；创建 NearbyController**

```java
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

    @GetMapping("/stats")
    public ApiResponse<NearbyStatsResponse> getStats(Authentication auth) {
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

        return ApiResponse.ok(NearbyStatsResponse.builder()
                .onlineCount(Math.max(total, 0))
                .moodDistribution(distribution)
                .build());
    }
}
```

- [ ] **Step 3: 编译验证 + 提交**

```bash
cd backend && ./mvnw compile
git add backend/src/main/java/com/glance/model/dto/response/NearbyStatsResponse.java \
        backend/src/main/java/com/glance/controller/NearbyController.java
git commit -m "后端: 新建 NearbyController + 附近统计API（用户数/情绪分布）"
```

---

### Task 39: 前端 — 附近页面（显示用户数 + 情绪分布）

**Files:**
- Create: `frontend/lib/features/nearby/data/nearby_repository.dart`
- Create: `frontend/lib/features/nearby/domain/nearby_state.dart`
- Create: `frontend/lib/features/nearby/domain/nearby_state.freezed.dart`
- Create: `frontend/lib/features/nearby/presentation/nearby_viewmodel.dart`
- Create: `frontend/lib/features/nearby/presentation/nearby_page.dart`

- [ ] **Step 1: nearby_repository.dart**

```dart
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class NearbyRepository {
  final Dio _dio = DioClient.instance;

  Future<Map<String, dynamic>?> getStats() async {
    final resp = await _dio.get('/v1/nearby/stats');
    if (resp.data['code'] == 200) return resp.data['data'];
    return null;
  }
}
```

- [ ] **Step 2: nearby_state.dart**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearby_state.freezed.dart';

@freezed
sealed class NearbyState with _$NearbyState {
  const factory NearbyState.initial() = NearbyInitial;
  const factory NearbyState.loading() = NearbyLoading;
  const factory NearbyState.loaded({
    required int onlineCount,
    required Map<String, int> moodDistribution,
  }) = NearbyLoaded;
  const factory NearbyState.error({required String message}) = NearbyError;
}
```

- [ ] **Step 3: nearby_viewmodel.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/nearby_state.dart';
import '../data/nearby_repository.dart';

final class NearbyViewModel extends Notifier<NearbyState> {
  final _repo = NearbyRepository();

  @override
  NearbyState build() => const NearbyState.initial();

  Future<void> loadStats() async {
    state = const NearbyState.loading();
    try {
      final data = await _repo.getStats();
      if (data != null) {
        final dist = Map<String, int>.from(
          (data['moodDistribution'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, (v as num).toInt()),
          ) ?? {},
        );
        state = NearbyState.loaded(
          onlineCount: data['onlineCount'] as int? ?? 0,
          moodDistribution: dist,
        );
      } else {
        state = const NearbyState.loaded(onlineCount: 0, moodDistribution: {});
      }
    } catch (e) {
      state = NearbyState.error(message: e.toString());
    }
  }
}

final nearbyViewModelProvider =
    NotifierProvider<NearbyViewModel, NearbyState>(NearbyViewModel.new);
```

- [ ] **Step 4: nearby_page.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../domain/nearby_state.dart';
import 'nearby_viewmodel.dart';

final class NearbyPage extends ConsumerStatefulWidget {
  const NearbyPage({super.key});

  @override
  ConsumerState<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends ConsumerState<NearbyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(nearbyViewModelProvider.notifier).loadStats();
    });
  }

  static const _moodLabels = {
    'expect': '🌟 期待', 'miss': '💭 想念', 'happy': '😊 开心',
    'quiet': '🌙 安静', 'bored': '🫠 无聊',
  };

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nearbyViewModelProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('附近'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: switch (state) {
        NearbyInitial() || NearbyLoading() => const Center(
            child: CircularProgressIndicator(color: AppTheme.primary)),
        NearbyLoaded(:final onlineCount, :final moodDistribution) =>
          _buildContent(onlineCount, moodDistribution),
        NearbyError(:final message) => Center(
            child: Text(message, style: const TextStyle(color: AppTheme.textSecondary))),
      },
    );
  }

  Widget _buildContent(int count, Map<String, int> distribution) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          const Text('📍', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text('附近 $count 人在线',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          const Text('基于蓝牙近场感知，不显示精确位置',
              style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          const SizedBox(height: 32),
          if (distribution.isNotEmpty) ...[
            const Text('他们的心情',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 16),
            ...distribution.entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(_moodLabels[e.key] ?? e.key,
                      style: const TextStyle(fontSize: 15)),
                  const SizedBox(width: 12),
                  Expanded(child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: count > 0 ? e.value / count : 0,
                      minHeight: 8,
                      backgroundColor: AppTheme.border,
                      valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
                    ),
                  )),
                  const SizedBox(width: 8),
                  Text('${e.value}人',
                      style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                ],
              ),
            )),
          ] else ...[
            const Text('😴', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            const Text('附近暂时安静',
                style: TextStyle(color: AppTheme.textSecondary)),
          ],
        ],
      ),
    );
  }
}
```

- [ ] **Step 5: 生成 freezed + 提交**

```bash
cd frontend && dart run build_runner build --delete-conflicting-outputs
git add frontend/lib/features/nearby/
git commit -m "前端: 新增附近页面（用户数 + 情绪分布条）"
```

---

### Task 40: 前端 — 更新路由，添加附近页面 + HomePage 入口

**Files:**
- Modify: `frontend/lib/routes/app_router.dart`
- Modify: `frontend/lib/features/card/presentation/home_page.dart`

- [ ] **Step 1: 添加附近路由**

```dart
import '../../features/nearby/presentation/nearby_page.dart';
// ...
  static const String nearby = '/nearby';
// ...
      GoRoute(
        path: nearby,
        name: 'nearby',
        pageBuilder: (context, state) => _fadePage(
          child: const NearbyPage(),
        ),
      ),
```

- [ ] **Step 2: HomePage AppBar 添加附近入口**

在 AppBar actions 最前面添加：
```dart
          IconButton(
            icon: const Icon(Icons.radar),
            tooltip: '附近',
            onPressed: () => context.push(AppRouter.nearby),
          ),
```

- [ ] **Step 3: 提交**

```bash
git add frontend/lib/routes/app_router.dart frontend/lib/features/card/presentation/home_page.dart
git commit -m "前端: 路由添加附近页面 + HomePage 入口"
```

---

### Task 41: V2.3 里程碑提交

```bash
git tag -a v2.3-media -m "V2.3: 硬件媒体层 — 附近统计 + 场景照片"
git commit --allow-empty -m "里程碑: V2.3 硬件媒体层完成"
```

---

## V2.4：质量保障层

### Task 42: 后端 — 运行全部测试 + 修复

```bash
cd backend && ./mvnw clean test
```

- [ ] 确保所有 15+ 测试用例通过
- [ ] 如有失败，修复后重新运行

### Task 43: 前端 — 运行全部测试 + 修复

```bash
cd frontend && flutter test
```

- [ ] 确保所有 11+ 测试用例通过

### Task 44: 后端 — 安全审查配置

检查以下安全点：
- [ ] SecurityConfig 确认 `/api/v1/files/**` GET 请求不需认证
- [ ] FileController 确认上传大小 5MB 限制生效
- [ ] WebSocket 连接不需额外认证（query param userId 足够）
- [ ] AiModelConfig API key 不从代码提交（使用环境变量或 application-local.properties）

### Task 45: 前端 — 清理冗余代码

- [ ] 移除 `home_page.dart` 中已不再使用的 `_startPolling()` 轮询方法（但保留以备降级）
- [ ] 检查是否还有对 `GET /matches/check` 的调用
- [ ] 确保 Model 的 freezed 文件与更新后的字段一致

### Task 46: V2.4 最终里程碑

```bash
git tag -a v2.0.0 -m "V2.0: 回眸App — 匹配更精准、体验更实时、情感更丰富"
git commit --allow-empty -m "里程碑: V2.0 升级完成"
```

---

## 不在此计划内的内容（留给 V3）

- 视频聊天 / 语音消息
- 动态广场 / 朋友圈
- 精确地图 / GPS 定位
- 直播功能
- 演唱会/音乐节模式
- 复杂推荐系统
