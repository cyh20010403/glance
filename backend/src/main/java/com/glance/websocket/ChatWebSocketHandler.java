package com.glance.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.glance.model.entity.Message;
import com.glance.service.MessageService;
import com.glance.model.dto.request.SendMessageRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Component
@RequiredArgsConstructor
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final MessageService messageService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    /** userId -> WebSocketSession */
    private final Map<Long, WebSocketSession> sessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        Long userId = getUserId(session);
        if (userId != null) {
            sessions.put(userId, session);
            log.info("WebSocket连接建立: userId={}", userId);
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage textMessage) throws Exception {
        Long senderId = getUserId(session);
        if (senderId == null) return;

        SendMessageRequest request = objectMapper.readValue(
                textMessage.getPayload(), SendMessageRequest.class);

        var result = messageService.sendMessage(senderId, request);
        if (result.getData() != null) {
            Message msg = result.getData();
            // 推送消息给接收者
            WebSocketSession receiverSession = sessions.get(msg.getReceiverId());
            if (receiverSession != null && receiverSession.isOpen()) {
                String json = objectMapper.writeValueAsString(Map.of(
                        "type", "new_message",
                        "message", msg
                ));
                receiverSession.sendMessage(new TextMessage(json));
            }
            // 回执给发送者
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(Map.of(
                    "type", "sent",
                    "message", msg
            ))));
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        Long userId = getUserId(session);
        if (userId != null) {
            sessions.remove(userId);
            log.info("WebSocket连接断开: userId={}", userId);
        }
    }

    private Long getUserId(WebSocketSession session) {
        String query = session.getUri() != null ? session.getUri().getQuery() : null;
        if (query != null && query.startsWith("userId=")) {
            try {
                return Long.parseLong(query.substring(7));
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
}
