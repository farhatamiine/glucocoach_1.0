// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  int get id => throw _privateConstructorUsedError;
  DiabetesType get diabetesType => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  DateTime? get diabetesSince => throw _privateConstructorUsedError;
  String? get basalInsulinName => throw _privateConstructorUsedError;
  String? get bolusInsulinName => throw _privateConstructorUsedError;
  GlucoseUnit get glucoseUnit => throw _privateConstructorUsedError;
  int? get prescribedBasalDose => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call({
    int id,
    DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
    int userId,
  });
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diabetesType = null,
    Object? height = freezed,
    Object? diabetesSince = freezed,
    Object? basalInsulinName = freezed,
    Object? bolusInsulinName = freezed,
    Object? glucoseUnit = null,
    Object? prescribedBasalDose = freezed,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            diabetesType: null == diabetesType
                ? _value.diabetesType
                : diabetesType // ignore: cast_nullable_to_non_nullable
                      as DiabetesType,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
            diabetesSince: freezed == diabetesSince
                ? _value.diabetesSince
                : diabetesSince // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            basalInsulinName: freezed == basalInsulinName
                ? _value.basalInsulinName
                : basalInsulinName // ignore: cast_nullable_to_non_nullable
                      as String?,
            bolusInsulinName: freezed == bolusInsulinName
                ? _value.bolusInsulinName
                : bolusInsulinName // ignore: cast_nullable_to_non_nullable
                      as String?,
            glucoseUnit: null == glucoseUnit
                ? _value.glucoseUnit
                : glucoseUnit // ignore: cast_nullable_to_non_nullable
                      as GlucoseUnit,
            prescribedBasalDose: freezed == prescribedBasalDose
                ? _value.prescribedBasalDose
                : prescribedBasalDose // ignore: cast_nullable_to_non_nullable
                      as int?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
    _$ProfileImpl value,
    $Res Function(_$ProfileImpl) then,
  ) = __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
    int userId,
  });
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
    _$ProfileImpl _value,
    $Res Function(_$ProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diabetesType = null,
    Object? height = freezed,
    Object? diabetesSince = freezed,
    Object? basalInsulinName = freezed,
    Object? bolusInsulinName = freezed,
    Object? glucoseUnit = null,
    Object? prescribedBasalDose = freezed,
    Object? userId = null,
  }) {
    return _then(
      _$ProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        diabetesType: null == diabetesType
            ? _value.diabetesType
            : diabetesType // ignore: cast_nullable_to_non_nullable
                  as DiabetesType,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        diabetesSince: freezed == diabetesSince
            ? _value.diabetesSince
            : diabetesSince // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        basalInsulinName: freezed == basalInsulinName
            ? _value.basalInsulinName
            : basalInsulinName // ignore: cast_nullable_to_non_nullable
                  as String?,
        bolusInsulinName: freezed == bolusInsulinName
            ? _value.bolusInsulinName
            : bolusInsulinName // ignore: cast_nullable_to_non_nullable
                  as String?,
        glucoseUnit: null == glucoseUnit
            ? _value.glucoseUnit
            : glucoseUnit // ignore: cast_nullable_to_non_nullable
                  as GlucoseUnit,
        prescribedBasalDose: freezed == prescribedBasalDose
            ? _value.prescribedBasalDose
            : prescribedBasalDose // ignore: cast_nullable_to_non_nullable
                  as int?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl({
    required this.id,
    required this.diabetesType,
    this.height,
    this.diabetesSince,
    this.basalInsulinName,
    this.bolusInsulinName,
    required this.glucoseUnit,
    this.prescribedBasalDose,
    required this.userId,
  });

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final int id;
  @override
  final DiabetesType diabetesType;
  @override
  final int? height;
  @override
  final DateTime? diabetesSince;
  @override
  final String? basalInsulinName;
  @override
  final String? bolusInsulinName;
  @override
  final GlucoseUnit glucoseUnit;
  @override
  final int? prescribedBasalDose;
  @override
  final int userId;

  @override
  String toString() {
    return 'Profile(id: $id, diabetesType: $diabetesType, height: $height, diabetesSince: $diabetesSince, basalInsulinName: $basalInsulinName, bolusInsulinName: $bolusInsulinName, glucoseUnit: $glucoseUnit, prescribedBasalDose: $prescribedBasalDose, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.diabetesType, diabetesType) ||
                other.diabetesType == diabetesType) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.diabetesSince, diabetesSince) ||
                other.diabetesSince == diabetesSince) &&
            (identical(other.basalInsulinName, basalInsulinName) ||
                other.basalInsulinName == basalInsulinName) &&
            (identical(other.bolusInsulinName, bolusInsulinName) ||
                other.bolusInsulinName == bolusInsulinName) &&
            (identical(other.glucoseUnit, glucoseUnit) ||
                other.glucoseUnit == glucoseUnit) &&
            (identical(other.prescribedBasalDose, prescribedBasalDose) ||
                other.prescribedBasalDose == prescribedBasalDose) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    diabetesType,
    height,
    diabetesSince,
    basalInsulinName,
    bolusInsulinName,
    glucoseUnit,
    prescribedBasalDose,
    userId,
  );

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(this);
  }
}

