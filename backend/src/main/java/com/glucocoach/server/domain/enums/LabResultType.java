package com.glucocoach.server.domain.enums;

import lombok.Getter;

/**
 * Catalog of supported lab analytes. Default units are France-typical
 * (lipids g/L, HbA1c %, glucose mg/dL); the unit stays editable per row.
 * Reference bounds are informational defaults for the "add" form only.
 */
@Getter
public enum LabResultType {

    HBA1C("HbA1c", "%", "Glycemic control", 4.0, 6.0),
    FASTING_GLUCOSE("Fasting glucose", "mg/dL", "Glycemic control", 70.0, 100.0),
    TOTAL_CHOLESTEROL("Total cholesterol", "g/L", "Lipids", null, 2.0),
    LDL("LDL cholesterol", "g/L", "Lipids", null, 1.6),
    HDL("HDL cholesterol", "g/L", "Lipids", 0.4, null),
    TRIGLYCERIDES("Triglycerides", "g/L", "Lipids", null, 1.5),
    CREATININE("Creatinine", "mg/L", "Renal", 7.0, 13.0),
    EGFR("eGFR", "mL/min", "Renal", 60.0, null),
    MICROALBUMINURIA("Microalbuminuria", "mg/L", "Renal", null, 30.0),
    TSH("TSH", "mUI/L", "Thyroid", 0.4, 4.0),
    VITAMIN_D("Vitamin D", "ng/mL", "Vitamins", 30.0, null),
    /** Free-form analyte — requires {@code customName} on the LabResult. */
    CUSTOM("Custom", null, "Other", null, null);

    private final String displayName;
    private final String defaultUnit;
    private final String category;
    private final Double referenceLow;
    private final Double referenceHigh;

    LabResultType(String displayName, String defaultUnit, String category,
            Double referenceLow, Double referenceHigh) {
        this.displayName = displayName;
        this.defaultUnit = defaultUnit;
        this.category = category;
        this.referenceLow = referenceLow;
        this.referenceHigh = referenceHigh;
    }
}
