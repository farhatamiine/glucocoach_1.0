import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal.freezed.dart';
part 'meal.g.dart';

@freezed
class MealAnalysisResult with _$MealAnalysisResult {
  const factory MealAnalysisResult({
    String? name,
    double? estimatedCarbs,
    List<String>? ingredients,
    String? confidence,
  }) = _MealAnalysisResult;

  factory MealAnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$MealAnalysisResultFromJson(json);
}

@freezed
class Meal with _$Meal {
  const factory Meal({
    required int id,
    required String name,
    required double carbs,
    required DateTime timestamp,
    required int userId,
    MealAnalysisResult? analysis,
    double? estimatedCarbs,
    String? imageUrl,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}

@freezed
class MealRequest with _$MealRequest {
  const factory MealRequest({
    required String name,
    required double carbs,
    required DateTime timestamp,
  }) = _MealRequest;

  factory MealRequest.fromJson(Map<String, dynamic> json) =>
      _$MealRequestFromJson(json);
}

@freezed
class MealResponse with _$MealResponse {
  const factory MealResponse({
    required int id,
    required String name,
    required double carbs,
    required DateTime timestamp,
    required int userId,
    MealAnalysisResult? analysis,
    double? estimatedCarbs,
    String? imageUrl,
  }) = _MealResponse;

  factory MealResponse.fromJson(Map<String, dynamic> json) =>
      _$MealResponseFromJson(json);
}
