package com.glance.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Component
public class MatchNotificationHandler extends TextWebSocketHandler {

    private final ObjectMapper objectMapper = new ObjectMapper();
    /** userId -> WebSocketSession */
    private final Map<Long, WebSocketSession> sessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        Long userId = getUserId(session);
        if (userId != null) {
            sessions.put(userId, session);
            log.info("匹配通知WS连接: userId={}", userId);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        Long userId = getUserId(session);
        if (userId != null) {
            sessions.remove(userId);
            log.info("匹配通知WS断开: userId={}", userId);
        }
    }

    /** 向指定用户推送匹配成功通知 */
    public void pushMatchNotification(Long userId, Long matchId, Long cardId) {
        WebSocketSession session = sessions.get(userId);
        if (session == null || !session.isOpen()) return;
        try {
            String json = objectMapper.writeValueAsString(Map.of(
                    "type", "match_success",
                    "data", Map.of(
                            "matchId", matchId,
                            "cardId", cardId,
                            "previewText", "有人在悄悄找你..."
                    )
            ));
            session.sendMessage(new TextMessage(json));
            log.info("推送匹配通知: userId={}, matchId={}", userId, matchId);
        } catch (IOException e) {
            log.warn("推送匹配通知失败: {}", e.getMessage());
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
