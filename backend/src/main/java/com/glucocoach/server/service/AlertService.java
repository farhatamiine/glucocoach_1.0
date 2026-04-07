package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.Alert;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.AlertRequest;
import com.glucocoach.server.dto.response.AlertResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.AlertMapper;
import com.glucocoach.server.repository.AlertRepository;
import com.glucocoach.server.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AlertService {

    private final AlertRepository alertRepository;
    private final UserRepository userRepository;
    private final AlertMapper alertMapper;

    public List<AlertResponse> getAll(String email) {
        User user = getUser(email);
        return alertRepository.findByUserId(user.getId())
                .stream()
                .map(alertMapper::toResponse)
                .toList();
    }

    @Transactional
    public AlertResponse create(AlertRequest request, String email) {
        User user = getUser(email);
        Alert alert = alertMapper.toEntity(request);
        alert.setUser(user);
        return alertMapper.toResponse(alertRepository.save(alert));
    }

    @Transactional
    public AlertResponse update(Long id, AlertRequest request, String email) {
        User user = getUser(email);
        Alert alert = alertRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Alert not found with id: " + id));

        alert.setThresholdLow(request.getThresholdLow());
        alert.setThresholdHigh(request.getThresholdHigh());
        alert.setNotifyVia(request.getNotifyVia());
        alert.setActive(request.isActive());

        return alertMapper.toResponse(alertRepository.save(alert));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = getUser(email);
        Alert alert = alertRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Alert not found with id: " + id));
        alertRepository.delete(alert);
    }

    private User getUser(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }
}
