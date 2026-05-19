// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthDataImpl _$$HealthDataImplFromJson(Map<String, dynamic> json) =>
    _$HealthDataImpl(
      id: (json['id'] as num).toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      heartRate: (json['heartRate'] as num?)?.toInt(),
      bloodPressure: json['bloodPressure'] as String?,
      date: DateTime.parse(json['date'] as String),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$HealthDataImplToJson(_$HealthDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'heartRate': instance.heartRate,
      'bloodPressure': instance.bloodPressure,
      'date': instance.date.toIso8601String(),
      'userId': instance.userId,
    };

_$HealthDataRequestImpl _$$HealthDataRequestImplFromJson(
  Map<String, dynamic> json,
) => _$HealthDataRequestImpl(
  weight: (json['weight'] as num?)?.toDouble(),
  heartRate: (json['heartRate'] as num?)?.toInt(),
  bloodPressure: json['bloodPressure'] as String?,
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$$HealthDataRequestImplToJson(
  _$HealthDataRequestImpl instance,
) => <String, dynamic>{
  'weight': instance.weight,
  'heartRate': instance.heartRate,
  'bloodPressure': instance.bloodPressure,
  'date': instance.date.toIso8601String(),
};

_$HealthDataResponseImpl _$$HealthDataResponseImplFromJson(
  Map<String, dynamic> json,
) => _$HealthDataResponseImpl(
  id: (json['id'] as num).toInt(),
  weight: (json['weight'] as num?)?.toDouble(),
  heartRate: (json['heartRate'] as num?)?.toInt(),
  bloodPressure: json['bloodPressure'] as String?,
  date: DateTime.parse(json['date'] as String),
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$$HealthDataResponseImplToJson(
  _$HealthDataResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'weight': instance.weight,
  'heartRate': instance.heartRate,
  'bloodPressure': instance.bloodPressure,
  'date': instance.date.toIso8601String(),
  'userId': instance.userId,
};
