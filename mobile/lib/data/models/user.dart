import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    @JsonKey(name: 'birthDate') required DateTime birthDate,
    String? fcmToken,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserRequest with _$UserRequest {
  const factory UserRequest({
    required String firstName,
    required String lastName,
    @JsonKey(name: 'birthDate') required DateTime birthDate,
  }) = _UserRequest;

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);
}

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    @JsonKey(name: 'birthDate') required DateTime birthDate,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
