package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.Profile;
import com.glucocoach.server.dto.request.ProfileRequest;
import com.glucocoach.server.dto.response.ProfileResponse;

@Component
public class ProfileMapper {
    public Profile toEntity(ProfileRequest request) {
        if (request == null)
            return null;
        return Profile.builder()
                .diabetesType(request.getDiabetesType())
                .height(request.getHeight())
                .diabetesSince(request.getDiabetesSince())
                .basalInsulinName(request.getBasalInsulinName())
                .bolusInsulinName(request.getBolusInsulinName())
                .glucoseUnit(request.getGlucoseUnit())
                .prescribedBasalDose(request.getPrescribedBasalDose())
                .build();
    }

    public ProfileResponse toResponse(Profile profile) {
        if (profile == null)
            return null;
        ProfileResponse response = new ProfileResponse();
        response.setId(profile.getId());
        response.setDiabetesType(profile.getDiabetesType());
        response.setHeight(profile.getHeight());
        response.setDiabetesSince(profile.getDiabetesSince());
        response.setBasalInsulinName(profile.getBasalInsulinName());
        response.setBolusInsulinName(profile.getBolusInsulinName());
        response.setGlucoseUnit(profile.getGlucoseUnit());
        response.setPrescribedBasalDose(profile.getPrescribedBasalDose());
        if (profile.getUser() != null) {
            response.setUserId(profile.getUser().getId());
        }
        return response;
    }
}
