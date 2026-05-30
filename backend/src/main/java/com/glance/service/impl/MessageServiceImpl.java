package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.request.SendMessageRequest;
import com.glance.model.entity.MatchRecord;
import com.glance.model.entity.Message;
import com.glance.repository.BlockListRepository;
import com.glance.repository.MatchRecordRepository;
import com.glance.repository.MessageRepository;
import com.glance.service.MessageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {

    private final MessageRepository messageRepository;
    private final MatchRecordRepository matchRecordRepository;
    private final BlockListRepository blockListRepository;

    @Override
    @Transactional
    public ApiResponse<Message> sendMessage(Long senderId, SendMessageRequest request) {
        MatchRecord match = matchRecordRepository.findById(request.getMatchId()).orElse(null);
        if (match == null || match.getStatus() != 1) {
            return ApiResponse.error("对话不存在或已解除");
        }

        Long receiverId = match.getUserAId().equals(senderId)
                ? match.getUserBId() : match.getUserAId();

        // 检查是否被拉黑
        if (blockListRepository.existsByUserIdAndBlockedId(receiverId, senderId)) {
            return ApiResponse.error("对方已将你拉黑");
        }

        Message msg = Message.builder()
                .matchId(request.getMatchId())
                .senderId(senderId)
                .receiverId(receiverId)
                .content(request.getContent())
                .msgType(request.getMsgType() != null ? request.getMsgType() : 1)
                .build();

        messageRepository.save(msg);
        return ApiResponse.ok(msg);
    }

    @Override
    public ApiResponse<List<Message>> getChatHistory(Long userId, Long matchId) {
        MatchRecord match = matchRecordRepository.findById(matchId).orElse(null);
        if (match == null) return ApiResponse.error("对话不存在");
        if (!match.getUserAId().equals(userId) && !match.getUserBId().equals(userId)) {
            return ApiResponse.error("无权查看");
        }
        List<Message> messages = messageRepository.findByMatchIdOrderByCreatedAtAsc(matchId);
        return ApiResponse.ok(messages);
    }
}
