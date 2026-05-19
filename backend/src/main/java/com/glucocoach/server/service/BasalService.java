package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.Basal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.BasalRequest;
import com.glucocoach.server.dto.response.BasalResponse;
import com.glucocoach.server.mapper.BasalMapper;
import com.glucocoach.server.repository.BasalRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BasalService {

    private final BasalRepository basalRepository;
    private final OwnershipValidator ownershipValidator;
    private final BasalMapper basalMapper;

    public List<BasalResponse> getAll(String email) {
        User user = ownershipValidator.getCurrentUser(email);
        return basalRepository.findByUserIdOrderByInjectedAtDesc(user.getId())
                .stream()
                .map(basalMapper::toResponse)
                .toList();
    }

    @Transactional
    public BasalResponse create(BasalRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Basal basal = basalMapper.toEntity(request);
        basal.setUser(user);
        return basalMapper.toResponse(basalRepository.save(basal));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Basal basal = ownershipValidator.validateOwnership(
                id, user.getId(), basalRepository::findByIdAndUserId, "Basal entry");
        basalRepository.delete(basal);
    }
}
