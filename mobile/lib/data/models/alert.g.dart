// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlertImpl _$$AlertImplFromJson(Map<String, dynamic> json) => _$AlertImpl(
  id: (json['id'] as num).toInt(),
  thresholdLow: (json['thresholdLow'] as num).toDouble(),
  thresholdHigh: (json['thresholdHigh'] as num).toDouble(),
  notifyVia: $enumDecode(_$NotifyViaEnumMap, json['notifyVia']),
  active: json['active'] as bool,
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$$AlertImplToJson(_$AlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thresholdLow': instance.thresholdLow,
      'thresholdHigh': instance.thresholdHigh,
      'notifyVia': _$NotifyViaEnumMap[instance.notifyVia]!,
      'active': instance.active,
      'userId': instance.userId,
    };

const _$NotifyViaEnumMap = {
  NotifyVia.SMS: 'SMS',
  NotifyVia.PUSH: 'PUSH',
  NotifyVia.EMAIL: 'EMAIL',
};

_$AlertRequestImpl _$$AlertRequestImplFromJson(Map<String, dynamic> json) =>
    _$AlertRequestImpl(
      thresholdLow: (json['thresholdLow'] as num).toDouble(),
      thresholdHigh: (json['thresholdHigh'] as num).toDouble(),
      notifyVia: $enumDecode(_$NotifyViaEnumMap, json['notifyVia']),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$$AlertRequestImplToJson(_$AlertRequestImpl instance) =>
    <String, dynamic>{
      'thresholdLow': instance.thresholdLow,
      'thresholdHigh': instance.thresholdHigh,
      'notifyVia': _$NotifyViaEnumMap[instance.notifyVia]!,
      'active': instance.active,
    };

_$AlertResponseImpl _$$AlertResponseImplFromJson(Map<String, dynamic> json) =>
    _$AlertResponseImpl(
      id: (json['id'] as num).toInt(),
      thresholdLow: (json['thresholdLow'] as num).toDouble(),
      thresholdHigh: (json['thresholdHigh'] as num).toDouble(),
      notifyVia: $enumDecode(_$NotifyViaEnumMap, json['notifyVia']),
      active: json['active'] as bool,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$AlertResponseImplToJson(_$AlertResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thresholdLow': instance.thresholdLow,
      'thresholdHigh': instance.thresholdHigh,
      'notifyVia': _$NotifyViaEnumMap[instance.notifyVia]!,
      'active': instance.active,
      'userId': instance.userId,
    };

_$AlertHistoryImpl _$$AlertHistoryImplFromJson(Map<String, dynamic> json) =>
    _$AlertHistoryImpl(
      id: (json['id'] as num).toInt(),
      triggeredAt: DateTime.parse(json['triggeredAt'] as String),
      glucoseValue: (json['glucoseValue'] as num).toDouble(),
      message: json['message'] as String?,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$AlertHistoryImplToJson(_$AlertHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'triggeredAt': instance.triggeredAt.toIso8601String(),
      'glucoseValue': instance.glucoseValue,
      'message': instance.message,
      'userId': instance.userId,
    };

_$AlertHistoryResponseImpl _$$AlertHistoryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AlertHistoryResponseImpl(
  id: (json['id'] as num).toInt(),
  triggeredAt: DateTime.parse(json['triggeredAt'] as String),
  glucoseValue: (json['glucoseValue'] as num).toDouble(),
  message: json['message'] as String?,
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$$AlertHistoryResponseImplToJson(
  _$AlertHistoryResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'triggeredAt': instance.triggeredAt.toIso8601String(),
  'glucoseValue': instance.glucoseValue,
  'message': instance.message,
  'userId': instance.userId,
};
