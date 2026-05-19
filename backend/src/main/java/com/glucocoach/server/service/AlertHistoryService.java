package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.response.AlertHistoryResponse;
import com.glucocoach.server.mapper.AlertHistoryMapper;
import com.glucocoach.server.repository.AlertHistoryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AlertHistoryService {

    private final AlertHistoryRepository alertHistoryRepository;
    private final OwnershipValidator ownershipValidator;
    private final AlertHistoryMapper alertHistoryMapper;

    // Read-only — alert history is written internally by the system, never by the user
    public List<AlertHistoryResponse> getAll(String email) {
        User user = ownershipValidator.getCurrentUser(email);
        return alertHistoryRepository.findByUserIdOrderByTriggeredAtDesc(user.getId())
                .stream()
                .map(alertHistoryMapper::toResponse)
                .toList();
    }
}
