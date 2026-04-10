package com.glucocoach.server.service;

import java.util.List;
import java.util.OptionalDouble;

import org.apache.commons.math3.stat.descriptive.DescriptiveStatistics;
import org.springframework.stereotype.Service;

import com.glucocoach.server.dto.response.NightscoutEntryDTO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class GlucoseService {

    private final NightScoutService nightScoutService;

    public Double calculateAverage(List<NightscoutEntryDTO> entries) {
        OptionalDouble avgGlucose = entries.stream().mapToInt(nsEntry -> nsEntry.getSgv()).average();
        return avgGlucose.orElse(0);
    }

    public Double calculateStdDev(List<NightscoutEntryDTO> entries) {
        DescriptiveStatistics stats = new DescriptiveStatistics();
        entries.forEach(entry -> stats.addValue(entry.getSgv().doubleValue()));
        return stats.getStandardDeviation();
    }

    public Double calculateCV(List<NightscoutEntryDTO> entries) {
        return (calculateStdDev(entries) / calculateAverage(entries)) * 100;
    }

    public Double calculateGMI(List<NightscoutEntryDTO> entries) {
        return 3.31 + (0.02392 * calculateAverage(entries));
    }

    public Double calculateTIR(List<NightscoutEntryDTO> entries) {
        Long inRangeCount = entries.stream().filter(entry -> entry.getSgv() > 70 && entry.getSgv() < 180)
                .count();
        return ((double) inRangeCount / (entries.size())) * 100;
    }

    public Double calculateTAR(List<NightscoutEntryDTO> entries) {
        Long inRangeCount = entries.stream().filter(entry -> entry.getSgv() > 180)
                .count();
        return ((double) inRangeCount / (entries.size())) * 100;
    }

    public Double calculateTBR(List<NightscoutEntryDTO> entries) {
        Long inRangeCount = entries.stream().filter(entry -> entry.getSgv() < 70)
                .count();
        return ((double) inRangeCount / (entries.size())) * 100;
    }

    public Double calculateTIRByDay(List<NightscoutEntryDTO> entries){
        entries.
    }

}
