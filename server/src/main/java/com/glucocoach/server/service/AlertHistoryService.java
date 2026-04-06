package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.response.AlertHistoryResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.AlertHistoryMapper;
import com.glucocoach.server.repository.AlertHistoryRepository;
import com.glucocoach.server.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AlertHistoryService {

    private final AlertHistoryRepository alertHistoryRepository;
    private final UserRepository userRepository;
    private final AlertHistoryMapper alertHistoryMapper;

    // Read-only — alert history is written internally by the system, never by the user
    public List<AlertHistoryResponse> getAll(String email) {
        User user = getUser(email);
        return alertHistoryRepository.findByUserIdOrderByTriggeredAtDesc(user.getId())
                .stream()
                .map(alertHistoryMapper::toResponse)
                .toList();
    }

    private User getUser(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }
}
