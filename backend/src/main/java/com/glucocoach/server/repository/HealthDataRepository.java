package com.glucocoach.server.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.HealthData;

@Repository
public interface HealthDataRepository extends JpaRepository<HealthData, Long> {
    List<HealthData> findByUserIdOrderByDateDesc(Long userId);
    List<HealthData> findByUserIdAndDateBetweenOrderByDateDesc(Long userId, LocalDate from, LocalDate to);
    Optional<HealthData> findFirstByUserIdAndWeightIsNotNullOrderByDateDesc(Long userId);
    Optional<HealthData> findByIdAndUserId(Long id, Long userId);
}
