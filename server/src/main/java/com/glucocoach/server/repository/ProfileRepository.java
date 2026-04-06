package com.glucocoach.server.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.Profile;

@Repository
public interface ProfileRepository extends JpaRepository<Profile, Long> {
    // → used by ProfileService to load a user's profile
    Optional<Profile> findByUserId(Long userId);

    // → used by ProfileService.create() to prevent duplicate profiles
    boolean existsByUserId(Long userId);
}
