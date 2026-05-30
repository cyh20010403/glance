package com.glance.repository;

import com.glance.model.entity.BlockList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BlockListRepository extends JpaRepository<BlockList, Long> {
    boolean existsByUserIdAndBlockedId(Long userId, Long blockedId);
    Optional<BlockList> findByUserIdAndBlockedId(Long userId, Long blockedId);
}
