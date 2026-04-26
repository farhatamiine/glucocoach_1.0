package com.glucocoach.server.domain;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

// ─────────────────────────────────────────────────────────────────────────────
// WHY implements UserDetails?
//
//   UserDetails is a Spring Security interface. By making our User entity
//   implement it, we tell Spring Security: "THIS is your user object —
//   use it directly for authentication."
//
//   Spring Security needs to know 5 things about every user:
//   1. What is the username?           → getUsername()
//   2. What is the (hashed) password?  → getPassword()
//   3. What roles/permissions?         → getAuthorities()
//   4. Is the account expired?         → isAccountNonExpired()
//   5. Is the account locked?          → isAccountNonLocked()
//   6. Are credentials expired?        → isCredentialsNonExpired()
//   7. Is the account enabled?         → isEnabled()
//
//   We MUST implement all 7 methods. For a simple app, methods 3-7
//   can just return a hardcoded value (no roles = empty list, always active).
// ─────────────────────────────────────────────────────────────────────────────

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
@Builder
@Entity
@Table(name = "Users")
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String firstName;
    String lastName;
    LocalDate birthDate;
    String email;

    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    String password;

    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    @Column(unique = true)
    private String resetTokenHash;

    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private java.time.Instant resetTokenExpiresAt;

    @Column(nullable = true)
    private String fcmToken;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private Profile profile;

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(); // no roles for now
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
