# CLAUDE.md

你是《回眸》项目的长期核心工程师。

请始终：

* 保持架构一致
* 保持 UI 风格一致
* 保持产品调性一致
* 不允许破坏已有模块
* 优先复用已有代码
* 所有功能必须工程化


This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

《回眸》(Glance) — 一款基于"现实场景匿名双向心动匹配"的轻社交 App。
用户在地铁、校园、咖啡店等公共场景中，通过匿名描述对方衣着特征与场景信息，
寻找刚刚让自己心动的人。双向匹配成功后开启匿名聊天。

完整产品需求见：`《回眸》App 第一版 MVP 产品需求文档（PRD）.md`

## 技术栈（规划）

| 层 | 技术 |
|---|------|
| 客户端 | Flutter（跨平台 iOS/Android） |
| 后端 | Spring Boot |
| 数据库 | MySQL 8.0 |
| 缓存 | Redis |
| 实时通信 | WebSocket |
| 近场感知 | 蓝牙 BLE / 模糊定位 |

## 项目结构

```
Glance/
├── docker-compose.yml          # MySQL 8.0 + Redis 7 开发环境
├── database/
│   └── init.sql                # 数据库初始化（6 张表）
├── backend/                    # Spring Boot 3.5 后端
│   ├── pom.xml                 # Maven 依赖（含 mvnw wrapper）
│   └── src/main/java/com/glance/
│       ├── GlanceApplication.java
│       ├── config/             # SecurityConfig, WebSocketConfig
│       ├── model/entity/       # JPA 实体: User, HeartCard, MatchRecord, Message, Report, BlockList
│       ├── model/dto/          #请求/响应 DTO
│       ├── repository/         # Spring Data JPA Repository
│       ├── service/            # 业务接口 + impl/
│       ├── controller/         # REST API 端点
│       ├── security/           # JWT Token 验证 + 认证过滤器
│       └── websocket/          # ChatWebSocketHandler（实时消息推送）
└── frontend/                   # Flutter 客户端
    ├── pubspec.yaml
    └── lib/
        ├── main.dart           # App 入口，Provider 注入
        ├── config/             # theme, routes, api 配置
        ├── models/             # User, HeartCard, MatchRecord, ChatMessage
        ├── services/           # AuthService, CardService, ChatService (Provider + WebSocket)
        └── pages/              # 页面: home, create-card, chat, match, profile
```

## 常用命令

```bash
# 启动 MySQL + Redis
docker compose up -d

# 后端编译运行
cd backend && ./mvnw spring-boot:run

# 停止容器
docker compose down
```

## MVP 范围

- 手机号注册登录 / 创建心动卡片 / 双向匹配判定 / 匿名文本聊天 / 举报拉黑 / 卡片 30 分钟过期
- 不包含：视频、语音、动态广场、精确地图、直播、朋友圈

## 可用 Skills

本项目已安装以下 Claude Code 插件/技能，开发过程中按需调用：
- `/frontend-design` — 生成 Flutter 前端界面
- `/code-review` — 代码审查
- `/security-review` — 安全审查（匿名社交应用必做）
- `/superpowers:writing-plans` — 编写实现计划
- `/superpowers:executing-plans` — 执行实现计划
- `/superpowers:test-driven-development` — TDD 开发
- `/superpowers:subagent-driven-development` — 多子代理并行开发
- `/superpowers:systematic-debugging` — 系统化调试
- `/superpowers:verification-before-completion` — 完成前验证
- `/superpowers:brainstorming` — 创意/功能头脑风暴（实现新功能前先用）
- `/verify` — 运行应用验证改动
- `/simplify` — 代码简化与重构

## 开发约定

- 所有代码文件使用 UTF-8 编码
- 中文注释和文档使用全角标点
- API 返回格式统一使用 RESTful JSON，字段命名 camelCase
- 数据库表名和字段名使用 snake_case
- Git commit message 使用中文，格式：`模块: 简述改动`
- 涉及用户隐私的功能（位置、聊天内容）必须通过 `/security-review` 审查后方可合并
