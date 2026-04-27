package com.glucocoach.server.scheduler;

import com.glucocoach.server.domain.Alert;
import com.glucocoach.server.domain.AlertHistory;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.AlertDirection;
import com.glucocoach.server.domain.enums.NotifyVia;
import com.glucocoach.server.dto.response.NightscoutEntryDTO;
import com.glucocoach.server.repository.AlertHistoryRepository;
import com.glucocoach.server.repository.AlertRepository;
import com.glucocoach.server.service.FcmService;
import com.glucocoach.server.service.NightScoutService;
import com.glucocoach.server.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class GlucoseAlertSchedulerTest {

    @Mock private AlertRepository alertRepository;
    @Mock private NightScoutService nightScoutService;
    @Mock private FcmService fcmService;
    @Mock private AlertHistoryRepository alertHistoryRepository;
    @Mock private UserService userService;

    @InjectMocks
    private GlucoseAlertScheduler scheduler;

    private User user;
    private Alert alert;

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .email("test@example.com")
                .fcmToken("device-fcm-token")
                .build();

        alert = Alert.builder()
                .id(10L)
                .thresholdLow(70.0)
                .thresholdHigh(180.0)
                .notifyVia(NotifyVia.PUSH)
                .active(true)
                .user(user)
                .build();
    }

    @Test
    void checkGlucoseAlerts_shouldSendPushAndSaveHistory_whenSgvBelowLowThreshold() {
        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(60);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));
        when(fcmService.sendPush(eq("device-fcm-token"), eq("GlucoCoach Alert"), contains("Low glucose: 60"))).thenReturn(true);

        scheduler.checkGlucoseAlerts();

        verify(fcmService).sendPush(
                eq("device-fcm-token"),
                eq("GlucoCoach Alert"),
                contains("Low glucose: 60"));

        ArgumentCaptor<AlertHistory> captor = ArgumentCaptor.forClass(AlertHistory.class);
        verify(alertHistoryRepository).save(captor.capture());
        AlertHistory saved = captor.getValue();
        assertThat(saved.getDirection()).isEqualTo(AlertDirection.LOW);
        assertThat(saved.getGlucoseValue()).isEqualTo(60.0);
        assertThat(saved.getNotifyVia()).isEqualTo(NotifyVia.PUSH);
        assertThat(saved.getAlertId()).isEqualTo(10L);
        assertThat(saved.getUser()).isEqualTo(user);
        assertThat(saved.getTriggeredAt()).isNotNull();
        assertThat(saved.getMessage()).contains("Low glucose: 60");
    }

    @Test
    void checkGlucoseAlerts_shouldSendPushAndSaveHistory_whenSgvAboveHighThreshold() {
        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(220);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));
        when(fcmService.sendPush(eq("device-fcm-token"), eq("GlucoCoach Alert"), contains("High glucose: 220"))).thenReturn(true);

        scheduler.checkGlucoseAlerts();

        verify(fcmService).sendPush(
                eq("device-fcm-token"),
                eq("GlucoCoach Alert"),
                contains("High glucose: 220"));

        ArgumentCaptor<AlertHistory> captor = ArgumentCaptor.forClass(AlertHistory.class);
        verify(alertHistoryRepository).save(captor.capture());
        AlertHistory saved = captor.getValue();
        assertThat(saved.getDirection()).isEqualTo(AlertDirection.HIGH);
        assertThat(saved.getGlucoseValue()).isEqualTo(220.0);
        assertThat(saved.getMessage()).contains("High glucose: 220");
    }

    @Test
    void checkGlucoseAlerts_shouldNotFireAnything_whenSgvInRange() {
        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(100);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));

        scheduler.checkGlucoseAlerts();

        verify(fcmService, never()).sendPush(any(), any(), any());
        verify(alertHistoryRepository, never()).save(any());
    }

    @Test
    void checkGlucoseAlerts_shouldPassNullTokenToFcmService_whenFcmTokenIsNull() {
        // FcmService handles null token internally and logs a warning — scheduler must not throw
        User userNoToken = User.builder().id(2L).email("notok@example.com").fcmToken(null).build();
        Alert alertNoToken = Alert.builder()
                .id(11L).thresholdLow(70.0).thresholdHigh(180.0)
                .notifyVia(NotifyVia.PUSH).active(true).user(userNoToken).build();

        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(60);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alertNoToken));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));
        when(fcmService.sendPush(isNull(), eq("GlucoCoach Alert"), contains("Low glucose"))).thenReturn(true);

        scheduler.checkGlucoseAlerts();

        verify(fcmService).sendPush(isNull(), eq("GlucoCoach Alert"), contains("Low glucose"));
        verify(alertHistoryRepository).save(any(AlertHistory.class));
    }

    @Test
    void checkGlucoseAlerts_shouldSkipUser_whenNightscoutReturnsEmpty() {
        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of());

        scheduler.checkGlucoseAlerts();

        verify(fcmService, never()).sendPush(any(), any(), any());
        verify(alertHistoryRepository, never()).save(any());
    }

    @Test
    void checkGlucoseAlerts_shouldClearFcmToken_whenSendPushReturnsFalse() {
        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(60);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));
        when(fcmService.sendPush(eq("device-fcm-token"), eq("GlucoCoach Alert"), contains("Low glucose: 60"))).thenReturn(false);

        scheduler.checkGlucoseAlerts();

        verify(userService).clearFcmToken(user.getId());
        verify(alertHistoryRepository).save(any(AlertHistory.class));
    }
}
