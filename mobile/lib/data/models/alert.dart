import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert.freezed.dart';
part 'alert.g.dart';

enum NotifyVia { SMS, PUSH, EMAIL }

@freezed
class Alert with _$Alert {
  const factory Alert({
    required int id,
    required double thresholdLow,
    required double thresholdHigh,
    required NotifyVia notifyVia,
    required bool active,
    required int userId,
  }) = _Alert;

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);
}

@freezed
class AlertRequest with _$AlertRequest {
  const factory AlertRequest({
    required double thresholdLow,
    required double thresholdHigh,
    required NotifyVia notifyVia,
    required bool active,
  }) = _AlertRequest;

  factory AlertRequest.fromJson(Map<String, dynamic> json) =>
      _$AlertRequestFromJson(json);
}

@freezed
class AlertResponse with _$AlertResponse {
  const factory AlertResponse({
    required int id,
    required double thresholdLow,
    required double thresholdHigh,
    required NotifyVia notifyVia,
    required bool active,
    required int userId,
  }) = _AlertResponse;

  factory AlertResponse.fromJson(Map<String, dynamic> json) =>
      _$AlertResponseFromJson(json);
}

@freezed
class AlertHistory with _$AlertHistory {
  const factory AlertHistory({
    required int id,
    required DateTime triggeredAt,
    required double glucoseValue,
    String? message,
    required int userId,
  }) = _AlertHistory;

  factory AlertHistory.fromJson(Map<String, dynamic> json) =>
      _$AlertHistoryFromJson(json);
}

@freezed
class AlertHistoryResponse with _$AlertHistoryResponse {
  const factory AlertHistoryResponse({
    required int id,
    required DateTime triggeredAt,
    required double glucoseValue,
    String? message,
    required int userId,
  }) = _AlertHistoryResponse;

  factory AlertHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AlertHistoryResponseFromJson(json);
}
