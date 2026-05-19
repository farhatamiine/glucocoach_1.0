// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glucose.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NightscoutEntryDTOImpl _$$NightscoutEntryDTOImplFromJson(
  Map<String, dynamic> json,
) => _$NightscoutEntryDTOImpl(
  type: json['type'] as String?,
  sysTime: json['sysTime'] as String?,
  delta: (json['delta'] as num?)?.toDouble(),
  direction: json['direction'] as String?,
  sgv: (json['sgv'] as num?)?.toInt(),
  utcOffset: (json['utcOffset'] as num?)?.toInt(),
  id: json['id'] as String?,
);

Map<String, dynamic> _$$NightscoutEntryDTOImplToJson(
  _$NightscoutEntryDTOImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'sysTime': instance.sysTime,
  'delta': instance.delta,
  'direction': instance.direction,
  'sgv': instance.sgv,
  'utcOffset': instance.utcOffset,
  'id': instance.id,
};

_$GlucoseSummaryResponseImpl _$$GlucoseSummaryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$GlucoseSummaryResponseImpl(
  dataPoints: (json['dataPoints'] as num).toInt(),
  daysAnalyzed: (json['daysAnalyzed'] as num).toInt(),
  average: (json['average'] as num).toDouble(),
  stdDev: (json['stdDev'] as num).toDouble(),
  cv: (json['cv'] as num).toDouble(),
  gmi: (json['gmi'] as num).toDouble(),
  tir: (json['tir'] as num).toDouble(),
  tbr: (json['tbr'] as num).toDouble(),
  tar: (json['tar'] as num).toDouble(),
  tirByDay: (json['tirByDay'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  hypos: (json['hypos'] as num).toInt(),
  severeHypos: (json['severeHypos'] as num).toInt(),
  hypers: (json['hypers'] as num).toInt(),
  severeHypers: (json['severeHypers'] as num).toInt(),
  currentTrend: json['currentTrend'] as Map<String, dynamic>?,
  rapidRiseEvents: (json['rapidRiseEvents'] as num).toInt(),
  rapidFallEvents: (json['rapidFallEvents'] as num).toInt(),
  dailyAverageByHour: (json['dailyAverageByHour'] as Map<String, dynamic>?)
      ?.map((k, e) => MapEntry(k, (e as num).toDouble())),
  agp: (json['agp'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(
      k,
      (e as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    ),
  ),
  estimatedIsf: (json['estimatedIsf'] as num?)?.toDouble(),
  mealBolusCorrelation: (json['mealBolusCorrelation'] as Map<String, dynamic>?)
      ?.map((k, e) => MapEntry(k, e as bool)),
  lbgi: (json['lbgi'] as num).toDouble(),
  hbgi: (json['hbgi'] as num).toDouble(),
  rapidRiseEntries: (json['rapidRiseEntries'] as List<dynamic>?)
      ?.map((e) => NightscoutEntryDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
  rapidFallEntries: (json['rapidFallEntries'] as List<dynamic>?)
      ?.map((e) => NightscoutEntryDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$GlucoseSummaryResponseImplToJson(
  _$GlucoseSummaryResponseImpl instance,
) => <String, dynamic>{
  'dataPoints': instance.dataPoints,
  'daysAnalyzed': instance.daysAnalyzed,
  'average': instance.average,
  'stdDev': instance.stdDev,
  'cv': instance.cv,
  'gmi': instance.gmi,
  'tir': instance.tir,
  'tbr': instance.tbr,
  'tar': instance.tar,
  'tirByDay': instance.tirByDay,
  'hypos': instance.hypos,
  'severeHypos': instance.severeHypos,
  'hypers': instance.hypers,
  'severeHypers': instance.severeHypers,
  'currentTrend': instance.currentTrend,
  'rapidRiseEvents': instance.rapidRiseEvents,
  'rapidFallEvents': instance.rapidFallEvents,
  'dailyAverageByHour': instance.dailyAverageByHour,
  'agp': instance.agp,
  'estimatedIsf': instance.estimatedIsf,
  'mealBolusCorrelation': instance.mealBolusCorrelation,
  'lbgi': instance.lbgi,
  'hbgi': instance.hbgi,
  'rapidRiseEntries': instance.rapidRiseEntries,
  'rapidFallEntries': instance.rapidFallEntries,
};

_$AGPHourlyImpl _$$AGPHourlyImplFromJson(Map<String, dynamic> json) =>
    _$AGPHourlyImpl(
      hour: (json['hour'] as num).toInt(),
      p5: (json['p5'] as num).toDouble(),
      p25: (json['p25'] as num).toDouble(),
      p50: (json['p50'] as num).toDouble(),
      p75: (json['p75'] as num).toDouble(),
      p95: (json['p95'] as num).toDouble(),
    );

Map<String, dynamic> _$$AGPHourlyImplToJson(_$AGPHourlyImpl instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'p5': instance.p5,
      'p25': instance.p25,
      'p50': instance.p50,
      'p75': instance.p75,
      'p95': instance.p95,
    };

_$TIRResultImpl _$$TIRResultImplFromJson(Map<String, dynamic> json) =>
    _$TIRResultImpl(
      inRangePercent: (json['inRangePercent'] as num).toDouble(),
      below70Percent: (json['below70Percent'] as num).toDouble(),
      above180Percent: (json['above180Percent'] as num).toDouble(),
      average: (json['average'] as num).toDouble(),
    );

Map<String, dynamic> _$$TIRResultImplToJson(_$TIRResultImpl instance) =>
    <String, dynamic>{
      'inRangePercent': instance.inRangePercent,
      'below70Percent': instance.below70Percent,
      'above180Percent': instance.above180Percent,
      'average': instance.average,
    };

_$RiskResultImpl _$$RiskResultImplFromJson(Map<String, dynamic> json) =>
    _$RiskResultImpl(
      lbgi: (json['lbgi'] as num).toDouble(),
      hbgi: (json['hbgi'] as num).toDouble(),
    );

Map<String, dynamic> _$$RiskResultImplToJson(_$RiskResultImpl instance) =>
    <String, dynamic>{'lbgi': instance.lbgi, 'hbgi': instance.hbgi};