abstract class _Profile implements Profile {
  const factory _Profile({
    required final int id,
    required final DiabetesType diabetesType,
    final int? height,
    final DateTime? diabetesSince,
    final String? basalInsulinName,
    final String? bolusInsulinName,
    required final GlucoseUnit glucoseUnit,
    final int? prescribedBasalDose,
    required final int userId,
  }) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  int get id;
  @override
  DiabetesType get diabetesType;
  @override
  int? get height;
  @override
  DateTime? get diabetesSince;
  @override
  String? get basalInsulinName;
  @override
  String? get bolusInsulinName;
  @override
  GlucoseUnit get glucoseUnit;
  @override
  int? get prescribedBasalDose;
  @override
  int get userId;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileRequest _$ProfileRequestFromJson(Map<String, dynamic> json) {
  return _ProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$ProfileRequest {
  DiabetesType get diabetesType => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  DateTime? get diabetesSince => throw _privateConstructorUsedError;
  String? get basalInsulinName => throw _privateConstructorUsedError;
  String? get bolusInsulinName => throw _privateConstructorUsedError;
  GlucoseUnit get glucoseUnit => throw _privateConstructorUsedError;
  int? get prescribedBasalDose => throw _privateConstructorUsedError;

  /// Serializes this ProfileRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileRequestCopyWith<ProfileRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileRequestCopyWith<$Res> {
  factory $ProfileRequestCopyWith(
    ProfileRequest value,
    $Res Function(ProfileRequest) then,
  ) = _$ProfileRequestCopyWithImpl<$Res, ProfileRequest>;
  @useResult
  $Res call({
    DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
  });
}

/// @nodoc
class _$ProfileRequestCopyWithImpl<$Res, $Val extends ProfileRequest>
    implements $ProfileRequestCopyWith<$Res> {
  _$ProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? diabetesType = null,
    Object? height = freezed,
    Object? diabetesSince = freezed,
    Object? basalInsulinName = freezed,
    Object? bolusInsulinName = freezed,
    Object? glucoseUnit = null,
    Object? prescribedBasalDose = freezed,
  }) {
    return _then(
      _value.copyWith(
            diabetesType: null == diabetesType
                ? _value.diabetesType
                : diabetesType // ignore: cast_nullable_to_non_nullable
                      as DiabetesType,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
            diabetesSince: freezed == diabetesSince
                ? _value.diabetesSince
                : diabetesSince // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            basalInsulinName: freezed == basalInsulinName
                ? _value.basalInsulinName
                : basalInsulinName // ignore: cast_nullable_to_non_nullable
                      as String?,
            bolusInsulinName: freezed == bolusInsulinName
                ? _value.bolusInsulinName
                : bolusInsulinName // ignore: cast_nullable_to_non_nullable
                      as String?,
            glucoseUnit: null == glucoseUnit
                ? _value.glucoseUnit
                : glucoseUnit // ignore: cast_nullable_to_non_nullable
                      as GlucoseUnit,
            prescribedBasalDose: freezed == prescribedBasalDose
                ? _value.prescribedBasalDose
                : prescribedBasalDose // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileRequestImplCopyWith<$Res>
    implements $ProfileRequestCopyWith<$Res> {
  factory _$$ProfileRequestImplCopyWith(
    _$ProfileRequestImpl value,
    $Res Function(_$ProfileRequestImpl) then,
  ) = __$$ProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
  });
}

/// @nodoc
class __$$ProfileRequestImplCopyWithImpl<$Res>
    extends _$ProfileRequestCopyWithImpl<$Res, _$ProfileRequestImpl>
    implements _$$ProfileRequestImplCopyWith<$Res> {
  __$$ProfileRequestImplCopyWithImpl(
    _$ProfileRequestImpl _value,
    $Res Function(_$ProfileRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? diabetesType = null,
    Object? height = freezed,
    Object? diabetesSince = freezed,
    Object? basalInsulinName = freezed,
    Object? bolusInsulinName = freezed,
    Object? glucoseUnit = null,
    Object? prescribedBasalDose = freezed,
  }) {
    return _then(
      _$ProfileRequestImpl(
        diabetesType: null == diabetesType
            ? _value.diabetesType
            : diabetesType // ignore: cast_nullable_to_non_nullable
                  as DiabetesType,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        diabetesSince: freezed == diabetesSince
            ? _value.diabetesSince
            : diabetesSince // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        basalInsulinName: freezed == basalInsulinName
            ? _value.basalInsulinName
            : basalInsulinName // ignore: cast_nullable_to_non_nullable
                  as String?,
        bolusInsulinName: freezed == bolusInsulinName
            ? _value.bolusInsulinName
            : bolusInsulinName // ignore: cast_nullable_to_non_nullable
                  as String?,
        glucoseUnit: null == glucoseUnit
            ? _value.glucoseUnit
            : glucoseUnit // ignore: cast_nullable_to_non_nullable
                  as GlucoseUnit,
        prescribedBasalDose: freezed == prescribedBasalDose
            ? _value.prescribedBasalDose
            : prescribedBasalDose // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileRequestImpl implements _ProfileRequest {
  const _$ProfileRequestImpl({
    required this.diabetesType,
    this.height,
    this.diabetesSince,
    this.basalInsulinName,
    this.bolusInsulinName,
    required this.glucoseUnit,
    this.prescribedBasalDose,
  });

  factory _$ProfileRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileRequestImplFromJson(json);

  @override
  final DiabetesType diabetesType;
  @override
  final int? height;
  @override
  final DateTime? diabetesSince;
  @override
  final String? basalInsulinName;
  @override
  final String? bolusInsulinName;
  @override
  final GlucoseUnit glucoseUnit;
  @override
  final int? prescribedBasalDose;

  @override
  String toString() {
    return 'ProfileRequest(diabetesType: $diabetesType, height: $height, diabetesSince: $diabetesSince, basalInsulinName: $basalInsulinName, bolusInsulinName: $bolusInsulinName, glucoseUnit: $glucoseUnit, prescribedBasalDose: $prescribedBasalDose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileRequestImpl &&
            (identical(other.diabetesType, diabetesType) ||
                other.diabetesType == diabetesType) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.diabetesSince, diabetesSince) ||
                other.diabetesSince == diabetesSince) &&
            (identical(other.basalInsulinName, basalInsulinName) ||
                other.basalInsulinName == basalInsulinName) &&
            (identical(other.bolusInsulinName, bolusInsulinName) ||
                other.bolusInsulinName == bolusInsulinName) &&
            (identical(other.glucoseUnit, glucoseUnit) ||
                other.glucoseUnit == glucoseUnit) &&
            (identical(other.prescribedBasalDose, prescribedBasalDose) ||
                other.prescribedBasalDose == prescribedBasalDose));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    diabetesType,
    height,
    diabetesSince,
    basalInsulinName,
    bolusInsulinName,
    glucoseUnit,
    prescribedBasalDose,
  );

  /// Create a copy of ProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileRequestImplCopyWith<_$ProfileRequestImpl> get copyWith =>
      __$$ProfileRequestImplCopyWithImpl<_$ProfileRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileRequestImplToJson(this);
  }
}

abstract class _ProfileRequest implements ProfileRequest {
  const factory _ProfileRequest({
    required final DiabetesType diabetesType,
    final int? height,
    final DateTime? diabetesSince,
    final String? basalInsulinName,
    final String? bolusInsulinName,
    required final GlucoseUnit glucoseUnit,
    final int? prescribedBasalDose,
  }) = _$ProfileRequestImpl;

