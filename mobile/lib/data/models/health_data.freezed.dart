// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HealthData _$HealthDataFromJson(Map<String, dynamic> json) {
  return _HealthData.fromJson(json);
}

/// @nodoc
mixin _$HealthData {
  int get id => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  int? get heartRate => throw _privateConstructorUsedError;
  String? get bloodPressure => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this HealthData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthDataCopyWith<HealthData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthDataCopyWith<$Res> {
  factory $HealthDataCopyWith(
    HealthData value,
    $Res Function(HealthData) then,
  ) = _$HealthDataCopyWithImpl<$Res, HealthData>;
  @useResult
  $Res call({
    int id,
    double? weight,
    int? heartRate,
    String? bloodPressure,
    DateTime date,
    int userId,
  });
}

/// @nodoc
class _$HealthDataCopyWithImpl<$Res, $Val extends HealthData>
    implements $HealthDataCopyWith<$Res> {
  _$HealthDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weight = freezed,
    Object? heartRate = freezed,
    Object? bloodPressure = freezed,
    Object? date = null,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: freezed == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double?,
            heartRate: freezed == heartRate
                ? _value.heartRate
                : heartRate // ignore: cast_nullable_to_non_nullable
                      as int?,
            bloodPressure: freezed == bloodPressure
                ? _value.bloodPressure
                : bloodPressure // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$HealthDataImplCopyWith<$Res>
    implements $HealthDataCopyWith<$Res> {
  factory _$$HealthDataImplCopyWith(
    _$HealthDataImpl value,
    $Res Function(_$HealthDataImpl) then,
  ) = __$$HealthDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double? weight,
    int? heartRate,
    String? bloodPressure,
    DateTime date,
    int userId,
  });
}

/// @nodoc
class __$$HealthDataImplCopyWithImpl<$Res>
    extends _$HealthDataCopyWithImpl<$Res, _$HealthDataImpl>
    implements _$$HealthDataImplCopyWith<$Res> {
  __$$HealthDataImplCopyWithImpl(
    _$HealthDataImpl _value,
    $Res Function(_$HealthDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weight = freezed,
    Object? heartRate = freezed,
    Object? bloodPressure = freezed,
    Object? date = null,
    Object? userId = null,
  }) {
    return _then(
      _$HealthDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: freezed == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double?,
        heartRate: freezed == heartRate
            ? _value.heartRate
            : heartRate // ignore: cast_nullable_to_non_nullable
                  as int?,
        bloodPressure: freezed == bloodPressure
            ? _value.bloodPressure
            : bloodPressure // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$HealthDataImpl implements _HealthData {
  const _$HealthDataImpl({
    required this.id,
    this.weight,
    this.heartRate,
    this.bloodPressure,
    required this.date,
    required this.userId,
  });

  factory _$HealthDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthDataImplFromJson(json);

  @override
  final int id;
  @override
  final double? weight;
  @override
  final int? heartRate;
  @override
  final String? bloodPressure;
  @override
  final DateTime date;
  @override
  final int userId;

  @override
  String toString() {
    return 'HealthData(id: $id, weight: $weight, heartRate: $heartRate, bloodPressure: $bloodPressure, date: $date, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.bloodPressure, bloodPressure) ||
                other.bloodPressure == bloodPressure) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    weight,
    heartRate,
    bloodPressure,
    date,
    userId,
  );

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthDataImplCopyWith<_$HealthDataImpl> get copyWith =>
      __$$HealthDataImplCopyWithImpl<_$HealthDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthDataImplToJson(this);
  }
}

abstract class _HealthData implements HealthData {
  const factory _HealthData({
    required final int id,
    final double? weight,
    final int? heartRate,
    final String? bloodPressure,
    required final DateTime date,
    required final int userId,
  }) = _$HealthDataImpl;

  factory _HealthData.fromJson(Map<String, dynamic> json) =
      _$HealthDataImpl.fromJson;

