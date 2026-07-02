package com.glucocoach.server.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.Bolus;

@Repository
public interface BolusRepository extends JpaRepository<Bolus, Long> {
    List<Bolus> findByUserIdOrderByTimestampDesc(Long userId);
    List<Bolus> findByUserIdAndTimestampGreaterThanEqualAndTimestampLessThanOrderByTimestampDesc(
            Long userId, LocalDateTime start, LocalDateTime endExclusive);
    Optional<Bolus> findByIdAndUserId(Long id, Long userId);
}
