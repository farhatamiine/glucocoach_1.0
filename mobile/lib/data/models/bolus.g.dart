// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bolus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BolusImpl _$$BolusImplFromJson(Map<String, dynamic> json) => _$BolusImpl(
  id: (json['id'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  bolusType: $enumDecode(_$BolusTypeEnumMap, json['bolusType']),
  timestamp: DateTime.parse(json['timestamp'] as String),
  mealId: (json['mealId'] as num?)?.toInt(),
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$$BolusImplToJson(_$BolusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'bolusType': _$BolusTypeEnumMap[instance.bolusType]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'mealId': instance.mealId,
      'userId': instance.userId,
    };

const _$BolusTypeEnumMap = {
  BolusType.MEAL: 'MEAL',
  BolusType.CORRECTION: 'CORRECTION',
};

_$BolusRequestImpl _$$BolusRequestImplFromJson(Map<String, dynamic> json) =>
    _$BolusRequestImpl(
      amount: (json['amount'] as num).toDouble(),
      bolusType: $enumDecode(_$BolusTypeEnumMap, json['bolusType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      mealId: (json['mealId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BolusRequestImplToJson(_$BolusRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'bolusType': _$BolusTypeEnumMap[instance.bolusType]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'mealId': instance.mealId,
    };

_$BolusResponseImpl _$$BolusResponseImplFromJson(Map<String, dynamic> json) =>
    _$BolusResponseImpl(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      bolusType: $enumDecode(_$BolusTypeEnumMap, json['bolusType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      mealId: (json['mealId'] as num?)?.toInt(),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$BolusResponseImplToJson(_$BolusResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'bolusType': _$BolusTypeEnumMap[instance.bolusType]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'mealId': instance.mealId,
      'userId': instance.userId,
    };
