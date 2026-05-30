# 《回眸》V2.0 升级设计文档

> 版本: V2.0 | 日期: 2026-05-30 | 状态: 设计完成，待实施

---

## 一、设计决策汇总

| # | 决策点 | 选择 | 理由 |
|---|--------|------|------|
| 1 | 迭代顺序 | 情感体验优先 → 技术基建 | 视觉冲击力强，用户最先感知 |
| 2 | 回眸故事生成 | 模板引擎 | 可控性高、0 API 成本、内容稳定 |
| 3 | 匹配动画 | Lottie JSON 预制动画 | 轻量有质感，类似 iOS 隔空投送 |
| 4 | AI 大模型 | 国内大模型 API | 中文语义理解精准，成本可控 |
| 5 | 图片存储 | 本地文件系统 + 预留 OSS 接口 | 开发阶段 0 成本，随时可切 |
| 6 | BLE 范围 | 用户数 + 情绪标签分布 | 隐私安全 + 氛围感 |
| 7 | 兴趣标签 | 预定义标签池（20个） | 匹配算法准确可控 |
| 8 | 人脸模糊 | 全图高斯模糊 + AI 判断自拍 | 最快落地 |

---

## 二、迭代计划（调整后）

### V2.1：情感体验层（🎨）
- **情绪状态** — 5 种情绪（🌟期待/💭想念/😊开心/🌙安静/🫠无聊），24h 自动清除
- **匹配仪式感** — Lottie 粒子动画 + 共同点展示 + 缘分百分比环形图 + 破冰提示
- **今日回眸故事** — 模板引擎生成文本卡片 + 历史列表 + 分享截图

### V2.2：技术基建层（🔧）
- **WebSocket 实时推送** — 替换匹配轮询，双向通知
- **AI 辅助匹配** — 4 维加权匹配（场景/衣着40% + 标签30% + AI语义20% + 时间10%）

### V2.3：硬件 + 媒体层（📡）
- **BLE 近场感知** — 蓝牙扫描，显示同空间用户数 + 情绪分布
- **卡片场景照片** — 1 张图片上传 + 人脸模糊 + AI 自拍审核

### V2.4：质量保障层（✅）
- 集成测试 + 性能优化 + 安全审查 + 发布

---

## 三、数据库变更

### 新增表

```sql
-- 情绪状态表
CREATE TABLE mood_status (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    mood VARCHAR(20) NOT NULL COMMENT 'expect/miss/happy/quiet/bored',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_user (user_id)
);

-- 回眸故事表
CREATE TABLE glance_story (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    story_date DATE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_user_date (user_id, story_date)
);

-- 兴趣标签字典表
CREATE TABLE interest_tag (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL UNIQUE,
    emoji VARCHAR(5) NOT NULL DEFAULT '',
    category VARCHAR(20) NOT NULL DEFAULT '',
    sort_order INT DEFAULT 0
);
```

### 变更现有表

```sql
ALTER TABLE heart_card ADD COLUMN image_url VARCHAR(500) DEFAULT '' COMMENT '场景照片URL';
ALTER TABLE heart_card ADD COLUMN match_score DECIMAL(5,2) DEFAULT 0 COMMENT 'AI综合匹配得分';
ALTER TABLE match_record ADD COLUMN common_points JSON NULL COMMENT '共同点列表';
ALTER TABLE match_record ADD COLUMN score_percent INT DEFAULT 0 COMMENT '缘分百分比(0-100)';
```

### 预置标签（20 个）

```
读书📚 | 摄影📷 | 咖啡☕ | 旅行✈️ | 电影🎬 | 音乐🎵 | 运动⚽
宠物🐱 | 美食🍜 | 游戏🎮 | 绘画🎨 | 写作✍️ | 科技💻 | 设计🎯
自然🌿 | 瑜伽🧘 | 动漫🎌 | 穿搭👗 | 舞蹈💃 | 星座🔮
```

---

## 四、后端架构

### 新增文件

```
backend/src/main/java/com/glance/
├── model/entity/
│   ├── MoodStatus.java
│   ├── GlanceStory.java
│   └── InterestTag.java
├── model/dto/request/
│   ├── MoodUpdateRequest.java
│   └── ImageUploadRequest.java
├── model/dto/response/
│   ├── MoodResponse.java
│   ├── StoryResponse.java
│   ├── MatchResultResponse.java      # 修改
│   └── NearbyStatsResponse.java
├── repository/
│   ├── MoodStatusRepository.java
│   ├── GlanceStoryRepository.java
│   └── InterestTagRepository.java
├── service/
│   ├── MoodService.java / impl/MoodServiceImpl.java
│   ├── StoryService.java / impl/StoryServiceImpl.java
│   ├── TagService.java / impl/TagServiceImpl.java
│   ├── AiMatchService.java / impl/AiMatchServiceImpl.java
│   ├── ImageService.java / impl/ImageServiceImpl.java
│   └── impl/MatchServiceImpl.java    # 修改
├── controller/
│   ├── MoodController.java
│   ├── StoryController.java
│   ├── TagController.java
│   └── FileController.java
├── config/
│   └── AiModelConfig.java
└── websocket/
    └── MatchNotificationHandler.java
```

