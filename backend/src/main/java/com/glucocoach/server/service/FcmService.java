package com.glucocoach.server.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.MessagingErrorCode;
import com.google.firebase.messaging.Notification;
import com.google.firebase.messaging.WebpushConfig;
import com.google.firebase.messaging.WebpushNotification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Collections;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class FcmService {

    // Optional because FcmConfig is @ConditionalOnExpression — absent in dev/CI
    private final Optional<FirebaseMessaging> firebaseMessaging;

    /**
     * Sends a push notification.
     *
     * @return {@code true} if the message was sent (or gracefully skipped due to missing
     *         config / blank token); {@code false} if the token is stale and should be
     *         cleared by the caller (UNREGISTERED or INVALID_ARGUMENT from Firebase).
     */
    public boolean sendPush(String fcmToken, String title, String body) {
        return sendPush(fcmToken, title, body, Collections.emptyMap());
    }

    /**
     * Sends a push notification with a custom data payload.
     */
    public boolean sendPush(String fcmToken, String title, String body, Map<String, String> data) {
        if (firebaseMessaging.isEmpty()) {
            log.warn("FCM not configured — skipping push (set app.firebase.credentials-path to enable)");
            return true;
        }
        if (!StringUtils.hasText(fcmToken)) {
            log.warn("No FCM token provided — skipping push notification");
            return true;
        }
        try {
            Message message = Message.builder()
                    .setNotification(Notification.builder()
                            .setTitle(title)
                            .setBody(body)
                            .build())
                    .putAllData(data)
                    .setWebpushConfig(WebpushConfig.builder()
                            .setNotification(WebpushNotification.builder()
                                    .setIcon("/assets/logo/gluco-coach-icon.png")
                                    .build())
                            .setFcmOptions(com.google.firebase.messaging.WebpushFcmOptions.withLink("/"))
                            .build())
                    .setToken(fcmToken)
                    .build();
            String messageId = firebaseMessaging.get().send(message);
            log.info("FCM push sent, messageId={}, data={}", messageId, data);
            return true;
        } catch (FirebaseMessagingException e) {
            MessagingErrorCode code = e.getMessagingErrorCode();
            if (code == MessagingErrorCode.UNREGISTERED || code == MessagingErrorCode.INVALID_ARGUMENT) {
                // Token is stale or malformed — caller must clear it to avoid repeated failures.
                // Note: INVALID_ARGUMENT can also mean a bad payload, but clearing a token that
                // produces INVALID_ARGUMENT repeatedly is the safer fallback.
                log.warn("FCM token stale or invalid (code={}), token={} — caller should clear token",
                        code, fcmToken);
                return false;
            }
            // Transient error (quota, server unavailable, etc.) — preserve stack trace for diagnostics.
            // Never rethrow — scheduler must continue processing other users.
            log.error("Failed to send FCM push", e);
            return true;
        }
    }
}
