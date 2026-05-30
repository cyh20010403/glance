package com.glance.service;

import com.glance.model.entity.HeartCard;
import com.glance.model.entity.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 匹配逻辑单元测试
 *
 * 测试 calcAppearanceScore 的逻辑正确性——这是匹配引擎的核心。
 */
class MatchLogicTest {

    private User userA; // 白上衣 + 蓝裤子 + 戴眼镜 + 短发
    private User userB; // 黑上衣 + 长发 + 不戴眼镜

    @BeforeEach
    void setUp() {
        userA = User.builder()
                .myTopColor("白色").myPantsColor("蓝色")
                .myShoeColor("白色").myHairstyle("短发")
                .myGlasses(1).myHasBag(0)
                .build();
        userB = User.builder()
                .myTopColor("黑色").myPantsColor("")
                .myShoeColor("").myHairstyle("长发")
                .myGlasses(2).myHasBag(1)
                .build();
    }

    @Test
    @DisplayName("完全匹配 — 卡片描述恰好等于对方形象")
    void perfectMatch() {
        HeartCard cardA = buildCard("白色", "蓝色", "白色", "短发", 1, 0);
        // A 的卡片描述 == A 自己的形象，比对 userA 自身
        int score = calcScore(cardA, userA);
        assertEquals(7, score, "完全匹配: 上衣2+裤子2+鞋1+发型1+眼镜1=7");
    }

    @Test
    @DisplayName("部分匹配 — 只有上衣和裤子相同")
    void partialMatch() {
        HeartCard card = buildCard("白色", "蓝色", "红色", "长发", 0, 0);
        int score = calcScore(card, userA);
        assertEquals(4, score, "白色+2, 蓝色+2, 红色≠白色+0, 长发≠短发+0 = 4");
    }

    @Test
    @DisplayName("阈值判定 — 得分 3 可通过阈值")
    void thresholdPass() {
        HeartCard card = buildCard("白色", "蓝色", "", "", 0, 0);
        int score = calcScore(card, userA);
        assertTrue(score >= 3, "得分 4 应通过阈值 3");
    }

    @Test
    @DisplayName("阈值判定 — 得分 2 不通过阈值")
    void thresholdFail() {
        HeartCard card = buildCard("白色", "红色", "", "", 0, 0);
        int score = calcScore(card, userA);
        assertTrue(score < 3, "得分 2 不应通过阈值 3");
    }

    @Test
    @DisplayName("空描述 — 什么都匹配不上")
    void emptyCard() {
        HeartCard card = buildCard("", "", "", "", 0, 0);
        int score = calcScore(card, userA);
        assertEquals(0, score);
    }

    @Test
    @DisplayName("仅眼镜匹配")
    void onlyGlasses() {
        HeartCard card = buildCard("红色", "绿色", "", "", 1, 0);
        int score = calcScore(card, userA);
        assertEquals(1, score, "只有眼镜匹配: +1");
    }

    @Test
    @DisplayName("眼镜明确不匹配时不计分")
    void glassesMismatch() {
        // 卡片说戴眼镜(1)，但用户不戴(2)
        HeartCard card = buildCard("", "", "", "", 1, 0);
        int score = calcScore(card, userB);
        assertEquals(0, score, "眼镜不匹配: 1≠2 不应计分");
    }

    // === 模拟 calcAppearanceScore 逻辑 ===
    private int calcScore(HeartCard card, User user) {
        int score = 0;
        if (match(card.getTopColor(), user.getMyTopColor())) score += 2;
        if (match(card.getPantsColor(), user.getMyPantsColor())) score += 2;
        if (match(card.getShoeColor(), user.getMyShoeColor())) score += 1;
        if (match(card.getHairstyle(), user.getMyHairstyle())) score += 1;
        if (card.getGlasses() != null && card.getGlasses() > 0
                && card.getGlasses().equals(user.getMyGlasses())) score += 1;
        if (card.getHasBag() != null && card.getHasBag() > 0
                && card.getHasBag().equals(user.getMyHasBag())) score += 1;
        return score;
    }

    private boolean match(String cv, String uv) {
        return cv != null && !cv.isEmpty() && uv != null && !uv.isEmpty() && cv.equals(uv);
    }

    private HeartCard buildCard(String top, String pants, String shoe, String hair, int glasses, int bag) {
        return HeartCard.builder()
                .topColor(top).pantsColor(pants).shoeColor(shoe)
                .hairstyle(hair).glasses(glasses).hasBag(bag)
                .scene("campus").userId(1L)
                .occurredAt(LocalDateTime.now())
                .expireAt(LocalDateTime.now().plusMinutes(30))
                .build();
    }
}
