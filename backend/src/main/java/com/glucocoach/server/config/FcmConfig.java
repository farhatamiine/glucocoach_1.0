package com.glucocoach.server.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@Slf4j
@Configuration
@ConditionalOnExpression("!'${app.firebase.credentials-path:}'.trim().isEmpty()")
public class FcmConfig {

    @Value("${app.firebase.credentials-path}")
    private String credentialsPath;

    @Bean
    public FirebaseMessaging firebaseMessaging() throws IOException {
        File credentialsFile = new File(credentialsPath);
        if (!credentialsFile.exists()) {
            throw new IllegalStateException(
                    "Firebase credentials file not found at: " + credentialsPath +
                    ". Fix app.firebase.credentials-path, or leave it blank to disable FCM.");
        }
        GoogleCredentials credentials = GoogleCredentials.fromStream(
                new FileInputStream(credentialsFile));
        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(credentials)
                .build();
        if (FirebaseApp.getApps().isEmpty()) {
            FirebaseApp.initializeApp(options);
        }
        return FirebaseMessaging.getInstance();
    }
}
