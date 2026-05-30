package com.glance.repository;

import com.glance.model.entity.HeartCard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface HeartCardRepository extends JpaRepository<HeartCard, Long> {

    /** 查找某用户当前有效的卡片 */
    List<HeartCard> findByUserIdAndStatus(Long userId, Integer status);

    /** 查找有效期内未被匹配的卡片（排除自己的） */
    @Query("SELECT c FROM HeartCard c WHERE c.status = 1 AND c.expireAt > :now AND c.userId <> :userId")
    List<HeartCard> findActiveCards(@Param("now") LocalDateTime now, @Param("userId") Long userId);

    /** 将过期卡片标记为已过期 */
    @Modifying
    @Query("UPDATE HeartCard c SET c.status = 3 WHERE c.status = 1 AND c.expireAt < :now")
    int expireCards(@Param("now") LocalDateTime now);
}
