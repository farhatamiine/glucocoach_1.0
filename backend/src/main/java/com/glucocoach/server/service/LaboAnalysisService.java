package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.LaboAnalysis;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.LaboAnalysisRequest;
import com.glucocoach.server.dto.response.LaboAnalysisResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.LaboAnalysisMapper;
import com.glucocoach.server.repository.LaboAnalysisRepository;
import com.glucocoach.server.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LaboAnalysisService {

    private final LaboAnalysisRepository laboAnalysisRepository;
    private final UserRepository userRepository;
    private final LaboAnalysisMapper laboAnalysisMapper;

    public List<LaboAnalysisResponse> getAll(String email) {
        User user = getUser(email);
        return laboAnalysisRepository.findByUserIdOrderByDateDesc(user.getId())
                .stream()
                .map(laboAnalysisMapper::toResponse)
                .toList();
    }

    @Transactional
    public LaboAnalysisResponse create(LaboAnalysisRequest request, String email) {
        User user = getUser(email);
        LaboAnalysis labo = laboAnalysisMapper.toEntity(request);
        labo.setUser(user);
        return laboAnalysisMapper.toResponse(laboAnalysisRepository.save(labo));
    }

    @Transactional
    public LaboAnalysisResponse update(Long id, LaboAnalysisRequest request, String email) {
        User user = getUser(email);
        LaboAnalysis labo = laboAnalysisRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Lab analysis not found with id: " + id));

        labo.setHba1c(request.getHba1c());
        labo.setCholesterol(request.getCholesterol());
        labo.setTriglycerides(request.getTriglycerides());
        labo.setDate(request.getDate());

        return laboAnalysisMapper.toResponse(laboAnalysisRepository.save(labo));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = getUser(email);
        LaboAnalysis labo = laboAnalysisRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Lab analysis not found with id: " + id));
        laboAnalysisRepository.delete(labo);
    }

    private User getUser(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }
}