  @override
  int get id;
  @override
  double? get weight;
  @override
  int? get heartRate;
  @override
  String? get bloodPressure;
  @override
  DateTime get date;
  @override
  int get userId;

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthDataImplCopyWith<_$HealthDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthDataRequest _$HealthDataRequestFromJson(Map<String, dynamic> json) {
  return _HealthDataRequest.fromJson(json);
}

/// @nodoc
mixin _$HealthDataRequest {
  double? get weight => throw _privateConstructorUsedError;
  int? get heartRate => throw _privateConstructorUsedError;
  String? get bloodPressure => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Serializes this HealthDataRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthDataRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthDataRequestCopyWith<HealthDataRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthDataRequestCopyWith<$Res> {
  factory $HealthDataRequestCopyWith(
    HealthDataRequest value,
    $Res Function(HealthDataRequest) then,
  ) = _$HealthDataRequestCopyWithImpl<$Res, HealthDataRequest>;
  @useResult
  $Res call({
    double? weight,
    int? heartRate,
    String? bloodPressure,
    DateTime date,
  });
}

/// @nodoc
class _$HealthDataRequestCopyWithImpl<$Res, $Val extends HealthDataRequest>
    implements $HealthDataRequestCopyWith<$Res> {
  _$HealthDataRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthDataRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = freezed,
    Object? heartRate = freezed,
    Object? bloodPressure = freezed,
    Object? date = null,
  }) {
    return _then(
      _value.copyWith(
            weight: freezed == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double?,
            heartRate: freezed == heartRate
                ? _value.heartRate
                : heartRate // ignore: cast_nullable_to_non_nullable
                      as int?,
            bloodPressure: freezed == bloodPressure
                ? _value.bloodPressure
                : bloodPressure // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HealthDataRequestImplCopyWith<$Res>
    implements $HealthDataRequestCopyWith<$Res> {
  factory _$$HealthDataRequestImplCopyWith(
    _$HealthDataRequestImpl value,
    $Res Function(_$HealthDataRequestImpl) then,
  ) = __$$HealthDataRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double? weight,
    int? heartRate,
    String? bloodPressure,
    DateTime date,
  });
}

/// @nodoc
class __$$HealthDataRequestImplCopyWithImpl<$Res>
    extends _$HealthDataRequestCopyWithImpl<$Res, _$HealthDataRequestImpl>
    implements _$$HealthDataRequestImplCopyWith<$Res> {
  __$$HealthDataRequestImplCopyWithImpl(
    _$HealthDataRequestImpl _value,
    $Res Function(_$HealthDataRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HealthDataRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = freezed,
    Object? heartRate = freezed,
    Object? bloodPressure = freezed,
    Object? date = null,
  }) {
    return _then(
      _$HealthDataRequestImpl(
        weight: freezed == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double?,
        heartRate: freezed == heartRate
            ? _value.heartRate
            : heartRate // ignore: cast_nullable_to_non_nullable
                  as int?,
        bloodPressure: freezed == bloodPressure
            ? _value.bloodPressure
            : bloodPressure // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthDataRequestImpl implements _HealthDataRequest {
  const _$HealthDataRequestImpl({
    this.weight,
    this.heartRate,
    this.bloodPressure,
    required this.date,
  });

  factory _$HealthDataRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthDataRequestImplFromJson(json);

  @override
  final double? weight;
  @override
  final int? heartRate;
  @override
  final String? bloodPressure;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'HealthDataRequest(weight: $weight, heartRate: $heartRate, bloodPressure: $bloodPressure, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthDataRequestImpl &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.bloodPressure, bloodPressure) ||
                other.bloodPressure == bloodPressure) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, weight, heartRate, bloodPressure, date);

  /// Create a copy of HealthDataRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthDataRequestImplCopyWith<_$HealthDataRequestImpl> get copyWith =>
      __$$HealthDataRequestImplCopyWithImpl<_$HealthDataRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthDataRequestImplToJson(this);
  }
}

abstract class _HealthDataRequest implements HealthDataRequest {
  const factory _HealthDataRequest({
    final double? weight,
    final int? heartRate,
    final String? bloodPressure,
    required final DateTime date,
  }) = _$HealthDataRequestImpl;

  factory _HealthDataRequest.fromJson(Map<String, dynamic> json) =
      _$HealthDataRequestImpl.fromJson;

  @override
  double? get weight;
  @override
  int? get heartRate;
  @override
  String? get bloodPressure;
  @override
  DateTime get date;

  /// Create a copy of HealthDataRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthDataRequestImplCopyWith<_$HealthDataRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthDataResponse _$HealthDataResponseFromJson(Map<String, dynamic> json) {
  return _HealthDataResponse.fromJson(json);
}

/// @nodoc
mixin _$HealthDataResponse {
  int get id => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  int? get heartRate => throw _privateConstructorUsedError;
  String? get bloodPressure => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this HealthDataResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthDataResponseCopyWith<HealthDataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthDataResponseCopyWith<$Res> {
  factory $HealthDataResponseCopyWith(
    HealthDataResponse value,
    $Res Function(HealthDataResponse) then,
  ) = _$HealthDataResponseCopyWithImpl<$Res, HealthDataResponse>;
  @useResult
  $Res call({
    int id,
    double? weight,
    int? heartRate,
    String? bloodPressure,
    DateTime date,
    int userId,
  });
}

/// @nodoc
class _$HealthDataResponseCopyWithImpl<$Res, $Val extends HealthDataResponse>
    implements $HealthDataResponseCopyWith<$Res> {
  _$HealthDataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weight = freezed,
    Object? heartRate = freezed,
    Object? bloodPressure = freezed,
    Object? date = null,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: freezed == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double?,
            heartRate: freezed == heartRate
                ? _value.heartRate
                : heartRate // ignore: cast_nullable_to_non_nullable
                      as int?,
            bloodPressure: freezed == bloodPressure
                ? _value.bloodPressure
                : bloodPressure // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$HealthDataResponseImplCopyWith<$Res>
    implements $HealthDataResponseCopyWith<$Res> {
  factory _$$HealthDataResponseImplCopyWith(
    _$HealthDataResponseImpl value,
    $Res Function(_$HealthDataResponseImpl) then,
  ) = __$$HealthDataResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double? weight,
    int? heartRate,
    String? bloodPressure,
    DateTime date,
    int userId,
  });
}

/// @nodoc
class __$$HealthDataResponseImplCopyWithImpl<$Res>
    extends _$HealthDataResponseCopyWithImpl<$Res, _$HealthDataResponseImpl>
    implements _$$HealthDataResponseImplCopyWith<$Res> {
  __$$HealthDataResponseImplCopyWithImpl(
    _$HealthDataResponseImpl _value,
    $Res Function(_$HealthDataResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HealthDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weight = freezed,
    Object? heartRate = freezed,
    Object? bloodPressure = freezed,
    Object? date = null,
    Object? userId = null,
  }) {
    return _then(
      _$HealthDataResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: freezed == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double?,
        heartRate: freezed == heartRate
            ? _value.heartRate
            : heartRate // ignore: cast_nullable_to_non_nullable
                  as int?,
        bloodPressure: freezed == bloodPressure
            ? _value.bloodPressure
            : bloodPressure // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$HealthDataResponseImpl implements _HealthDataResponse {
  const _$HealthDataResponseImpl({
    required this.id,
    this.weight,
    this.heartRate,
    this.bloodPressure,
    required this.date,
    required this.userId,
  });

  factory _$HealthDataResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthDataResponseImplFromJson(json);

  @override
  final int id;
  @override
  final double? weight;
  @override
  final int? heartRate;
  @override
  final String? bloodPressure;
  @override
  final DateTime date;
  @override
  final int userId;

  @override
  String toString() {
    return 'HealthDataResponse(id: $id, weight: $weight, heartRate: $heartRate, bloodPressure: $bloodPressure, date: $date, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthDataResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.bloodPressure, bloodPressure) ||
                other.bloodPressure == bloodPressure) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    weight,
    heartRate,
    bloodPressure,
    date,
    userId,
  );

  /// Create a copy of HealthDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthDataResponseImplCopyWith<_$HealthDataResponseImpl> get copyWith =>
      __$$HealthDataResponseImplCopyWithImpl<_$HealthDataResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthDataResponseImplToJson(this);
  }
}

abstract class _HealthDataResponse implements HealthDataResponse {
  const factory _HealthDataResponse({
    required final int id,
    final double? weight,
    final int? heartRate,
    final String? bloodPressure,
    required final DateTime date,
    required final int userId,
  }) = _$HealthDataResponseImpl;

  factory _HealthDataResponse.fromJson(Map<String, dynamic> json) =
      _$HealthDataResponseImpl.fromJson;

  @override
  int get id;
  @override
  double? get weight;
  @override
  int? get heartRate;
  @override
  String? get bloodPressure;
  @override
  DateTime get date;
  @override
  int get userId;

  /// Create a copy of HealthDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthDataResponseImplCopyWith<_$HealthDataResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
