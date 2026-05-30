package com.glance.repository;

import com.glance.model.entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    /** 查找某个匹配对话的所有消息，按时间正序 */
    List<Message> findByMatchIdOrderByCreatedAtAsc(Long matchId);
    /** 查找某用户的未读消息数 */
    long countByReceiverIdAndIsRead(Long receiverId, Integer isRead);
}
