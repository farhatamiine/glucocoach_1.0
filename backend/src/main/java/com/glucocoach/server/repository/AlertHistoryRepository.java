package com.glucocoach.server.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.AlertHistory;
import com.glucocoach.server.domain.enums.AlertDirection;

@Repository
public interface AlertHistoryRepository extends JpaRepository<AlertHistory, Long> {
    List<AlertHistory> findByUserIdOrderByTriggeredAtDesc(Long userId);

    Optional<AlertHistory> findTopByUserIdAndAlertIdAndDirectionOrderByTriggeredAtDesc(
            Long userId, Long alertId, AlertDirection direction);
}
