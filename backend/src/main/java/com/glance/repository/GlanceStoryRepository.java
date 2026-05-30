package com.glance.repository;

import com.glance.model.entity.GlanceStory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Optional;

@Repository
public interface GlanceStoryRepository extends JpaRepository<GlanceStory, Long> {

    Optional<GlanceStory> findByUserIdAndStoryDate(Long userId, LocalDate storyDate);

    Page<GlanceStory> findByUserIdOrderByStoryDateDesc(Long userId, Pageable pageable);
}
