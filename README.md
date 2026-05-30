# 回眸 (Glance)

> "所有故事，都始于一次回眸。"

一款基于**现实场景匿名双向心动匹配**的轻社交 App。用户在地铁、校园、咖啡店等公共场景中，匿名描述对方的衣着特征与场景信息，寻找刚刚让自己心动的人。双方互相匹配后开启匿名聊天。

---

## 技术栈

| 层 | 技术 |
|---|------|
| 客户端 | Flutter 3.44 + Riverpod + GoRouter + Dio + Freezed |
| 后端 | Spring Boot 3.5 + JWT + WebSocket |
| 数据库 | MySQL 8.0 + Redis 7 |
| 近场感知 | BLE 蓝牙（规划中） |

## 项目结构

```
Glance/
├── docker-compose.yml          # MySQL 8.0 + Redis 7
├── database/init.sql           # 数据库初始化（6 张表）
├── backend/                    # Spring Boot 后端
│   └── src/main/java/com/glance/
│       ├── controller/         # REST API（Auth/Card/Match/Chat/User）
│       ├── service/            # 业务逻辑 + 匹配引擎
│       ├── model/entity/       # JPA 实体（User/HeartCard/MatchRecord/Message…）
│       ├── repository/         # Spring Data JPA
│       ├── security/           # JWT Token + 认证过滤器
│       └── websocket/          # 实时消息推送
└── frontend/                   # Flutter 客户端
    └── lib/
        ├── core/               # Dio 网络层 + 异常处理
        ├── theme/              # iOS 极简风格主题
        ├── routes/             # GoRouter 路由
        └── features/
            ├── auth/           # 手机号登录/注册
            ├── card/           # 心动卡片创建 + 首页
            ├── chat/           # 匿名聊天
            ├── match/          # 双向匹配引擎
            └── profile/        # 个人中心 + 形象设置
```

## 快速启动

```bash
# 1. 启动数据库
docker compose up -d

# 2. 启动后端
cd backend && ./mvnw spring-boot:run

# 3. 启动前端（Windows 桌面版）
cd frontend && flutter run -d windows

# 或 Web 版
cd frontend && flutter run -d chrome --web-port=3000
```

## 核心功能

- 📱 手机号注册登录
- 💌 创建心动卡片（场景 + 衣着特征 + 文本描述）
- 🎯 双向形象匹配（卡片描述 vs 用户实际形象比对）
- 💬 匿名文本聊天（匹配后开放）
- ⏰ 卡片 30 分钟自动过期
- 🚫 举报 / 拉黑
- 👤 个人形象设置

## 版本

- **v1.0.0** — MVP 第一版
