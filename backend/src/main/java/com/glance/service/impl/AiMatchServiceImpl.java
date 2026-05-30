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
        if (!aiConfig.isEnabled() || aiConfig.getApiKey().isEmpty()) {
            log.debug("AI 未启用，跳过自拍检测");
            return false;
        }

        try {
            // 读取图片文件并 base64 编码
            String filename = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
            java.nio.file.Path uploadDir = java.nio.file.Paths.get("uploads").toAbsolutePath().normalize();
            java.nio.file.Path imagePath = uploadDir.resolve(filename);
            if (!imagePath.toFile().exists()) {
                log.warn("图片文件不存在: {}", filename);
                return false;
            }

            byte[] imageBytes = java.nio.file.Files.readAllBytes(imagePath);
            String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);

            Map<String, Object> body = Map.of(
                "model", aiConfig.getModel(),
                "messages", List.of(
                    Map.of("role", "system", "content",
                        "你是一个图片内容审核工具。判断图片是否为自拍或人像照片。" +
                        "自拍/人像照片的特征：以人物面部为主体，包含眼睛、鼻子、嘴巴等面部特征。" +
                        "只回复 YES 或 NO。"),
                    Map.of("role", "user", "content", List.of(
                        Map.of("type", "text", "text", "这是自拍/人像照片吗？只回答 YES 或 NO。"),
                        Map.of("type", "image_url", "data",
                            "data:image/jpeg;base64," + base64Image)
                    ))
                ),
                "temperature", 0.0,
                "max_tokens", 5
            );

            String json = objectMapper.writeValueAsString(body);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(aiConfig.getApiUrl()))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + aiConfig.getApiKey())
                    .POST(HttpRequest.BodyPublishers.ofString(json))
                    .timeout(Duration.ofSeconds(20))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            Map<String, Object> result = objectMapper.readValue(response.body(), Map.class);
            List<Map<String, Object>> choices = (List<Map<String, Object>>) result.get("choices");
            String content = (String) ((Map<String, Object>) choices.get(0).get("message")).get("content");
            boolean isSelfie = content != null && content.trim().toUpperCase().contains("YES");
            log.info("AI 自拍检测结果: {} -> {}", filename, isSelfie ? "是自拍(拦截)" : "非自拍(放行)");
            return isSelfie;
        } catch (Exception e) {
            log.warn("AI 自拍检测失败（降级放行）: {}", e.getMessage());
            return false; // 降级：放行
        }
    }
}
