package com.glucocoach.server.domain;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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
@ToString(exclude = "user")
@Entity
@Table(name = "meal")
public class Meal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private Double carbs;

    private LocalDateTime timestamp;

    @Column(nullable = true)
    private String imageUrl;            // local file path set by MealImageController

    @Column(nullable = true, length = 2000)
    private String analysisResult;      // raw JSON from LLM — never reinterpreted in the app layer

    @Column(nullable = true)
    private Double estimatedCarbs;      // LLM estimate — separate from user-confirmed carbs

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
}
