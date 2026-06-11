package com.glucocoach.server.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.util.Map;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.MessagingErrorCode;

@ExtendWith(MockitoExtension.class)
class FcmServiceTest {

    @Mock
    private FirebaseMessaging firebaseMessaging;

    private FcmService fcmService;

    @BeforeEach
    void setUp() {
        fcmService = new FcmService(Optional.of(firebaseMessaging));
    }

    @Test
    void sendPush_WhenFcmNotConfigured_ShouldReturnTrue() {
        fcmService = new FcmService(Optional.empty());
        boolean result = fcmService.sendPush("token", "title", "body");
        assertTrue(result);
        verifyNoInteractions(firebaseMessaging);
    }

    @Test
    void sendPush_WhenTokenBlank_ShouldReturnTrue() {
        boolean result = fcmService.sendPush("", "title", "body");
        assertTrue(result);
        verifyNoInteractions(firebaseMessaging);
    }

    @Test
    void sendPush_Success_ShouldReturnTrue() throws FirebaseMessagingException {
        when(firebaseMessaging.send(any(Message.class))).thenReturn("msg-id");

        boolean result = fcmService.sendPush("token", "title", "body", Map.of("key", "value"));

        assertTrue(result);
        verify(firebaseMessaging).send(any(Message.class));
    }

    @Test
    void sendPush_StaleToken_ShouldReturnFalse() throws FirebaseMessagingException {
        FirebaseMessagingException exception = mock(FirebaseMessagingException.class);
        when(exception.getMessagingErrorCode()).thenReturn(MessagingErrorCode.UNREGISTERED);
        when(firebaseMessaging.send(any(Message.class))).thenThrow(exception);

        boolean result = fcmService.sendPush("stale-token", "title", "body");

        assertFalse(result);
    }

    @Test
    void sendPush_TransientError_ShouldReturnTrue() throws FirebaseMessagingException {
        FirebaseMessagingException exception = mock(FirebaseMessagingException.class);
        when(exception.getMessagingErrorCode()).thenReturn(MessagingErrorCode.INTERNAL);
        when(firebaseMessaging.send(any(Message.class))).thenThrow(exception);

        boolean result = fcmService.sendPush("token", "title", "body");

        assertTrue(result, "Transient errors should not trigger token clearing");
    }
}
