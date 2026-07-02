package com.glucocoach.server.config;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * One-shot data migration: explodes each legacy {@code labo_analysis} row
 * (fixed columns hba1c / cholesterol / triglycerides) into one
 * {@code lab_result} row per non-null value, keeping the original date and
 * user. Runs after Hibernate has created {@code lab_result} (ddl-auto=update).
 *
 * <p>Idempotent: after copying, the legacy table is renamed to
 * {@code labo_analysis_migrated} (data preserved), so later startups find no
 * {@code labo_analysis} table and skip.</p>
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class LaboAnalysisMigration implements ApplicationRunner {

    private final JdbcTemplate jdbcTemplate;

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        Boolean legacyTableExists = jdbcTemplate.queryForObject(
                "SELECT EXISTS (SELECT 1 FROM information_schema.tables "
                        + "WHERE table_schema = current_schema() AND table_name = 'labo_analysis')",
                Boolean.class);
        if (legacyTableExists == null || !legacyTableExists) {
            return;
        }

        int migrated = 0;
        migrated += copyColumn("hba1c", "HBA1C", "%");
        migrated += copyColumn("cholesterol", "TOTAL_CHOLESTEROL", "g/L");
        migrated += copyColumn("triglycerides", "TRIGLYCERIDES", "g/L");

        jdbcTemplate.execute("ALTER TABLE labo_analysis RENAME TO labo_analysis_migrated");
        log.info("Migrated {} labo_analysis values into lab_result; "
                + "legacy table renamed to labo_analysis_migrated", migrated);
    }

    private int copyColumn(String legacyColumn, String type, String unit) {
        return jdbcTemplate.update(
                "INSERT INTO lab_result (type, value, unit, date, user_id) "
                        + "SELECT ?, " + legacyColumn + ", ?, date, user_id "
                        + "FROM labo_analysis WHERE " + legacyColumn + " IS NOT NULL",
                type, unit);
    }
}
