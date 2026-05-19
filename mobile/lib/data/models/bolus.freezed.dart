// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bolus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Bolus _$BolusFromJson(Map<String, dynamic> json) {
  return _Bolus.fromJson(json);
}

/// @nodoc
mixin _$Bolus {
  int get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  BolusType get bolusType => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int? get mealId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this Bolus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bolus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BolusCopyWith<Bolus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BolusCopyWith<$Res> {
  factory $BolusCopyWith(Bolus value, $Res Function(Bolus) then) =
      _$BolusCopyWithImpl<$Res, Bolus>;
  @useResult
  $Res call({
    int id,
    double amount,
    BolusType bolusType,
    DateTime timestamp,
    int? mealId,
    int userId,
  });
}

/// @nodoc
class _$BolusCopyWithImpl<$Res, $Val extends Bolus>
    implements $BolusCopyWith<$Res> {
  _$BolusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bolus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? bolusType = null,
    Object? timestamp = null,
    Object? mealId = freezed,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            bolusType: null == bolusType
                ? _value.bolusType
                : bolusType // ignore: cast_nullable_to_non_nullable
                      as BolusType,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            mealId: freezed == mealId
                ? _value.mealId
                : mealId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$BolusImplCopyWith<$Res> implements $BolusCopyWith<$Res> {
  factory _$$BolusImplCopyWith(
    _$BolusImpl value,
    $Res Function(_$BolusImpl) then,
  ) = __$$BolusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double amount,
    BolusType bolusType,
    DateTime timestamp,
    int? mealId,
    int userId,
  });
}

