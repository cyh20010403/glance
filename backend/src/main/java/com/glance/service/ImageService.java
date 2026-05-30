package com.glance.service;

public interface ImageService {
    /** 对图片做简单模糊处理 */
    String blurImage(String filename);
    /** AI 审核图片内容 */
    boolean isPassedReview(String imageUrl);
}
