import 'package:freezed_annotation/freezed_annotation.dart';

part 'glucose.freezed.dart';
part 'glucose.g.dart';

@freezed
class NightscoutEntryDTO with _$NightscoutEntryDTO {
  const factory NightscoutEntryDTO({
    String? type,
    String? sysTime,
    double? delta,
    String? direction,
    int? sgv,
    int? utcOffset,
    String? id,
  }) = _NightscoutEntryDTO;

  factory NightscoutEntryDTO.fromJson(Map<String, dynamic> json) =>
      _$NightscoutEntryDTOFromJson(json);
}

@freezed
class GlucoseSummaryResponse with _$GlucoseSummaryResponse {
  const factory GlucoseSummaryResponse({
    required int dataPoints,
    required int daysAnalyzed,
    required double average,
    required double stdDev,
    required double cv,
    required double gmi,
    required double tir,
    required double tbr,
    required double tar,
    Map<String, double>? tirByDay,
    required int hypos,
    required int severeHypos,
    required int hypers,
    required int severeHypers,
    Map<String, dynamic>? currentTrend,
    required int rapidRiseEvents,
    required int rapidFallEvents,
    Map<String, double>? dailyAverageByHour,
    Map<String, Map<String, double>>? agp,
    double? estimatedIsf,
    Map<String, bool>? mealBolusCorrelation,
    required double lbgi,
    required double hbgi,
    List<NightscoutEntryDTO>? rapidRiseEntries,
    List<NightscoutEntryDTO>? rapidFallEntries,
  }) = _GlucoseSummaryResponse;

  factory GlucoseSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$GlucoseSummaryResponseFromJson(json);
}

@freezed
class AGPHourly with _$AGPHourly {
  const factory AGPHourly({
    required int hour,
    required double p5,
    required double p25,
    required double p50,
    required double p75,
    required double p95,
  }) = _AGPHourly;

  factory AGPHourly.fromJson(Map<String, dynamic> json) =>
      _$AGPHourlyFromJson(json);
}

@freezed
class TIRResult with _$TIRResult {
  const factory TIRResult({
    required double inRangePercent,
    required double below70Percent,
    required double above180Percent,
    required double average,
  }) = _TIRResult;

  factory TIRResult.fromJson(Map<String, dynamic> json) =>
      _$TIRResultFromJson(json);
}

@freezed
class RiskResult with _$RiskResult {
  const factory RiskResult({
    required double lbgi,
    required double hbgi,
  }) = _RiskResult;

  factory RiskResult.fromJson(Map<String, dynamic> json) =>
      _$RiskResultFromJson(json);
}
