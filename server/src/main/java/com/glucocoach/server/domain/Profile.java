package com.glucocoach.server.domain;

import java.time.LocalDate;

import com.glucocoach.server.domain.enums.DiabetesType;
import com.glucocoach.server.domain.enums.GlucoseUnit;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Entity
@Table(name = "Profile")
public class Profile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    Long height;
    LocalDate diabetesSince;
    DiabetesType diabetesType;
    GlucoseUnit glucoseUnit;
    Long prescribedBasalDose;
    String basalInsulinName;
    String bolusInsulinName;
    @OneToOne
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;
}
