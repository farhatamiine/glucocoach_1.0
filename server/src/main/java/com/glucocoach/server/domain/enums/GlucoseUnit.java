package com.glucocoach.server.domain.enums;

public enum GlucoseUnit {
    MG("mg/dl"),
    MMOL("mmol/l");

    public final String label;

    private GlucoseUnit(String label) {
        this.label = label;
    }
}
