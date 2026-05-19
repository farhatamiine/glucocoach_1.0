import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

enum DiabetesType { TYPE_1, TYPE_2 }

enum GlucoseUnit { MG, MMOL }

@freezed
class Profile with _$Profile {
  const factory Profile({
    required int id,
    required DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    required GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
    required int userId,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

@freezed
class ProfileRequest with _$ProfileRequest {
  const factory ProfileRequest({
    required DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    required GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
  }) = _ProfileRequest;

  factory ProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileRequestFromJson(json);
}

@freezed
class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    required int id,
    required DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    required GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
    required int userId,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
