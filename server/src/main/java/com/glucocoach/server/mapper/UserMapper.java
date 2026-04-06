package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.UserRequest;
import com.glucocoach.server.dto.response.UserResponse;

@Component
public class UserMapper {
    // UserRequest is used for UPDATE — it only carries firstName, lastName, birthDate
    // email and password are NOT here (those are set at registration and changed separately)
    public User toEntity(UserRequest userRequest) {
        return User.builder()
                .lastName(userRequest.getLastName())
                .firstName(userRequest.getFirstName())
                .birthDate(userRequest.getBirthDate())
                .build();
    }

    public UserResponse toResponse(User user) {
        UserResponse userResponse = new UserResponse();
        userResponse.setEmail(user.getEmail());
        userResponse.setFirstName(user.getFirstName());
        userResponse.setLastName(user.getLastName());
        userResponse.setBirthDate(user.getBirthDate());
        return userResponse;
    }
}
