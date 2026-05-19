// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealAnalysisResultImpl _$$MealAnalysisResultImplFromJson(
  Map<String, dynamic> json,
) => _$MealAnalysisResultImpl(
  name: json['name'] as String?,
  estimatedCarbs: (json['estimatedCarbs'] as num?)?.toDouble(),
  ingredients: (json['ingredients'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  confidence: json['confidence'] as String?,
);

Map<String, dynamic> _$$MealAnalysisResultImplToJson(
  _$MealAnalysisResultImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'estimatedCarbs': instance.estimatedCarbs,
  'ingredients': instance.ingredients,
  'confidence': instance.confidence,
};

_$MealImpl _$$MealImplFromJson(Map<String, dynamic> json) => _$MealImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  carbs: (json['carbs'] as num).toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
  userId: (json['userId'] as num).toInt(),
  analysis: json['analysis'] == null
      ? null
      : MealAnalysisResult.fromJson(json['analysis'] as Map<String, dynamic>),
  estimatedCarbs: (json['estimatedCarbs'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$MealImplToJson(_$MealImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'carbs': instance.carbs,
      'timestamp': instance.timestamp.toIso8601String(),
      'userId': instance.userId,
      'analysis': instance.analysis,
      'estimatedCarbs': instance.estimatedCarbs,
      'imageUrl': instance.imageUrl,
    };

_$MealRequestImpl _$$MealRequestImplFromJson(Map<String, dynamic> json) =>
    _$MealRequestImpl(
      name: json['name'] as String,
      carbs: (json['carbs'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MealRequestImplToJson(_$MealRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'carbs': instance.carbs,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$MealResponseImpl _$$MealResponseImplFromJson(Map<String, dynamic> json) =>
    _$MealResponseImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      carbs: (json['carbs'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: (json['userId'] as num).toInt(),
      analysis: json['analysis'] == null
          ? null
          : MealAnalysisResult.fromJson(
              json['analysis'] as Map<String, dynamic>,
            ),
      estimatedCarbs: (json['estimatedCarbs'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$MealResponseImplToJson(_$MealResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'carbs': instance.carbs,
      'timestamp': instance.timestamp.toIso8601String(),
      'userId': instance.userId,
      'analysis': instance.analysis,
      'estimatedCarbs': instance.estimatedCarbs,
      'imageUrl': instance.imageUrl,
    };
