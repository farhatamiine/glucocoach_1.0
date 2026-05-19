package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.HealthData;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.HealthDataRequest;
import com.glucocoach.server.dto.response.HealthDataResponse;
import com.glucocoach.server.mapper.HealthDataMapper;
import com.glucocoach.server.repository.HealthDataRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HealthDataService {

    private final HealthDataRepository healthDataRepository;
    private final OwnershipValidator ownershipValidator;
    private final HealthDataMapper healthDataMapper;

    public List<HealthDataResponse> getAll(String email) {
        User user = ownershipValidator.getCurrentUser(email);
        return healthDataRepository.findByUserIdOrderByDateDesc(user.getId())
                .stream()
                .map(healthDataMapper::toResponse)
                .toList();
    }

    @Transactional
    public HealthDataResponse create(HealthDataRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        HealthData healthData = healthDataMapper.toEntity(request);
        healthData.setUser(user);
        return healthDataMapper.toResponse(healthDataRepository.save(healthData));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        HealthData healthData = ownershipValidator.validateOwnership(
                id, user.getId(), healthDataRepository::findByIdAndUserId, "Health data");
        healthDataRepository.delete(healthData);
    }
}
