// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LaboAnalysisImpl _$$LaboAnalysisImplFromJson(Map<String, dynamic> json) =>
    _$LaboAnalysisImpl(
      id: (json['id'] as num).toInt(),
      hba1c: (json['hba1c'] as num?)?.toDouble(),
      cholesterol: (json['cholesterol'] as num?)?.toDouble(),
      triglycerides: (json['triglycerides'] as num?)?.toDouble(),
      date: DateTime.parse(json['date'] as String),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$LaboAnalysisImplToJson(_$LaboAnalysisImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hba1c': instance.hba1c,
      'cholesterol': instance.cholesterol,
      'triglycerides': instance.triglycerides,
      'date': instance.date.toIso8601String(),
      'userId': instance.userId,
    };

_$LaboAnalysisRequestImpl _$$LaboAnalysisRequestImplFromJson(
  Map<String, dynamic> json,
) => _$LaboAnalysisRequestImpl(
  hba1c: (json['hba1c'] as num?)?.toDouble(),
  cholesterol: (json['cholesterol'] as num?)?.toDouble(),
  triglycerides: (json['triglycerides'] as num?)?.toDouble(),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$$LaboAnalysisRequestImplToJson(
  _$LaboAnalysisRequestImpl instance,
) => <String, dynamic>{
  'hba1c': instance.hba1c,
  'cholesterol': instance.cholesterol,
  'triglycerides': instance.triglycerides,
  'date': instance.date.toIso8601String(),
};

_$LaboAnalysisResponseImpl _$$LaboAnalysisResponseImplFromJson(
  Map<String, dynamic> json,
) => _$LaboAnalysisResponseImpl(
  id: (json['id'] as num).toInt(),
  hba1c: (json['hba1c'] as num?)?.toDouble(),
  cholesterol: (json['cholesterol'] as num?)?.toDouble(),
  triglycerides: (json['triglycerides'] as num?)?.toDouble(),
  date: DateTime.parse(json['date'] as String),
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$$LaboAnalysisResponseImplToJson(
  _$LaboAnalysisResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'hba1c': instance.hba1c,
  'cholesterol': instance.cholesterol,
  'triglycerides': instance.triglycerides,
  'date': instance.date.toIso8601String(),
  'userId': instance.userId,
};
