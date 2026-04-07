package com.glucocoach.server.domain;

import java.time.Instant;

import jakarta.persistence.Column;
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

// TODO: Add Lombok annotations: @Data @NoArgsConstructor @AllArgsConstructor @Builder @ToString
// TODO: Add JPA annotations: @Entity @Table(name = "RefreshToken")
// TODO: Fields:
//        @Id @GeneratedValue(strategy = GenerationType.IDENTITY) Long id
//        @Column(nullable = false, unique = true) String token   — the raw refresh token (UUID or signed value)
//        Instant expiresAt      — expiry timestamp
//        @OneToOne @JoinColumn(name = "user_id") User user
// TODO: Create RefreshTokenService with:
//        - createRefreshToken(Long userId) → generate UUID token, set expiry, save
//        - verifyExpiration(RefreshToken)  → throw exception if expired, delete it
//        - findByToken(String token)       → Optional<RefreshToken>
//        - deleteByUserId(Long userId)     → used on logout

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Entity
@Table(name = "refresh_tokens")
public class RefreshToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @Column(nullable = false, unique = true)
    String token;
    Instant expiresAt;
    @OneToOne
    @JoinColumn(name = "user_id")
    User user;
}