/// @nodoc
class __$$BolusImplCopyWithImpl<$Res>
    extends _$BolusCopyWithImpl<$Res, _$BolusImpl>
    implements _$$BolusImplCopyWith<$Res> {
  __$$BolusImplCopyWithImpl(
    _$BolusImpl _value,
    $Res Function(_$BolusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Bolus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? bolusType = null,
    Object? timestamp = null,
    Object? mealId = freezed,
    Object? userId = null,
  }) {
    return _then(
      _$BolusImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        bolusType: null == bolusType
            ? _value.bolusType
            : bolusType // ignore: cast_nullable_to_non_nullable
                  as BolusType,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        mealId: freezed == mealId
            ? _value.mealId
            : mealId // ignore: cast_nullable_to_non_nullable
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
class _$BolusImpl implements _Bolus {
  const _$BolusImpl({
    required this.id,
    required this.amount,
    required this.bolusType,
    required this.timestamp,
    this.mealId,
    required this.userId,
  });

  factory _$BolusImpl.fromJson(Map<String, dynamic> json) =>
      _$$BolusImplFromJson(json);

  @override
  final int id;
  @override
  final double amount;
  @override
  final BolusType bolusType;
  @override
  final DateTime timestamp;
  @override
  final int? mealId;
  @override
  final int userId;

  @override
  String toString() {
    return 'Bolus(id: $id, amount: $amount, bolusType: $bolusType, timestamp: $timestamp, mealId: $mealId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BolusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.bolusType, bolusType) ||
                other.bolusType == bolusType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    bolusType,
    timestamp,
    mealId,
    userId,
  );

  /// Create a copy of Bolus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BolusImplCopyWith<_$BolusImpl> get copyWith =>
      __$$BolusImplCopyWithImpl<_$BolusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BolusImplToJson(this);
  }
}

abstract class _Bolus implements Bolus {
  const factory _Bolus({
    required final int id,
    required final double amount,
    required final BolusType bolusType,
    required final DateTime timestamp,
    final int? mealId,
    required final int userId,
  }) = _$BolusImpl;

  factory _Bolus.fromJson(Map<String, dynamic> json) = _$BolusImpl.fromJson;

  @override
  int get id;
  @override
  double get amount;
  @override
  BolusType get bolusType;
  @override
  DateTime get timestamp;
  @override
  int? get mealId;
  @override
  int get userId;

  /// Create a copy of Bolus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BolusImplCopyWith<_$BolusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BolusRequest _$BolusRequestFromJson(Map<String, dynamic> json) {
  return _BolusRequest.fromJson(json);
}

/// @nodoc
mixin _$BolusRequest {
  double get amount => throw _privateConstructorUsedError;
  BolusType get bolusType => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int? get mealId => throw _privateConstructorUsedError;

  /// Serializes this BolusRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BolusRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BolusRequestCopyWith<BolusRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BolusRequestCopyWith<$Res> {
  factory $BolusRequestCopyWith(
    BolusRequest value,
    $Res Function(BolusRequest) then,
  ) = _$BolusRequestCopyWithImpl<$Res, BolusRequest>;
  @useResult
  $Res call({
    double amount,
    BolusType bolusType,
    DateTime timestamp,
    int? mealId,
  });
}

/// @nodoc
class _$BolusRequestCopyWithImpl<$Res, $Val extends BolusRequest>
    implements $BolusRequestCopyWith<$Res> {
  _$BolusRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BolusRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? bolusType = null,
    Object? timestamp = null,
    Object? mealId = freezed,
  }) {
    return _then(
      _value.copyWith(
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            bolusType: null == bolusType
                ? _value.bolusType
                : bolusType // ignore: cast_nullable_to_non_nullable
                      as BolusType,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            mealId: freezed == mealId
                ? _value.mealId
                : mealId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BolusRequestImplCopyWith<$Res>
    implements $BolusRequestCopyWith<$Res> {
  factory _$$BolusRequestImplCopyWith(
    _$BolusRequestImpl value,
    $Res Function(_$BolusRequestImpl) then,
  ) = __$$BolusRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double amount,
    BolusType bolusType,
    DateTime timestamp,
    int? mealId,
  });
}

/// @nodoc
class __$$BolusRequestImplCopyWithImpl<$Res>
    extends _$BolusRequestCopyWithImpl<$Res, _$BolusRequestImpl>
    implements _$$BolusRequestImplCopyWith<$Res> {
  __$$BolusRequestImplCopyWithImpl(
    _$BolusRequestImpl _value,
    $Res Function(_$BolusRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BolusRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? bolusType = null,
    Object? timestamp = null,
    Object? mealId = freezed,
  }) {
    return _then(
      _$BolusRequestImpl(
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        bolusType: null == bolusType
            ? _value.bolusType
            : bolusType // ignore: cast_nullable_to_non_nullable
                  as BolusType,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        mealId: freezed == mealId
            ? _value.mealId
            : mealId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BolusRequestImpl implements _BolusRequest {
  const _$BolusRequestImpl({
    required this.amount,
    required this.bolusType,
    required this.timestamp,
    this.mealId,
  });

  factory _$BolusRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BolusRequestImplFromJson(json);

  @override
  final double amount;
  @override
  final BolusType bolusType;
  @override
  final DateTime timestamp;
  @override
  final int? mealId;

  @override
  String toString() {
    return 'BolusRequest(amount: $amount, bolusType: $bolusType, timestamp: $timestamp, mealId: $mealId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BolusRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.bolusType, bolusType) ||
                other.bolusType == bolusType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.mealId, mealId) || other.mealId == mealId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, bolusType, timestamp, mealId);

  /// Create a copy of BolusRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BolusRequestImplCopyWith<_$BolusRequestImpl> get copyWith =>
      __$$BolusRequestImplCopyWithImpl<_$BolusRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BolusRequestImplToJson(this);
  }
}

abstract class _BolusRequest implements BolusRequest {
  const factory _BolusRequest({
    required final double amount,
    required final BolusType bolusType,
    required final DateTime timestamp,
    final int? mealId,
  }) = _$BolusRequestImpl;

  factory _BolusRequest.fromJson(Map<String, dynamic> json) =
      _$BolusRequestImpl.fromJson;

  @override
  double get amount;
  @override
  BolusType get bolusType;
  @override
  DateTime get timestamp;
  @override
  int? get mealId;

  /// Create a copy of BolusRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BolusRequestImplCopyWith<_$BolusRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BolusResponse _$BolusResponseFromJson(Map<String, dynamic> json) {
  return _BolusResponse.fromJson(json);
}

/// @nodoc
mixin _$BolusResponse {
  int get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  BolusType get bolusType => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int? get mealId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this BolusResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BolusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BolusResponseCopyWith<BolusResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BolusResponseCopyWith<$Res> {
  factory $BolusResponseCopyWith(
    BolusResponse value,
    $Res Function(BolusResponse) then,
  ) = _$BolusResponseCopyWithImpl<$Res, BolusResponse>;
  @useResult
  $Res call({
    int id,
    double amount,
    BolusType bolusType,
    DateTime timestamp,
    int? mealId,
    int userId,
  });
}

/// @nodoc
class _$BolusResponseCopyWithImpl<$Res, $Val extends BolusResponse>
    implements $BolusResponseCopyWith<$Res> {
  _$BolusResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BolusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? bolusType = null,
    Object? timestamp = null,
    Object? mealId = freezed,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            bolusType: null == bolusType
                ? _value.bolusType
                : bolusType // ignore: cast_nullable_to_non_nullable
                      as BolusType,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            mealId: freezed == mealId
                ? _value.mealId
                : mealId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$BolusResponseImplCopyWith<$Res>
    implements $BolusResponseCopyWith<$Res> {
  factory _$$BolusResponseImplCopyWith(
    _$BolusResponseImpl value,
    $Res Function(_$BolusResponseImpl) then,
  ) = __$$BolusResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double amount,
    BolusType bolusType,
    DateTime timestamp,
    int? mealId,
    int userId,
  });
}

/// @nodoc
class __$$BolusResponseImplCopyWithImpl<$Res>
    extends _$BolusResponseCopyWithImpl<$Res, _$BolusResponseImpl>
    implements _$$BolusResponseImplCopyWith<$Res> {
  __$$BolusResponseImplCopyWithImpl(
    _$BolusResponseImpl _value,
    $Res Function(_$BolusResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BolusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? bolusType = null,
    Object? timestamp = null,
    Object? mealId = freezed,
    Object? userId = null,
  }) {
    return _then(
      _$BolusResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        bolusType: null == bolusType
            ? _value.bolusType
            : bolusType // ignore: cast_nullable_to_non_nullable
                  as BolusType,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        mealId: freezed == mealId
            ? _value.mealId
            : mealId // ignore: cast_nullable_to_non_nullable
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
class _$BolusResponseImpl implements _BolusResponse {
  const _$BolusResponseImpl({
    required this.id,
    required this.amount,
    required this.bolusType,
    required this.timestamp,
    this.mealId,
    required this.userId,
  });

  factory _$BolusResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BolusResponseImplFromJson(json);

  @override
  final int id;
  @override
  final double amount;
  @override
  final BolusType bolusType;
  @override
  final DateTime timestamp;
  @override
  final int? mealId;
  @override
  final int userId;

  @override
  String toString() {
    return 'BolusResponse(id: $id, amount: $amount, bolusType: $bolusType, timestamp: $timestamp, mealId: $mealId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BolusResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.bolusType, bolusType) ||
                other.bolusType == bolusType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    bolusType,
    timestamp,
    mealId,
    userId,
  );

  /// Create a copy of BolusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BolusResponseImplCopyWith<_$BolusResponseImpl> get copyWith =>
      __$$BolusResponseImplCopyWithImpl<_$BolusResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BolusResponseImplToJson(this);
  }
}

abstract class _BolusResponse implements BolusResponse {
  const factory _BolusResponse({
    required final int id,
    required final double amount,
    required final BolusType bolusType,
    required final DateTime timestamp,
    final int? mealId,
    required final int userId,
  }) = _$BolusResponseImpl;

  factory _BolusResponse.fromJson(Map<String, dynamic> json) =
      _$BolusResponseImpl.fromJson;

  @override
  int get id;
  @override
  double get amount;
  @override
  BolusType get bolusType;
  @override
  DateTime get timestamp;
  @override
  int? get mealId;
  @override
  int get userId;

  /// Create a copy of BolusResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BolusResponseImplCopyWith<_$BolusResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
