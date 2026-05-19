// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juggluco.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JugglucoReadingImpl _$$JugglucoReadingImplFromJson(
  Map<String, dynamic> json,
) => _$JugglucoReadingImpl(
  sensorId: json['sensorId'] as String?,
  nr: (json['nr'] as num?)?.toInt(),
  unixTime: (json['unixTime'] as num?)?.toInt(),
  timestamp: json['timestamp'] as String?,
  tz: (json['tz'] as num?)?.toInt(),
  min: (json['min'] as num?)?.toInt(),
  mgDl: (json['mg/dL'] as num?)?.toInt(),
  rate: (json['rate'] as num?)?.toDouble(),
  changeLabel: json['changeLabel'] as String?,
);

Map<String, dynamic> _$$JugglucoReadingImplToJson(
  _$JugglucoReadingImpl instance,
) => <String, dynamic>{
  'sensorId': instance.sensorId,
  'nr': instance.nr,
  'unixTime': instance.unixTime,
  'timestamp': instance.timestamp,
  'tz': instance.tz,
  'min': instance.min,
  'mg/dL': instance.mgDl,
  'rate': instance.rate,
  'changeLabel': instance.changeLabel,
};

_$JugglucoGlucoseImpl _$$JugglucoGlucoseImplFromJson(
  Map<String, dynamic> json,
) => _$JugglucoGlucoseImpl(
  glucose: (json['glucose'] as num).toInt(),
  direction: json['direction'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String),
  rate: (json['rate'] as num?)?.toDouble(),
  changeLabel: json['changeLabel'] as String?,
  isConnected: json['isConnected'] as bool?,
);

Map<String, dynamic> _$$JugglucoGlucoseImplToJson(
  _$JugglucoGlucoseImpl instance,
) => <String, dynamic>{
  'glucose': instance.glucose,
  'direction': instance.direction,
  'timestamp': instance.timestamp.toIso8601String(),
  'rate': instance.rate,
  'changeLabel': instance.changeLabel,
  'isConnected': instance.isConnected,
};
