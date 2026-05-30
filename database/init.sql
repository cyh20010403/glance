-- ============================================
-- 《回眸》Glance 数据库初始化脚本
-- ============================================

CREATE DATABASE IF NOT EXISTS glance DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE glance;

-- ============================================
-- 1. 用户表
-- ============================================
CREATE TABLE IF NOT EXISTS `user` (
    `id`          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `phone`       VARCHAR(20)  NOT NULL COMMENT '手机号（加密存储）',
    `nickname`    VARCHAR(50)  NOT NULL DEFAULT '' COMMENT '昵称',
    `avatar`      VARCHAR(500) NOT NULL DEFAULT '' COMMENT '头像URL',
    `gender`      TINYINT      NOT NULL DEFAULT 0 COMMENT '性别: 0-未知 1-男 2-女',
    `age`         INT          NOT NULL DEFAULT 0 COMMENT '年龄',
    `tags`        JSON         NULL COMMENT '兴趣标签列表',
    `signature`   VARCHAR(200) NOT NULL DEFAULT '' COMMENT '个性签名',
    `status`      TINYINT      NOT NULL DEFAULT 1 COMMENT '状态: 1-正常 0-禁用',
    `created_at`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    `updated_at`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_phone` (`phone`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ============================================
-- 2. 心动卡片表
-- ============================================
CREATE TABLE IF NOT EXISTS `heart_card` (
    `id`            BIGINT       NOT NULL AUTO_INCREMENT COMMENT '卡片ID',
    `user_id`       BIGINT       NOT NULL COMMENT '发布者用户ID',
    `scene`         VARCHAR(50)  NOT NULL COMMENT '场景: subway/library/cafe/other',
    `scene_label`   VARCHAR(100) NOT NULL DEFAULT '' COMMENT '场景自定义标签',
    `location`      VARCHAR(200) NOT NULL DEFAULT '' COMMENT '模糊地点描述',
    `occurred_at`   DATETIME     NOT NULL COMMENT '心动发生时间',
    -- 对方特征
    `top_color`     VARCHAR(20)  NOT NULL DEFAULT '' COMMENT '上衣颜色',
    `pants_color`   VARCHAR(20)  NOT NULL DEFAULT '' COMMENT '裤子颜色',
    `glasses`       TINYINT      NOT NULL DEFAULT 0 COMMENT '是否戴眼镜: 0-未知 1-有 2-无',
    `hairstyle`     VARCHAR(30)  NOT NULL DEFAULT '' COMMENT '发型',
    `has_bag`       TINYINT      NOT NULL DEFAULT 0 COMMENT '是否背包: 0-未知 1-有 2-无',
    `shoe_color`    VARCHAR(20)  NOT NULL DEFAULT '' COMMENT '鞋子颜色',
    `description`   VARCHAR(300) NOT NULL DEFAULT '' COMMENT '文本描述',
    -- 状态
    `status`        TINYINT      NOT NULL DEFAULT 1 COMMENT '状态: 1-有效 2-已匹配 3-已过期',
    `expire_at`     DATETIME     NOT NULL COMMENT '过期时间（创建后30分钟）',
    `created_at`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_status_expire` (`status`, `expire_at`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='心动卡片表';

-- ============================================
-- 3. 匹配记录表
-- ============================================
CREATE TABLE IF NOT EXISTS `match_record` (
    `id`          BIGINT   NOT NULL AUTO_INCREMENT COMMENT '匹配记录ID',
    `card_a_id`   BIGINT   NOT NULL COMMENT '用户A的卡片ID',
    `card_b_id`   BIGINT   NOT NULL COMMENT '用户B的卡片ID',
    `user_a_id`   BIGINT   NOT NULL COMMENT '用户A ID',
    `user_b_id`   BIGINT   NOT NULL COMMENT '用户B ID',
    `status`      TINYINT  NOT NULL DEFAULT 1 COMMENT '状态: 1-已匹配 2-已解除',
    `matched_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '匹配时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_a` (`user_a_id`),
    KEY `idx_user_b` (`user_b_id`),
    KEY `idx_matched_at` (`matched_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='匹配记录表';

-- ============================================
-- 4. 消息表
-- ============================================
CREATE TABLE IF NOT EXISTS `message` (
    `id`          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '消息ID',
    `match_id`    BIGINT       NOT NULL COMMENT '匹配记录ID',
    `sender_id`   BIGINT       NOT NULL COMMENT '发送者用户ID',
    `receiver_id` BIGINT       NOT NULL COMMENT '接收者用户ID',
    `content`     VARCHAR(1000) NOT NULL COMMENT '消息内容',
    `msg_type`    TINYINT      NOT NULL DEFAULT 1 COMMENT '消息类型: 1-文本 2-Emoji',
    `is_read`     TINYINT      NOT NULL DEFAULT 0 COMMENT '是否已读: 0-未读 1-已读',
    `created_at`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    PRIMARY KEY (`id`),
    KEY `idx_match_id` (`match_id`),
    KEY `idx_sender_receiver` (`sender_id`, `receiver_id`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息表';

-- ============================================
-- 5. 举报记录表
-- ============================================
CREATE TABLE IF NOT EXISTS `report` (
    `id`          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '举报ID',
    `reporter_id` BIGINT       NOT NULL COMMENT '举报人用户ID',
    `target_id`   BIGINT       NOT NULL COMMENT '被举报用户ID',
    `reason`      VARCHAR(50)  NOT NULL COMMENT '举报原因类型',
    `detail`      VARCHAR(500) NOT NULL DEFAULT '' COMMENT '举报详细描述',
    `status`      TINYINT      NOT NULL DEFAULT 0 COMMENT '处理状态: 0-待处理 1-已处理 2-已驳回',
    `created_at`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '举报时间',
    `handled_at`  DATETIME     NULL COMMENT '处理时间',
    PRIMARY KEY (`id`),
    KEY `idx_reporter` (`reporter_id`),
    KEY `idx_target` (`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='举报记录表';

-- ============================================
-- 6. 拉黑记录表
-- ============================================
CREATE TABLE IF NOT EXISTS `block_list` (
    `id`          BIGINT   NOT NULL AUTO_INCREMENT COMMENT '拉黑记录ID',
    `user_id`     BIGINT   NOT NULL COMMENT '发起拉黑的用户ID',
    `blocked_id`  BIGINT   NOT NULL COMMENT '被拉黑的用户ID',
    `created_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '拉黑时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_blocked` (`user_id`, `blocked_id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='拉黑记录表';

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
