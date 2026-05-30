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
