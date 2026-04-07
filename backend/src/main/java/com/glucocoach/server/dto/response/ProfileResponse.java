package com.glucocoach.server.dto.response;

import java.time.LocalDate;

import com.glucocoach.server.domain.enums.DiabetesType;
import com.glucocoach.server.domain.enums.GlucoseUnit;

import lombok.Data;

@Data
public class ProfileResponse {
    Long id;
    DiabetesType diabetesType;
    Long height;
    LocalDate diabetesSince;
    String basalInsulinName;
    String bolusInsulinName;
    GlucoseUnit glucoseUnit;
    Long prescribedBasalDose;
    Long userId;
}
