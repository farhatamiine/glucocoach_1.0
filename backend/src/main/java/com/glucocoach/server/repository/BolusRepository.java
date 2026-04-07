package com.glucocoach.server.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.Bolus;

@Repository
public interface BolusRepository extends JpaRepository<Bolus, Long> {
    List<Bolus> findByUserIdOrderByTimestampDesc(Long userId);
    Optional<Bolus> findByIdAndUserId(Long id, Long userId);
}
