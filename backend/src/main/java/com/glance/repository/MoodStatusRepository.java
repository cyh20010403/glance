package com.glance.repository;

import com.glance.model.entity.MoodStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface MoodStatusRepository extends JpaRepository<MoodStatus, Long> {

    Optional<MoodStatus> findByUserId(Long userId);

    /** 统计最近 30 分钟内的情绪分布（用于附近页） */
    @Query("SELECT m.mood, COUNT(m) FROM MoodStatus m WHERE m.createdAt > :since GROUP BY m.mood")
    List<Object[]> countMoodDistribution(@Param("since") LocalDateTime since);

    /** 删除 24 小时前的情绪状态 */
    @Modifying
    @Query("DELETE FROM MoodStatus m WHERE m.createdAt < :expire")
    int deleteExpired(@Param("expire") LocalDateTime expire);
}
