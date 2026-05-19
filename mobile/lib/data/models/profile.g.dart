// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: (json['id'] as num).toInt(),
      diabetesType: $enumDecode(_$DiabetesTypeEnumMap, json['diabetesType']),
      height: (json['height'] as num?)?.toInt(),
      diabetesSince: json['diabetesSince'] == null
          ? null
          : DateTime.parse(json['diabetesSince'] as String),
      basalInsulinName: json['basalInsulinName'] as String?,
      bolusInsulinName: json['bolusInsulinName'] as String?,
      glucoseUnit: $enumDecode(_$GlucoseUnitEnumMap, json['glucoseUnit']),
      prescribedBasalDose: (json['prescribedBasalDose'] as num?)?.toInt(),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'diabetesType': _$DiabetesTypeEnumMap[instance.diabetesType]!,
      'height': instance.height,
      'diabetesSince': instance.diabetesSince?.toIso8601String(),
      'basalInsulinName': instance.basalInsulinName,
      'bolusInsulinName': instance.bolusInsulinName,
      'glucoseUnit': _$GlucoseUnitEnumMap[instance.glucoseUnit]!,
      'prescribedBasalDose': instance.prescribedBasalDose,
      'userId': instance.userId,
    };

const _$DiabetesTypeEnumMap = {
  DiabetesType.TYPE_1: 'TYPE_1',
  DiabetesType.TYPE_2: 'TYPE_2',
};

const _$GlucoseUnitEnumMap = {GlucoseUnit.MG: 'MG', GlucoseUnit.MMOL: 'MMOL'};

_$ProfileRequestImpl _$$ProfileRequestImplFromJson(Map<String, dynamic> json) =>
    _$ProfileRequestImpl(
      diabetesType: $enumDecode(_$DiabetesTypeEnumMap, json['diabetesType']),
      height: (json['height'] as num?)?.toInt(),
      diabetesSince: json['diabetesSince'] == null
          ? null
          : DateTime.parse(json['diabetesSince'] as String),
      basalInsulinName: json['basalInsulinName'] as String?,
      bolusInsulinName: json['bolusInsulinName'] as String?,
      glucoseUnit: $enumDecode(_$GlucoseUnitEnumMap, json['glucoseUnit']),
      prescribedBasalDose: (json['prescribedBasalDose'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProfileRequestImplToJson(
  _$ProfileRequestImpl instance,
) => <String, dynamic>{
  'diabetesType': _$DiabetesTypeEnumMap[instance.diabetesType]!,
  'height': instance.height,
  'diabetesSince': instance.diabetesSince?.toIso8601String(),
  'basalInsulinName': instance.basalInsulinName,
  'bolusInsulinName': instance.bolusInsulinName,
  'glucoseUnit': _$GlucoseUnitEnumMap[instance.glucoseUnit]!,
  'prescribedBasalDose': instance.prescribedBasalDose,
};

_$ProfileResponseImpl _$$ProfileResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileResponseImpl(
  id: (json['id'] as num).toInt(),
  diabetesType: $enumDecode(_$DiabetesTypeEnumMap, json['diabetesType']),
  height: (json['height'] as num?)?.toInt(),
  diabetesSince: json['diabetesSince'] == null
      ? null
      : DateTime.parse(json['diabetesSince'] as String),
  basalInsulinName: json['basalInsulinName'] as String?,
  bolusInsulinName: json['bolusInsulinName'] as String?,
  glucoseUnit: $enumDecode(_$GlucoseUnitEnumMap, json['glucoseUnit']),
  prescribedBasalDose: (json['prescribedBasalDose'] as num?)?.toInt(),
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$$ProfileResponseImplToJson(
  _$ProfileResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'diabetesType': _$DiabetesTypeEnumMap[instance.diabetesType]!,
  'height': instance.height,
  'diabetesSince': instance.diabetesSince?.toIso8601String(),
  'basalInsulinName': instance.basalInsulinName,
  'bolusInsulinName': instance.bolusInsulinName,
  'glucoseUnit': _$GlucoseUnitEnumMap[instance.glucoseUnit]!,
  'prescribedBasalDose': instance.prescribedBasalDose,
  'userId': instance.userId,
};
