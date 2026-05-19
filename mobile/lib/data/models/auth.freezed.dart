// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return _AuthResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthResponse {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  String get tokenType => throw _privateConstructorUsedError;

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResponseCopyWith<AuthResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResponseCopyWith<$Res> {
  factory $AuthResponseCopyWith(
    AuthResponse value,
    $Res Function(AuthResponse) then,
  ) = _$AuthResponseCopyWithImpl<$Res, AuthResponse>;
  @useResult
  $Res call({String accessToken, String refreshToken, String tokenType});
}

/// @nodoc
class _$AuthResponseCopyWithImpl<$Res, $Val extends AuthResponse>
    implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? tokenType = null,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            tokenType: null == tokenType
                ? _value.tokenType
                : tokenType // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthResponseImplCopyWith<$Res>
    implements $AuthResponseCopyWith<$Res> {
  factory _$$AuthResponseImplCopyWith(
    _$AuthResponseImpl value,
    $Res Function(_$AuthResponseImpl) then,
  ) = __$$AuthResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken, String tokenType});
}

/// @nodoc
class __$$AuthResponseImplCopyWithImpl<$Res>
    extends _$AuthResponseCopyWithImpl<$Res, _$AuthResponseImpl>
    implements _$$AuthResponseImplCopyWith<$Res> {
  __$$AuthResponseImplCopyWithImpl(
    _$AuthResponseImpl _value,
    $Res Function(_$AuthResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? tokenType = null,
  }) {
    return _then(
      _$AuthResponseImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenType: null == tokenType
            ? _value.tokenType
            : tokenType // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthResponseImpl implements _AuthResponse {
  const _$AuthResponseImpl({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory _$AuthResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthResponseImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final String tokenType;

  @override
  String toString() {
    return 'AuthResponse(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResponseImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, tokenType);

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      __$$AuthResponseImplCopyWithImpl<_$AuthResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthResponseImplToJson(this);
  }
}

abstract class _AuthResponse implements AuthResponse {
  const factory _AuthResponse({
    required final String accessToken,
    required final String refreshToken,
    required final String tokenType,
  }) = _$AuthResponseImpl;

  factory _AuthResponse.fromJson(Map<String, dynamic> json) =
      _$AuthResponseImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  String get tokenType;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return _LoginRequest.fromJson(json);
}

/// @nodoc
mixin _$LoginRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
    LoginRequest value,
    $Res Function(LoginRequest) then,
  ) = _$LoginRequestCopyWithImpl<$Res, LoginRequest>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res, $Val extends LoginRequest>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? password = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$LoginRequestImplCopyWith(
    _$LoginRequestImpl value,
    $Res Function(_$LoginRequestImpl) then,
  ) = __$$LoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$LoginRequestImpl>
    implements _$$LoginRequestImplCopyWith<$Res> {
  __$$LoginRequestImplCopyWithImpl(
    _$LoginRequestImpl _value,
    $Res Function(_$LoginRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? password = null}) {
    return _then(
      _$LoginRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestImpl implements _LoginRequest {
  const _$LoginRequestImpl({required this.email, required this.password});

  factory _$LoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      __$$LoginRequestImplCopyWithImpl<_$LoginRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestImplToJson(this);
  }
}

abstract class _LoginRequest implements LoginRequest {
  const factory _LoginRequest({
    required final String email,
    required final String password,
  }) = _$LoginRequestImpl;

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$LoginRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return _RegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$RegisterRequest {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'birthDate')
  DateTime get birthDate => throw _privateConstructorUsedError;

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterRequestCopyWith<RegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterRequestCopyWith<$Res> {
  factory $RegisterRequestCopyWith(
    RegisterRequest value,
    $Res Function(RegisterRequest) then,
  ) = _$RegisterRequestCopyWithImpl<$Res, RegisterRequest>;
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String password,
    @JsonKey(name: 'birthDate') DateTime birthDate,
  });
}

/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res, $Val extends RegisterRequest>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? birthDate = null,
  }) {
    return _then(
      _value.copyWith(
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            birthDate: null == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisterRequestImplCopyWith<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  factory _$$RegisterRequestImplCopyWith(
    _$RegisterRequestImpl value,
    $Res Function(_$RegisterRequestImpl) then,
  ) = __$$RegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String password,
    @JsonKey(name: 'birthDate') DateTime birthDate,
  });
}

/// @nodoc
class __$$RegisterRequestImplCopyWithImpl<$Res>
    extends _$RegisterRequestCopyWithImpl<$Res, _$RegisterRequestImpl>
    implements _$$RegisterRequestImplCopyWith<$Res> {
  __$$RegisterRequestImplCopyWithImpl(
    _$RegisterRequestImpl _value,
    $Res Function(_$RegisterRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? birthDate = null,
  }) {
    return _then(
      _$RegisterRequestImpl(
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        birthDate: null == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterRequestImpl implements _RegisterRequest {
  const _$RegisterRequestImpl({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    @JsonKey(name: 'birthDate') required this.birthDate,
  });

  factory _$RegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterRequestImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey(name: 'birthDate')
  final DateTime birthDate;

  @override
  String toString() {
    return 'RegisterRequest(firstName: $firstName, lastName: $lastName, email: $email, password: $password, birthDate: $birthDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, firstName, lastName, email, password, birthDate);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      __$$RegisterRequestImplCopyWithImpl<_$RegisterRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterRequestImplToJson(this);
  }
}

abstract class _RegisterRequest implements RegisterRequest {
  const factory _RegisterRequest({
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String password,
    @JsonKey(name: 'birthDate') required final DateTime birthDate,
  }) = _$RegisterRequestImpl;

  factory _RegisterRequest.fromJson(Map<String, dynamic> json) =
      _$RegisterRequestImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(name: 'birthDate')
  DateTime get birthDate;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RefreshRequest _$RefreshRequestFromJson(Map<String, dynamic> json) {
  return _RefreshRequest.fromJson(json);
}

/// @nodoc
mixin _$RefreshRequest {
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this RefreshRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RefreshRequestCopyWith<RefreshRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshRequestCopyWith<$Res> {
  factory $RefreshRequestCopyWith(
    RefreshRequest value,
    $Res Function(RefreshRequest) then,
  ) = _$RefreshRequestCopyWithImpl<$Res, RefreshRequest>;
  @useResult
  $Res call({String refreshToken});
}

/// @nodoc
class _$RefreshRequestCopyWithImpl<$Res, $Val extends RefreshRequest>
    implements $RefreshRequestCopyWith<$Res> {
  _$RefreshRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? refreshToken = null}) {
    return _then(
      _value.copyWith(
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RefreshRequestImplCopyWith<$Res>
    implements $RefreshRequestCopyWith<$Res> {
  factory _$$RefreshRequestImplCopyWith(
    _$RefreshRequestImpl value,
    $Res Function(_$RefreshRequestImpl) then,
  ) = __$$RefreshRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String refreshToken});
}

/// @nodoc
class __$$RefreshRequestImplCopyWithImpl<$Res>
    extends _$RefreshRequestCopyWithImpl<$Res, _$RefreshRequestImpl>
    implements _$$RefreshRequestImplCopyWith<$Res> {
  __$$RefreshRequestImplCopyWithImpl(
    _$RefreshRequestImpl _value,
    $Res Function(_$RefreshRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? refreshToken = null}) {
    return _then(
      _$RefreshRequestImpl(
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RefreshRequestImpl implements _RefreshRequest {
  const _$RefreshRequestImpl({required this.refreshToken});

  factory _$RefreshRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefreshRequestImplFromJson(json);

  @override
  final String refreshToken;

  @override
  String toString() {
    return 'RefreshRequest(refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshRequestImpl &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refreshToken);

  /// Create a copy of RefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshRequestImplCopyWith<_$RefreshRequestImpl> get copyWith =>
      __$$RefreshRequestImplCopyWithImpl<_$RefreshRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RefreshRequestImplToJson(this);
  }
}

abstract class _RefreshRequest implements RefreshRequest {
  const factory _RefreshRequest({required final String refreshToken}) =
      _$RefreshRequestImpl;

  factory _RefreshRequest.fromJson(Map<String, dynamic> json) =
      _$RefreshRequestImpl.fromJson;

  @override
  String get refreshToken;

  /// Create a copy of RefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshRequestImplCopyWith<_$RefreshRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForgetPasswordRequest _$ForgetPasswordRequestFromJson(
  Map<String, dynamic> json,
) {
  return _ForgetPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ForgetPasswordRequest {
  String get email => throw _privateConstructorUsedError;

  /// Serializes this ForgetPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForgetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForgetPasswordRequestCopyWith<ForgetPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgetPasswordRequestCopyWith<$Res> {
  factory $ForgetPasswordRequestCopyWith(
    ForgetPasswordRequest value,
    $Res Function(ForgetPasswordRequest) then,
  ) = _$ForgetPasswordRequestCopyWithImpl<$Res, ForgetPasswordRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ForgetPasswordRequestCopyWithImpl<
  $Res,
  $Val extends ForgetPasswordRequest
>
    implements $ForgetPasswordRequestCopyWith<$Res> {
  _$ForgetPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForgetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForgetPasswordRequestImplCopyWith<$Res>
    implements $ForgetPasswordRequestCopyWith<$Res> {
  factory _$$ForgetPasswordRequestImplCopyWith(
    _$ForgetPasswordRequestImpl value,
    $Res Function(_$ForgetPasswordRequestImpl) then,
  ) = __$$ForgetPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ForgetPasswordRequestImplCopyWithImpl<$Res>
    extends
        _$ForgetPasswordRequestCopyWithImpl<$Res, _$ForgetPasswordRequestImpl>
    implements _$$ForgetPasswordRequestImplCopyWith<$Res> {
  __$$ForgetPasswordRequestImplCopyWithImpl(
    _$ForgetPasswordRequestImpl _value,
    $Res Function(_$ForgetPasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForgetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$ForgetPasswordRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgetPasswordRequestImpl implements _ForgetPasswordRequest {
  const _$ForgetPasswordRequestImpl({required this.email});

  factory _$ForgetPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgetPasswordRequestImplFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgetPasswordRequest(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgetPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of ForgetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgetPasswordRequestImplCopyWith<_$ForgetPasswordRequestImpl>
  get copyWith =>
      __$$ForgetPasswordRequestImplCopyWithImpl<_$ForgetPasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgetPasswordRequestImplToJson(this);
  }
}

abstract class _ForgetPasswordRequest implements ForgetPasswordRequest {
  const factory _ForgetPasswordRequest({required final String email}) =
      _$ForgetPasswordRequestImpl;

  factory _ForgetPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ForgetPasswordRequestImpl.fromJson;

  @override
  String get email;

  /// Create a copy of ForgetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgetPasswordRequestImplCopyWith<_$ForgetPasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ResetPasswordRequest _$ResetPasswordRequestFromJson(Map<String, dynamic> json) {
  return _ResetPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordRequest {
  String get token => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;

  /// Serializes this ResetPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPasswordRequestCopyWith<ResetPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordRequestCopyWith<$Res> {
  factory $ResetPasswordRequestCopyWith(
    ResetPasswordRequest value,
    $Res Function(ResetPasswordRequest) then,
  ) = _$ResetPasswordRequestCopyWithImpl<$Res, ResetPasswordRequest>;
  @useResult
  $Res call({String token, String newPassword});
}

/// @nodoc
class _$ResetPasswordRequestCopyWithImpl<
  $Res,
  $Val extends ResetPasswordRequest
>
    implements $ResetPasswordRequestCopyWith<$Res> {
  _$ResetPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? newPassword = null}) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            newPassword: null == newPassword
                ? _value.newPassword
                : newPassword // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResetPasswordRequestImplCopyWith<$Res>
    implements $ResetPasswordRequestCopyWith<$Res> {
  factory _$$ResetPasswordRequestImplCopyWith(
    _$ResetPasswordRequestImpl value,
    $Res Function(_$ResetPasswordRequestImpl) then,
  ) = __$$ResetPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, String newPassword});
}

/// @nodoc
class __$$ResetPasswordRequestImplCopyWithImpl<$Res>
    extends _$ResetPasswordRequestCopyWithImpl<$Res, _$ResetPasswordRequestImpl>
    implements _$$ResetPasswordRequestImplCopyWith<$Res> {
  __$$ResetPasswordRequestImplCopyWithImpl(
    _$ResetPasswordRequestImpl _value,
    $Res Function(_$ResetPasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? newPassword = null}) {
    return _then(
      _$ResetPasswordRequestImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        newPassword: null == newPassword
            ? _value.newPassword
            : newPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordRequestImpl implements _ResetPasswordRequest {
  const _$ResetPasswordRequestImpl({
    required this.token,
    required this.newPassword,
  });

  factory _$ResetPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordRequestImplFromJson(json);

  @override
  final String token;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ResetPasswordRequest(token: $token, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordRequestImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, newPassword);

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordRequestImplCopyWith<_$ResetPasswordRequestImpl>
  get copyWith =>
      __$$ResetPasswordRequestImplCopyWithImpl<_$ResetPasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordRequestImplToJson(this);
  }
}

abstract class _ResetPasswordRequest implements ResetPasswordRequest {
  const factory _ResetPasswordRequest({
    required final String token,
    required final String newPassword,
  }) = _$ResetPasswordRequestImpl;

  factory _ResetPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordRequestImpl.fromJson;

  @override
  String get token;
  @override
  String get newPassword;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordRequestImplCopyWith<_$ResetPasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) {
  return _ChangePasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordRequest {
  String get oldPassword => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;

  /// Serializes this ChangePasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePasswordRequestCopyWith<ChangePasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordRequestCopyWith<$Res> {
  factory $ChangePasswordRequestCopyWith(
    ChangePasswordRequest value,
    $Res Function(ChangePasswordRequest) then,
  ) = _$ChangePasswordRequestCopyWithImpl<$Res, ChangePasswordRequest>;
  @useResult
  $Res call({String oldPassword, String newPassword});
}

/// @nodoc
class _$ChangePasswordRequestCopyWithImpl<
  $Res,
  $Val extends ChangePasswordRequest
>
    implements $ChangePasswordRequestCopyWith<$Res> {
  _$ChangePasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? oldPassword = null, Object? newPassword = null}) {
    return _then(
      _value.copyWith(
            oldPassword: null == oldPassword
                ? _value.oldPassword
                : oldPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            newPassword: null == newPassword
                ? _value.newPassword
                : newPassword // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChangePasswordRequestImplCopyWith<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  factory _$$ChangePasswordRequestImplCopyWith(
    _$ChangePasswordRequestImpl value,
    $Res Function(_$ChangePasswordRequestImpl) then,
  ) = __$$ChangePasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String oldPassword, String newPassword});
}

/// @nodoc
class __$$ChangePasswordRequestImplCopyWithImpl<$Res>
    extends
        _$ChangePasswordRequestCopyWithImpl<$Res, _$ChangePasswordRequestImpl>
    implements _$$ChangePasswordRequestImplCopyWith<$Res> {
  __$$ChangePasswordRequestImplCopyWithImpl(
    _$ChangePasswordRequestImpl _value,
    $Res Function(_$ChangePasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? oldPassword = null, Object? newPassword = null}) {
    return _then(
      _$ChangePasswordRequestImpl(
        oldPassword: null == oldPassword
            ? _value.oldPassword
            : oldPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        newPassword: null == newPassword
            ? _value.newPassword
            : newPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangePasswordRequestImpl implements _ChangePasswordRequest {
  const _$ChangePasswordRequestImpl({
    required this.oldPassword,
    required this.newPassword,
  });

  factory _$ChangePasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangePasswordRequestImplFromJson(json);

  @override
  final String oldPassword;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ChangePasswordRequest(oldPassword: $oldPassword, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordRequestImpl &&
            (identical(other.oldPassword, oldPassword) ||
                other.oldPassword == oldPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, oldPassword, newPassword);

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordRequestImplCopyWith<_$ChangePasswordRequestImpl>
  get copyWith =>
      __$$ChangePasswordRequestImplCopyWithImpl<_$ChangePasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePasswordRequestImplToJson(this);
  }
}

abstract class _ChangePasswordRequest implements ChangePasswordRequest {
  const factory _ChangePasswordRequest({
    required final String oldPassword,
    required final String newPassword,
  }) = _$ChangePasswordRequestImpl;

  factory _ChangePasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ChangePasswordRequestImpl.fromJson;

  @override
  String get oldPassword;
  @override
  String get newPassword;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordRequestImplCopyWith<_$ChangePasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FcmTokenRequest _$FcmTokenRequestFromJson(Map<String, dynamic> json) {
  return _FcmTokenRequest.fromJson(json);
}

/// @nodoc
mixin _$FcmTokenRequest {
  String get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this FcmTokenRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FcmTokenRequestCopyWith<FcmTokenRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FcmTokenRequestCopyWith<$Res> {
  factory $FcmTokenRequestCopyWith(
    FcmTokenRequest value,
    $Res Function(FcmTokenRequest) then,
  ) = _$FcmTokenRequestCopyWithImpl<$Res, FcmTokenRequest>;
  @useResult
  $Res call({String fcmToken});
}

/// @nodoc
class _$FcmTokenRequestCopyWithImpl<$Res, $Val extends FcmTokenRequest>
    implements $FcmTokenRequestCopyWith<$Res> {
  _$FcmTokenRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fcmToken = null}) {
    return _then(
      _value.copyWith(
            fcmToken: null == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FcmTokenRequestImplCopyWith<$Res>
    implements $FcmTokenRequestCopyWith<$Res> {
  factory _$$FcmTokenRequestImplCopyWith(
    _$FcmTokenRequestImpl value,
    $Res Function(_$FcmTokenRequestImpl) then,
  ) = __$$FcmTokenRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fcmToken});
}

/// @nodoc
class __$$FcmTokenRequestImplCopyWithImpl<$Res>
    extends _$FcmTokenRequestCopyWithImpl<$Res, _$FcmTokenRequestImpl>
    implements _$$FcmTokenRequestImplCopyWith<$Res> {
  __$$FcmTokenRequestImplCopyWithImpl(
    _$FcmTokenRequestImpl _value,
    $Res Function(_$FcmTokenRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fcmToken = null}) {
    return _then(
      _$FcmTokenRequestImpl(
        fcmToken: null == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FcmTokenRequestImpl implements _FcmTokenRequest {
  const _$FcmTokenRequestImpl({required this.fcmToken});

  factory _$FcmTokenRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FcmTokenRequestImplFromJson(json);

  @override
  final String fcmToken;

  @override
  String toString() {
    return 'FcmTokenRequest(fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FcmTokenRequestImpl &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fcmToken);

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FcmTokenRequestImplCopyWith<_$FcmTokenRequestImpl> get copyWith =>
      __$$FcmTokenRequestImplCopyWithImpl<_$FcmTokenRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FcmTokenRequestImplToJson(this);
  }
}

abstract class _FcmTokenRequest implements FcmTokenRequest {
  const factory _FcmTokenRequest({required final String fcmToken}) =
      _$FcmTokenRequestImpl;

  factory _FcmTokenRequest.fromJson(Map<String, dynamic> json) =
      _$FcmTokenRequestImpl.fromJson;

  @override
  String get fcmToken;

  /// Create a copy of FcmTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FcmTokenRequestImplCopyWith<_$FcmTokenRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
