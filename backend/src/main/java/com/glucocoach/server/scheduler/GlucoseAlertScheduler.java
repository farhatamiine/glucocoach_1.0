package com.glucocoach.server.scheduler;

import com.glucocoach.server.domain.Alert;
import com.glucocoach.server.domain.AlertHistory;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.AlertDirection;
import com.glucocoach.server.domain.enums.NotifyVia;
import com.glucocoach.server.repository.AlertHistoryRepository;
import com.glucocoach.server.repository.AlertRepository;
import com.glucocoach.server.service.FcmService;
import com.glucocoach.server.service.NightScoutService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class GlucoseAlertScheduler {

    private final AlertRepository alertRepository;
    private final NightScoutService nightScoutService;
    private final FcmService fcmService;
    private final AlertHistoryRepository alertHistoryRepository;

    @Scheduled(fixedRateString = "${app.alert.check-interval-ms:60000}")
    public void checkGlucoseAlerts() {
        List<Alert> activeAlerts = alertRepository.findByActiveTrue();

        Map<User, List<Alert>> alertsByUser = activeAlerts.stream()
                .collect(Collectors.groupingBy(Alert::getUser));

        for (Map.Entry<User, List<Alert>> entry : alertsByUser.entrySet()) {
            User user = entry.getKey();
            try {
                processAlertsForUser(user, entry.getValue());
            } catch (Exception e) {
                // Per-user isolation: a Nightscout timeout or DB error for one user
                // must never prevent the remaining users from being processed.
                log.error("Error processing alerts for user {}: {}", user.getId(), e.getMessage(), e);
            }
        }
    }

    private void processAlertsForUser(User user, List<Alert> alerts) {
        var entries = nightScoutService.getEntries(1);
        if (entries.isEmpty()) {
            log.warn("No Nightscout entries for user {} — skipping alert check", user.getId());
            return;
        }

        Integer rawSgv = entries.get(0).getSgv();
        if (rawSgv == null) {
            log.warn("Nightscout entry has no SGV for user {} — skipping", user.getId());
            return;
        }
        double sgv = rawSgv;

        // Best-effort: each AlertHistory save runs in its own implicit transaction.
        // A save failure for alert N will log + skip N but commits for 1..N-1 survive.
        // Add @Transactional here only if all-or-nothing semantics are required.
        for (Alert alert : alerts) {
            AlertDirection direction;
            if (sgv < alert.getThresholdLow()) {
                direction = AlertDirection.LOW;
            } else if (sgv > alert.getThresholdHigh()) {
                direction = AlertDirection.HIGH;
            } else {
                continue;   // in range — no alert, no history
            }

            String title = "GlucoCoach Alert";
            String body = direction == AlertDirection.LOW
                    ? "Low glucose: " + (int) sgv + " mg/dL (threshold: " + alert.getThresholdLow() + ")"
                    : "High glucose: " + (int) sgv + " mg/dL (threshold: " + alert.getThresholdHigh() + ")";

            NotifyVia notifyVia = alert.getNotifyVia();
            switch (notifyVia) {
                case PUSH  -> fcmService.sendPush(user.getFcmToken(), title, body);
                case EMAIL -> log.info("EMAIL not yet implemented — user {}", user.getId());
                case SMS   -> log.info("SMS not yet implemented — user {}", user.getId());
            }

            alertHistoryRepository.save(AlertHistory.builder()
                    .triggeredAt(LocalDateTime.now())
                    .glucoseValue(sgv)
                    .message(body)
                    .direction(direction)
                    .notifyVia(notifyVia)
                    .alertId(alert.getId())
                    .user(user)
                    .build());
        }
    }
}
