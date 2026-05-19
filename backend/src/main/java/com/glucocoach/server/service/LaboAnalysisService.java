package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.LaboAnalysis;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.LaboAnalysisRequest;
import com.glucocoach.server.dto.response.LaboAnalysisResponse;
import com.glucocoach.server.mapper.LaboAnalysisMapper;
import com.glucocoach.server.repository.LaboAnalysisRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LaboAnalysisService {

    private final LaboAnalysisRepository laboAnalysisRepository;
    private final OwnershipValidator ownershipValidator;
    private final LaboAnalysisMapper laboAnalysisMapper;

    public List<LaboAnalysisResponse> getAll(String email) {
        User user = ownershipValidator.getCurrentUser(email);
        return laboAnalysisRepository.findByUserIdOrderByDateDesc(user.getId())
                .stream()
                .map(laboAnalysisMapper::toResponse)
                .toList();
    }

    @Transactional
    public LaboAnalysisResponse create(LaboAnalysisRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        LaboAnalysis labo = laboAnalysisMapper.toEntity(request);
        labo.setUser(user);
        return laboAnalysisMapper.toResponse(laboAnalysisRepository.save(labo));
    }

    @Transactional
    public LaboAnalysisResponse update(Long id, LaboAnalysisRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        LaboAnalysis labo = ownershipValidator.validateOwnership(
                id, user.getId(), laboAnalysisRepository::findByIdAndUserId, "Lab analysis");

        labo.setHba1c(request.getHba1c());
        labo.setCholesterol(request.getCholesterol());
        labo.setTriglycerides(request.getTriglycerides());
        labo.setDate(request.getDate());

        return laboAnalysisMapper.toResponse(laboAnalysisRepository.save(labo));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        LaboAnalysis labo = ownershipValidator.validateOwnership(
                id, user.getId(), laboAnalysisRepository::findByIdAndUserId, "Lab analysis");
        laboAnalysisRepository.delete(labo);
    }
}
