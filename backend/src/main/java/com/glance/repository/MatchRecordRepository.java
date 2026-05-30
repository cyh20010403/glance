package com.glance.repository;

import com.glance.model.entity.MatchRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MatchRecordRepository extends JpaRepository<MatchRecord, Long> {
    /** 查找两个用户之间的有效匹配 */
    Optional<MatchRecord> findByUserAIdAndUserBIdAndStatus(Long userAId, Long userBId, Integer status);
    /** 查找用户的所有匹配 */
    List<MatchRecord> findByUserAIdOrUserBId(Long userAId, Long userBId);
}
