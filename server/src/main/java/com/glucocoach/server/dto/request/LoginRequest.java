package com.glucocoach.server.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

// NOTE: Used by POST /api/users/login
@Data

public class LoginRequest {
    @NotBlank
    String email;

    @NotBlank
    String password;
}
