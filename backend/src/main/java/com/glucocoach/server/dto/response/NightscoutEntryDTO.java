package com.glucocoach.server.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class NightscoutEntryDTO {
    @JsonProperty("_id")
    private String id;
    private String type;
    private String sysTime;
    private Double delta;
    private String direction;
    private Integer sgv;
    private Integer utcOffset;
}