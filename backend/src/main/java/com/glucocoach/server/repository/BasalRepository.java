package com.glucocoach.server.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.Basal;

@Repository
public interface BasalRepository extends JpaRepository<Basal, Long> {
    List<Basal> findByUserIdOrderByInjectedAtDesc(Long userId);
    Optional<Basal> findByIdAndUserId(Long id, Long userId);
}
