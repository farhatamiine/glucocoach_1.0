import 'package:freezed_annotation/freezed_annotation.dart';

part 'bolus.freezed.dart';
part 'bolus.g.dart';

enum BolusType { MEAL, CORRECTION }

@freezed
class Bolus with _$Bolus {
  const factory Bolus({
    required int id,
    required double amount,
    required BolusType bolusType,
    required DateTime timestamp,
    int? mealId,
    required int userId,
  }) = _Bolus;

  factory Bolus.fromJson(Map<String, dynamic> json) => _$BolusFromJson(json);
}

@freezed
class BolusRequest with _$BolusRequest {
  const factory BolusRequest({
    required double amount,
    required BolusType bolusType,
    required DateTime timestamp,
    int? mealId,
  }) = _BolusRequest;

  factory BolusRequest.fromJson(Map<String, dynamic> json) =>
      _$BolusRequestFromJson(json);
}

@freezed
class BolusResponse with _$BolusResponse {
  const factory BolusResponse({
    required int id,
    required double amount,
    required BolusType bolusType,
    required DateTime timestamp,
    int? mealId,
    required int userId,
  }) = _BolusResponse;

  factory BolusResponse.fromJson(Map<String, dynamic> json) =>
      _$BolusResponseFromJson(json);
}
