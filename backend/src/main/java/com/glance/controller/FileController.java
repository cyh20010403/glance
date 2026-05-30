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
