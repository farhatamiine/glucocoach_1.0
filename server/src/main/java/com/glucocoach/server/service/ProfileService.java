package com.glucocoach.server.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.Profile;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.ProfileRequest;
import com.glucocoach.server.dto.response.ProfileResponse;
import com.glucocoach.server.exception.AlreadyExistsException;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.ProfileMapper;
import com.glucocoach.server.repository.ProfileRepository;
import com.glucocoach.server.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProfileService {

    private final ProfileRepository profileRepository;
    private final UserRepository userRepository;
    private final ProfileMapper profileMapper;

    // ── CREATE ────────────────────────────────────────────────────────────────
    // Profile is 1-to-1 with User — only one profile allowed per user
    @Transactional
    public ProfileResponse create(String email, ProfileRequest request) {
        User user = getUser(email);

        if (profileRepository.existsByUserId(user.getId())) {
            throw new AlreadyExistsException("Profile already exists for this user. Use PUT to update it.");
        }

        Profile profile = profileMapper.toEntity(request);
        profile.setUser(user);

        return profileMapper.toResponse(profileRepository.save(profile));
    }

    // ── GET ───────────────────────────────────────────────────────────────────
    public ProfileResponse get(String email) {
        User user = getUser(email);

        Profile profile = profileRepository.findByUserId(user.getId())
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Profile not found. Please create one first."));

        return profileMapper.toResponse(profile);
    }

    // ── UPDATE ────────────────────────────────────────────────────────────────
    @Transactional
    public ProfileResponse update(String email, ProfileRequest request) {
        User user = getUser(email);

        Profile profile = profileRepository.findByUserId(user.getId())
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Profile not found. Please create one first."));

        profile.setDiabetesType(request.getDiabetesType());
        profile.setHeight(request.getHeight());
        profile.setDiabetesSince(request.getDiabetesSince());
        profile.setBasalInsulinName(request.getBasalInsulinName());
        profile.setBolusInsulinName(request.getBolusInsulinName());
        profile.setGlucoseUnit(request.getGlucoseUnit());
        profile.setPrescribedBasalDose(request.getPrescribedBasalDose());

        return profileMapper.toResponse(profileRepository.save(profile));
    }

    // ── HELPER ────────────────────────────────────────────────────────────────
    private User getUser(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }
}
