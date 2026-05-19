package com.glucocoach.server.controller;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.AlertDirection;
import com.glucocoach.server.domain.enums.NotifyVia;
import com.glucocoach.server.dto.response.AlertHistoryResponse;
import com.glucocoach.server.service.AlertHistoryService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.MethodParameter;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
class AlertHistoryControllerTest {

    @Mock
    private AlertHistoryService alertHistoryService;

    @InjectMocks
    private AlertHistoryController alertHistoryController;

    private MockMvc mockMvc;
    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = User.builder()
                .id(1L)
                .email("test@example.com")
                .firstName("John")
                .lastName("Doe")
                .birthDate(LocalDate.of(1990, 1, 1))
                .password("secret")
                .build();

        mockMvc = MockMvcBuilders.standaloneSetup(alertHistoryController)
                .setCustomArgumentResolvers(new AuthenticationPrincipalResolver(testUser))
                .build();
    }

    @Test
    void getAll_shouldReturnAlertHistoryList() throws Exception {
        AlertHistoryResponse response = new AlertHistoryResponse();
        response.setId(1L);
        response.setTriggeredAt(LocalDateTime.now());
        response.setGlucoseValue(55.0);
        response.setMessage("Low glucose: 55 mg/dL (threshold: 70.0)");
        response.setDirection(AlertDirection.LOW);
        response.setNotifyVia(NotifyVia.PUSH);
        response.setUserId(1L);

        when(alertHistoryService.getAll(testUser.getEmail())).thenReturn(List.of(response));

        mockMvc.perform(get("/api/alert-history"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].id").value(1))
                .andExpect(jsonPath("$[0].glucoseValue").value(55.0))
                .andExpect(jsonPath("$[0].direction").value("LOW"))
                .andExpect(jsonPath("$[0].notifyVia").value("PUSH"));
    }

    /**
     * Resolves @AuthenticationPrincipal parameters to the provided test user.
     */
    record AuthenticationPrincipalResolver(User principal) implements HandlerMethodArgumentResolver {
        @Override
        public boolean supportsParameter(MethodParameter parameter) {
            return parameter.getParameterAnnotation(AuthenticationPrincipal.class) != null;
        }

        @Override
        public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
                                      NativeWebRequest webRequest, WebDataBinderFactory binderFactory) {
            return principal;
        }
    }
}
