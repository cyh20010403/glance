package com.glance.service.impl;

import com.glance.service.AiMatchService;
import com.glance.service.ImageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

@Slf4j
@Service
@RequiredArgsConstructor
public class ImageServiceImpl implements ImageService {

    private final AiMatchService aiMatchService;
    private final Path uploadDir = Paths.get("uploads").toAbsolutePath().normalize();

    @Override
    public String blurImage(String filename) {
        try {
            File input = uploadDir.resolve(filename).toFile();
            if (!input.exists()) return filename;

            BufferedImage image = ImageIO.read(input);
            if (image == null) return filename;

            int w = Math.max(1, image.getWidth() / 10);
            int h = Math.max(1, image.getHeight() / 10);
            BufferedImage small = new BufferedImage(w, h, image.getType());
            Graphics2D g = small.createGraphics();
            g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
                    RenderingHints.VALUE_INTERPOLATION_BILINEAR);
            g.drawImage(image, 0, 0, w, h, null);
            g.dispose();

            String blurred = "blurred_" + filename;
            File output = uploadDir.resolve(blurred).toFile();
            ImageIO.write(small, "jpg", output);
            log.info("图片模糊处理完成: {}", blurred);
            return blurred;
        } catch (IOException e) {
            log.warn("图片模糊处理失败: {}", e.getMessage());
            return filename;
        }
    }

    @Override
    public boolean isPassedReview(String imageUrl) {
        boolean isSelfie = aiMatchService.isSelfie(imageUrl);
        return !isSelfie;
    }
}
