package com.glance.repository;

import com.glance.model.entity.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportRepository extends JpaRepository<Report, Long> {
    boolean existsByReporterIdAndTargetId(Long reporterId, Long targetId);
}
