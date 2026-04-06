package com.glucocoach.server.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.AlertHistory;

@Repository
public interface AlertHistoryRepository extends JpaRepository<AlertHistory, Long> {
    List<AlertHistory> findByUserIdOrderByTriggeredAtDesc(Long userId);
}
