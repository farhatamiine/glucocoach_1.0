package com.glucocoach.server.domain;

import java.time.LocalDateTime;

import com.glucocoach.server.domain.enums.AlertDirection;
import com.glucocoach.server.domain.enums.NotifyVia;
import jakarta.persistence.Column;
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
@ToString(exclude = "user")
@Entity
@Table(name = "alert_history")
public class AlertHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime triggeredAt;

    private Double glucoseValue;

    // Text column for longer messages
    @Column(length = 500)
    private String message;

    @Enumerated(EnumType.STRING)
    private AlertDirection direction;

    @Enumerated(EnumType.STRING)
    private NotifyVia notifyVia;

    private Long alertId;   // no FK — history survives alert deletion

    // No FK to Alert — history is kept even if the alert config is deleted
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
}
