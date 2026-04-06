package com.glucocoach.server.domain;

import java.time.LocalDateTime;

import com.glucocoach.server.domain.enums.BolusType;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
@ToString(exclude = {"user", "meal"})
@Entity
@Table(name = "bolus")
public class Bolus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Double amount;

    // @Enumerated(EnumType.STRING) → stores "MEAL" or "CORRECTION" in DB
    // Without this, Hibernate stores the ordinal (0, 1) which breaks if enum order changes
    @Enumerated(EnumType.STRING)
    private BolusType bolusType;

    private LocalDateTime timestamp;

    // nullable = true → a correction bolus has no linked meal
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "meal_id", nullable = true)
    private Meal meal;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
}
