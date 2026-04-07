package com.glucocoach.server.dto.request;

import java.time.LocalDate;

import com.glucocoach.server.domain.enums.DiabetesType;
import com.glucocoach.server.domain.enums.GlucoseUnit;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;

@Data
public class ProfileRequest {
    @NotNull
    DiabetesType diabetesType;
    @Positive
    Long height;
    LocalDate diabetesSince;
    String basalInsulinName;
    String bolusInsulinName;
    @NotNull
    GlucoseUnit glucoseUnit;
    @Positive
    Long prescribedBasalDose;
}