// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
    };

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  birthDate: DateTime.parse(json['birthDate'] as String),
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'password': instance.password,
  'birthDate': instance.birthDate.toIso8601String(),
};

_$RefreshRequestImpl _$$RefreshRequestImplFromJson(Map<String, dynamic> json) =>
    _$RefreshRequestImpl(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$$RefreshRequestImplToJson(
  _$RefreshRequestImpl instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};

_$ForgetPasswordRequestImpl _$$ForgetPasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ForgetPasswordRequestImpl(email: json['email'] as String);

Map<String, dynamic> _$$ForgetPasswordRequestImplToJson(
  _$ForgetPasswordRequestImpl instance,
) => <String, dynamic>{'email': instance.email};

_$ResetPasswordRequestImpl _$$ResetPasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ResetPasswordRequestImpl(
  token: json['token'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$$ResetPasswordRequestImplToJson(
  _$ResetPasswordRequestImpl instance,
) => <String, dynamic>{
  'token': instance.token,
  'newPassword': instance.newPassword,
};

_$ChangePasswordRequestImpl _$$ChangePasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ChangePasswordRequestImpl(
  oldPassword: json['oldPassword'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$$ChangePasswordRequestImplToJson(
  _$ChangePasswordRequestImpl instance,
) => <String, dynamic>{
  'oldPassword': instance.oldPassword,
  'newPassword': instance.newPassword,
};

_$FcmTokenRequestImpl _$$FcmTokenRequestImplFromJson(
  Map<String, dynamic> json,
) => _$FcmTokenRequestImpl(fcmToken: json['fcmToken'] as String);

Map<String, dynamic> _$$FcmTokenRequestImplToJson(
  _$FcmTokenRequestImpl instance,
) => <String, dynamic>{'fcmToken': instance.fcmToken};
