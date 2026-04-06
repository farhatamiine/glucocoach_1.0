package com.glucocoach.server.dto.response;

import lombok.Builder;
import lombok.Data;

//? NOTE: Returned by POST /api/users/login and POST /api/auth/refresh
@Data
@Builder
public class AuthResponse {
    String accessToken;
    String refreshToken;
    @Builder.Default
    String tokenType = "Bearer";
}
