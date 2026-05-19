import 'package:freezed_annotation/freezed_annotation.dart';

part 'labo.freezed.dart';
part 'labo.g.dart';

@freezed
class LaboAnalysis with _$LaboAnalysis {
  const factory LaboAnalysis({
    required int id,
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    required DateTime date,
    required int userId,
  }) = _LaboAnalysis;

  factory LaboAnalysis.fromJson(Map<String, dynamic> json) =>
      _$LaboAnalysisFromJson(json);
}

@freezed
class LaboAnalysisRequest with _$LaboAnalysisRequest {
  const factory LaboAnalysisRequest({
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    required DateTime date,
  }) = _LaboAnalysisRequest;

  factory LaboAnalysisRequest.fromJson(Map<String, dynamic> json) =>
      _$LaboAnalysisRequestFromJson(json);
}

@freezed
class LaboAnalysisResponse with _$LaboAnalysisResponse {
  const factory LaboAnalysisResponse({
    required int id,
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    required DateTime date,
    required int userId,
  }) = _LaboAnalysisResponse;

  factory LaboAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$LaboAnalysisResponseFromJson(json);
}
