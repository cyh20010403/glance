package com.glance.service;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.SendMessageRequest;
import com.glance.model.entity.Message;

import java.util.List;

public interface MessageService {
    /** 发送消息 */
    ApiResponse<Message> sendMessage(Long senderId, SendMessageRequest request);
    /** 获取对话历史 */
    ApiResponse<List<Message>> getChatHistory(Long userId, Long matchId);
}
