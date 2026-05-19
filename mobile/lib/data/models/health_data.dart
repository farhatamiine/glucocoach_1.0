import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_data.freezed.dart';
part 'health_data.g.dart';

@freezed
class HealthData with _$HealthData {
  const factory HealthData({
    required int id,
    double? weight,
    int? heartRate,
    String? bloodPressure,
    required DateTime date,
    required int userId,
  }) = _HealthData;

  factory HealthData.fromJson(Map<String, dynamic> json) =>
      _$HealthDataFromJson(json);
}

@freezed
class HealthDataRequest with _$HealthDataRequest {
  const factory HealthDataRequest({
    double? weight,
    int? heartRate,
    String? bloodPressure,
    required DateTime date,
  }) = _HealthDataRequest;

  factory HealthDataRequest.fromJson(Map<String, dynamic> json) =>
      _$HealthDataRequestFromJson(json);
}

@freezed
class HealthDataResponse with _$HealthDataResponse {
  const factory HealthDataResponse({
    required int id,
    double? weight,
    int? heartRate,
    String? bloodPressure,
    required DateTime date,
    required int userId,
  }) = _HealthDataResponse;

  factory HealthDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthDataResponseFromJson(json);
}