  factory _ProfileRequest.fromJson(Map<String, dynamic> json) =
      _$ProfileRequestImpl.fromJson;

  @override
  DiabetesType get diabetesType;
  @override
  int? get height;
  @override
  DateTime? get diabetesSince;
  @override
  String? get basalInsulinName;
  @override
  String? get bolusInsulinName;
  @override
  GlucoseUnit get glucoseUnit;
  @override
  int? get prescribedBasalDose;

  /// Create a copy of ProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileRequestImplCopyWith<_$ProfileRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) {
  return _ProfileResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileResponse {
  int get id => throw _privateConstructorUsedError;
  DiabetesType get diabetesType => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  DateTime? get diabetesSince => throw _privateConstructorUsedError;
  String? get basalInsulinName => throw _privateConstructorUsedError;
  String? get bolusInsulinName => throw _privateConstructorUsedError;
  GlucoseUnit get glucoseUnit => throw _privateConstructorUsedError;
  int? get prescribedBasalDose => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this ProfileResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileResponseCopyWith<ProfileResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileResponseCopyWith<$Res> {
  factory $ProfileResponseCopyWith(
    ProfileResponse value,
    $Res Function(ProfileResponse) then,
  ) = _$ProfileResponseCopyWithImpl<$Res, ProfileResponse>;
  @useResult
  $Res call({
    int id,
    DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
    int userId,
  });
}

/// @nodoc
class _$ProfileResponseCopyWithImpl<$Res, $Val extends ProfileResponse>
    implements $ProfileResponseCopyWith<$Res> {
  _$ProfileResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diabetesType = null,
    Object? height = freezed,
    Object? diabetesSince = freezed,
    Object? basalInsulinName = freezed,
    Object? bolusInsulinName = freezed,
    Object? glucoseUnit = null,
    Object? prescribedBasalDose = freezed,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            diabetesType: null == diabetesType
                ? _value.diabetesType
                : diabetesType // ignore: cast_nullable_to_non_nullable
                      as DiabetesType,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
            diabetesSince: freezed == diabetesSince
                ? _value.diabetesSince
                : diabetesSince // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            basalInsulinName: freezed == basalInsulinName
                ? _value.basalInsulinName
                : basalInsulinName // ignore: cast_nullable_to_non_nullable
                      as String?,
            bolusInsulinName: freezed == bolusInsulinName
                ? _value.bolusInsulinName
                : bolusInsulinName // ignore: cast_nullable_to_non_nullable
                      as String?,
            glucoseUnit: null == glucoseUnit
                ? _value.glucoseUnit
                : glucoseUnit // ignore: cast_nullable_to_non_nullable
                      as GlucoseUnit,
            prescribedBasalDose: freezed == prescribedBasalDose
                ? _value.prescribedBasalDose
                : prescribedBasalDose // ignore: cast_nullable_to_non_nullable
                      as int?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileResponseImplCopyWith<$Res>
    implements $ProfileResponseCopyWith<$Res> {
  factory _$$ProfileResponseImplCopyWith(
    _$ProfileResponseImpl value,
    $Res Function(_$ProfileResponseImpl) then,
  ) = __$$ProfileResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    DiabetesType diabetesType,
    int? height,
    DateTime? diabetesSince,
    String? basalInsulinName,
    String? bolusInsulinName,
    GlucoseUnit glucoseUnit,
    int? prescribedBasalDose,
    int userId,
  });
}

/// @nodoc
class __$$ProfileResponseImplCopyWithImpl<$Res>
    extends _$ProfileResponseCopyWithImpl<$Res, _$ProfileResponseImpl>
    implements _$$ProfileResponseImplCopyWith<$Res> {
  __$$ProfileResponseImplCopyWithImpl(
    _$ProfileResponseImpl _value,
    $Res Function(_$ProfileResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diabetesType = null,
    Object? height = freezed,
    Object? diabetesSince = freezed,
    Object? basalInsulinName = freezed,
    Object? bolusInsulinName = freezed,
    Object? glucoseUnit = null,
    Object? prescribedBasalDose = freezed,
    Object? userId = null,
  }) {
    return _then(
      _$ProfileResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        diabetesType: null == diabetesType
            ? _value.diabetesType
            : diabetesType // ignore: cast_nullable_to_non_nullable
                  as DiabetesType,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        diabetesSince: freezed == diabetesSince
            ? _value.diabetesSince
            : diabetesSince // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        basalInsulinName: freezed == basalInsulinName
            ? _value.basalInsulinName
            : basalInsulinName // ignore: cast_nullable_to_non_nullable
                  as String?,
        bolusInsulinName: freezed == bolusInsulinName
            ? _value.bolusInsulinName
            : bolusInsulinName // ignore: cast_nullable_to_non_nullable
                  as String?,
        glucoseUnit: null == glucoseUnit
            ? _value.glucoseUnit
            : glucoseUnit // ignore: cast_nullable_to_non_nullable
                  as GlucoseUnit,
        prescribedBasalDose: freezed == prescribedBasalDose
            ? _value.prescribedBasalDose
            : prescribedBasalDose // ignore: cast_nullable_to_non_nullable
                  as int?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileResponseImpl implements _ProfileResponse {
  const _$ProfileResponseImpl({
    required this.id,
    required this.diabetesType,
    this.height,
    this.diabetesSince,
    this.basalInsulinName,
    this.bolusInsulinName,
    required this.glucoseUnit,
    this.prescribedBasalDose,
    required this.userId,
  });

  factory _$ProfileResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileResponseImplFromJson(json);

  @override
  final int id;
  @override
  final DiabetesType diabetesType;
  @override
  final int? height;
  @override
  final DateTime? diabetesSince;
  @override
  final String? basalInsulinName;
  @override
  final String? bolusInsulinName;
  @override
  final GlucoseUnit glucoseUnit;
  @override
  final int? prescribedBasalDose;
  @override
  final int userId;

  @override
  String toString() {
    return 'ProfileResponse(id: $id, diabetesType: $diabetesType, height: $height, diabetesSince: $diabetesSince, basalInsulinName: $basalInsulinName, bolusInsulinName: $bolusInsulinName, glucoseUnit: $glucoseUnit, prescribedBasalDose: $prescribedBasalDose, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.diabetesType, diabetesType) ||
                other.diabetesType == diabetesType) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.diabetesSince, diabetesSince) ||
                other.diabetesSince == diabetesSince) &&
            (identical(other.basalInsulinName, basalInsulinName) ||
                other.basalInsulinName == basalInsulinName) &&
            (identical(other.bolusInsulinName, bolusInsulinName) ||
                other.bolusInsulinName == bolusInsulinName) &&
            (identical(other.glucoseUnit, glucoseUnit) ||
                other.glucoseUnit == glucoseUnit) &&
            (identical(other.prescribedBasalDose, prescribedBasalDose) ||
                other.prescribedBasalDose == prescribedBasalDose) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    diabetesType,
    height,
    diabetesSince,
    basalInsulinName,
    bolusInsulinName,
    glucoseUnit,
    prescribedBasalDose,
    userId,
  );

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileResponseImplCopyWith<_$ProfileResponseImpl> get copyWith =>
      __$$ProfileResponseImplCopyWithImpl<_$ProfileResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileResponseImplToJson(this);
  }
}

abstract class _ProfileResponse implements ProfileResponse {
  const factory _ProfileResponse({
    required final int id,
    required final DiabetesType diabetesType,
    final int? height,
    final DateTime? diabetesSince,
    final String? basalInsulinName,
    final String? bolusInsulinName,
    required final GlucoseUnit glucoseUnit,
    final int? prescribedBasalDose,
    required final int userId,
  }) = _$ProfileResponseImpl;

  factory _ProfileResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileResponseImpl.fromJson;

  @override
  int get id;
  @override
  DiabetesType get diabetesType;
  @override
  int? get height;
  @override
  DateTime? get diabetesSince;
  @override
  String? get basalInsulinName;
  @override
  String? get bolusInsulinName;
  @override
  GlucoseUnit get glucoseUnit;
  @override
  int? get prescribedBasalDose;
  @override
  int get userId;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileResponseImplCopyWith<_$ProfileResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
