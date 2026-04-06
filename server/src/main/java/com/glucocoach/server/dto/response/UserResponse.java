package com.glucocoach.server.dto.response;

import java.time.LocalDate;

import lombok.Data;

@Data
public class UserResponse {
    private Long id;
    private String firstName;
    private String lastName;
    private LocalDate birthDate;
    private String email;
}