package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.SendMessageRequest;
import com.glance.model.entity.Message;
import com.glance.service.MessageService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {

    private final MessageService messageService;

    @PostMapping("/send")
    public ApiResponse<Message> sendMessage(Authentication auth,
                                             @Valid @RequestBody SendMessageRequest request) {
        Long userId = (Long) auth.getPrincipal();
        return messageService.sendMessage(userId, request);
    }

    @GetMapping("/history/{matchId}")
    public ApiResponse<List<Message>> getHistory(Authentication auth,
                                                  @PathVariable Long matchId) {
        Long userId = (Long) auth.getPrincipal();
        return messageService.getChatHistory(userId, matchId);
    }
}
