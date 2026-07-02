package com.glucocoach.server.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.LabResult;

@Repository
public interface LabResultRepository extends JpaRepository<LabResult, Long> {
    List<LabResult> findByUserIdOrderByDateDesc(Long userId);
    Optional<LabResult> findByIdAndUserId(Long id, Long userId);
}
