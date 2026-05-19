package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.Alert;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.AlertRequest;
import com.glucocoach.server.dto.response.AlertResponse;
import com.glucocoach.server.mapper.AlertMapper;
import com.glucocoach.server.repository.AlertRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AlertService {

    private final AlertRepository alertRepository;
    private final OwnershipValidator ownershipValidator;
    private final AlertMapper alertMapper;

    public List<AlertResponse> getAll(String email) {
        User user = ownershipValidator.getCurrentUser(email);
        return alertRepository.findByUserId(user.getId())
                .stream()
                .map(alertMapper::toResponse)
                .toList();
    }

    @Transactional
    public AlertResponse create(AlertRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Alert alert = alertMapper.toEntity(request);
        alert.setUser(user);
        return alertMapper.toResponse(alertRepository.save(alert));
    }

    @Transactional
    public AlertResponse update(Long id, AlertRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Alert alert = ownershipValidator.validateOwnership(
                id, user.getId(), alertRepository::findByIdAndUserId, "Alert");

        alert.setThresholdLow(request.getThresholdLow());
        alert.setThresholdHigh(request.getThresholdHigh());
        alert.setNotifyVia(request.getNotifyVia());
        alert.setActive(request.isActive());

        return alertMapper.toResponse(alertRepository.save(alert));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Alert alert = ownershipValidator.validateOwnership(
                id, user.getId(), alertRepository::findByIdAndUserId, "Alert");
        alertRepository.delete(alert);
    }
}
