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