### 关键设计

- **AI 模型**: 通过 `AiModelConfig` 切换国内大模型，默认预留 DeepSeek 接口
- **匹配引擎**: `MatchServiceImpl` 从单维规则升级为四维加权
- **WebSocket**: 新增 `MatchNotificationHandler`，与现有 `ChatWebSocketHandler` 独立
- **故事生成**: 模板引擎 10-20 个模板，`{nickname}` `{scene}` `{count}` 等变量填充
- **图片存储**: `uploads/` 目录，`StorageService` 接口预留 OSS 切换

---

## 五、前端架构

### 新增 Feature

```
frontend/lib/features/
├── mood/                      # 情绪状态
│   ├── data/mood_repository.dart
│   ├── domain/mood_state.dart / mood_state.freezed.dart
│   └── presentation/
│       ├── mood_selector.dart
│       └── mood_viewmodel.dart
│
├── story/                     # 今日回眸故事
│   ├── data/story_repository.dart
│   ├── domain/glance_story.dart / glance_story.freezed.dart
│   ├── domain/story_state.dart / story_state.freezed.dart
│   └── presentation/
│       ├── story_page.dart
│       ├── story_card.dart
│       └── story_viewmodel.dart
│
├── nearby/                    # 附近（V2.3）
│   ├── data/nearby_repository.dart
│   ├── domain/nearby_state.dart / nearby_state.freezed.dart
│   └── presentation/
│       ├── nearby_page.dart
│       └── nearby_viewmodel.dart
│
└── ceremony/                  # 匹配仪式感
    ├── domain/ceremony_data.dart
    └── presentation/
        ├── match_ceremony_page.dart
        └── widgets/
            ├── particle_overlay.dart
            ├── common_points_card.dart
            ├── score_ring.dart
            └── icebreaker_card.dart
```

### 修改现有 Feature

- `features/card/domain/heart_card.dart` — + imageUrl, + matchScore
- `features/card/presentation/create_card_page.dart` — + 图片上传
- `features/match/domain/match_record.dart` — + commonPoints, + scorePercent
- `features/match/presentation/match_page.dart` — 跳转仪式页
- `features/match/presentation/match_viewmodel.dart` — 接收 WebSocket 推送

### 新增依赖

```yaml
lottie: ^3.3.0
image_picker: ^1.1.2
share_plus: ^10.1.4
flutter_blue_plus: ^1.35.2     # V2.3
path_provider: ^2.1.5
```

### 新增路由

```dart
/mood              → 情绪选择页
/ceremony/:matchId → 匹配仪式页
/story             → 回眸故事列表
/story/:id         → 故事详情
/nearby            → 附近页（V2.3）
```

---

## 六、API 设计

### 新增端点

| 方法 | 路径 | 说明 | 迭代 |
|------|------|------|------|
| POST | `/api/v1/mood` | 设置/更新情绪状态 | V2.1 |
| GET | `/api/v1/mood` | 获取当前情绪 | V2.1 |
| GET | `/api/v1/mood/{userId}` | 获取指定用户情绪 | V2.1 |
| GET | `/api/v1/story/today` | 今日回眸故事 | V2.1 |
| GET | `/api/v1/story/history` | 历史故事（分页） | V2.1 |
| GET | `/api/v1/tags` | 全部预定义标签 | V2.1 |
| PUT | `/api/v1/user/tags` | 更新用户兴趣标签 | V2.1 |
| GET | `/api/v1/match/{matchId}/detail` | 匹配仪式详情 | V2.1 |
| POST | `/api/v1/files/upload` | 上传场景照片 | V2.3 |
| GET | `/api/v1/files/{filename}` | 访问图片 | V2.3 |
| GET | `/api/v1/nearby/stats` | 附近统计 | V2.3 |

### WebSocket 消息

```
// 匹配成功推送
{ "type": "match_success", "data": { "matchId": 10086, "cardId": 42, ... } }

// 仪式详情
请求: { "type": "ceremony_detail", "matchId": 10086 }
响应: { "type": "ceremony_detail", "data": { commonPoints, scorePercent, icebreaker, ... } }
```

### 删除的 V1 端点

```
DELETE GET /api/v1/match/check?cardId={id}   # 轮询 → WebSocket
```

---

## 七、不包含功能（明确排除）

- 视频聊天 / 语音消息 / 动态广场
- 精确地图 / GPS 坐标展示
- 直播 / 朋友圈
- 演唱会/音乐节模式（V3）
- 复杂推荐系统 / AI 画像

---

## 八、技术约束

- **编码**: UTF-8，中文注释使用全角标点
- **前端**: Feature First + Clean Architecture + MVVM + Riverpod
- **后端**: 接口-实现分离，RESTful JSON，camelCase 字段
- **UI**: iOS 极简风、白色背景、柔和渐变、圆角统一、动画克制
- **产品调性**: 青春感、克制感、情绪价值——不涉及低俗社交元素
- **禁止**: 一次性生成整个项目，每次仅完成一个模块
