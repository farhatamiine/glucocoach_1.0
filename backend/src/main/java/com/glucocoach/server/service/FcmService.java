package com.glucocoach.server.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class FcmService {

    // Optional because FcmConfig is @ConditionalOnExpression — absent in dev/CI
    private final Optional<FirebaseMessaging> firebaseMessaging;

    public void sendPush(String fcmToken, String title, String body) {
        if (firebaseMessaging.isEmpty()) {
            log.warn("FCM not configured — skipping push (set app.firebase.credentials-path to enable)");
            return;
        }
        if (!StringUtils.hasText(fcmToken)) {
            log.warn("No FCM token provided — skipping push notification");
            return;
        }
        try {
            Message message = Message.builder()
                    .setNotification(Notification.builder()
                            .setTitle(title)
                            .setBody(body)
                            .build())
                    .setToken(fcmToken)
                    .build();
            String messageId = firebaseMessaging.get().send(message);
            log.info("FCM push sent, messageId={}", messageId);
        } catch (FirebaseMessagingException e) {
            log.error("Failed to send FCM push: {}", e.getMessage());
            // Never rethrow — scheduler must continue processing other users
        }
    }
}
