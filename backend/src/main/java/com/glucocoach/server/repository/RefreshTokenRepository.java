package com.glucocoach.server.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.RefreshToken;
import com.glucocoach.server.domain.User;

@Repository
public interface RefreshTokenRepository extends JpaRepository<RefreshToken, Long> {
    Optional<RefreshToken> findByToken(String token);

    // @Transactional is required on all derived delete queries in Spring Data JPA
    // Without it Spring throws "No EntityManager with actual transaction available"
    @Transactional
    void deleteByUser(User user);
}
