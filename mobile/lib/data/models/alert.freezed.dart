// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Alert _$AlertFromJson(Map<String, dynamic> json) {
  return _Alert.fromJson(json);
}

/// @nodoc
mixin _$Alert {
  int get id => throw _privateConstructorUsedError;
  double get thresholdLow => throw _privateConstructorUsedError;
  double get thresholdHigh => throw _privateConstructorUsedError;
  NotifyVia get notifyVia => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this Alert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertCopyWith<Alert> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertCopyWith<$Res> {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) then) =
      _$AlertCopyWithImpl<$Res, Alert>;
  @useResult
  $Res call({
    int id,
    double thresholdLow,
    double thresholdHigh,
    NotifyVia notifyVia,
    bool active,
    int userId,
  });
}

/// @nodoc
class _$AlertCopyWithImpl<$Res, $Val extends Alert>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? thresholdLow = null,
    Object? thresholdHigh = null,
    Object? notifyVia = null,
    Object? active = null,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            thresholdLow: null == thresholdLow
                ? _value.thresholdLow
                : thresholdLow // ignore: cast_nullable_to_non_nullable
                      as double,
            thresholdHigh: null == thresholdHigh
                ? _value.thresholdHigh
                : thresholdHigh // ignore: cast_nullable_to_non_nullable
                      as double,
            notifyVia: null == notifyVia
                ? _value.notifyVia
                : notifyVia // ignore: cast_nullable_to_non_nullable
                      as NotifyVia,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$AlertImplCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$$AlertImplCopyWith(
    _$AlertImpl value,
    $Res Function(_$AlertImpl) then,
  ) = __$$AlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double thresholdLow,
    double thresholdHigh,
    NotifyVia notifyVia,
    bool active,
    int userId,
  });
}

/// @nodoc
class __$$AlertImplCopyWithImpl<$Res>
    extends _$AlertCopyWithImpl<$Res, _$AlertImpl>
    implements _$$AlertImplCopyWith<$Res> {
  __$$AlertImplCopyWithImpl(
    _$AlertImpl _value,
    $Res Function(_$AlertImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? thresholdLow = null,
    Object? thresholdHigh = null,
    Object? notifyVia = null,
    Object? active = null,
    Object? userId = null,
  }) {
    return _then(
      _$AlertImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        thresholdLow: null == thresholdLow
            ? _value.thresholdLow
            : thresholdLow // ignore: cast_nullable_to_non_nullable
                  as double,
        thresholdHigh: null == thresholdHigh
            ? _value.thresholdHigh
            : thresholdHigh // ignore: cast_nullable_to_non_nullable
                  as double,
        notifyVia: null == notifyVia
            ? _value.notifyVia
            : notifyVia // ignore: cast_nullable_to_non_nullable
                  as NotifyVia,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$AlertImpl implements _Alert {
  const _$AlertImpl({
    required this.id,
    required this.thresholdLow,
    required this.thresholdHigh,
    required this.notifyVia,
    required this.active,
    required this.userId,
  });

  factory _$AlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertImplFromJson(json);

  @override
  final int id;
  @override
  final double thresholdLow;
  @override
  final double thresholdHigh;
  @override
  final NotifyVia notifyVia;
  @override
  final bool active;
  @override
  final int userId;

  @override
  String toString() {
    return 'Alert(id: $id, thresholdLow: $thresholdLow, thresholdHigh: $thresholdHigh, notifyVia: $notifyVia, active: $active, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.thresholdLow, thresholdLow) ||
                other.thresholdLow == thresholdLow) &&
            (identical(other.thresholdHigh, thresholdHigh) ||
                other.thresholdHigh == thresholdHigh) &&
            (identical(other.notifyVia, notifyVia) ||
                other.notifyVia == notifyVia) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    thresholdLow,
    thresholdHigh,
    notifyVia,
    active,
    userId,
  );

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      __$$AlertImplCopyWithImpl<_$AlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertImplToJson(this);
  }
}

abstract class _Alert implements Alert {
  const factory _Alert({
    required final int id,
    required final double thresholdLow,
    required final double thresholdHigh,
    required final NotifyVia notifyVia,
    required final bool active,
    required final int userId,
  }) = _$AlertImpl;

  factory _Alert.fromJson(Map<String, dynamic> json) = _$AlertImpl.fromJson;

  @override
  int get id;
  @override
  double get thresholdLow;
  @override
  double get thresholdHigh;
  @override
  NotifyVia get notifyVia;
  @override
  bool get active;
  @override
  int get userId;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlertRequest _$AlertRequestFromJson(Map<String, dynamic> json) {
  return _AlertRequest.fromJson(json);
}

/// @nodoc
mixin _$AlertRequest {
  double get thresholdLow => throw _privateConstructorUsedError;
  double get thresholdHigh => throw _privateConstructorUsedError;
  NotifyVia get notifyVia => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this AlertRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertRequestCopyWith<AlertRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertRequestCopyWith<$Res> {
  factory $AlertRequestCopyWith(
    AlertRequest value,
    $Res Function(AlertRequest) then,
  ) = _$AlertRequestCopyWithImpl<$Res, AlertRequest>;
  @useResult
  $Res call({
    double thresholdLow,
    double thresholdHigh,
    NotifyVia notifyVia,
    bool active,
  });
}

/// @nodoc
class _$AlertRequestCopyWithImpl<$Res, $Val extends AlertRequest>
    implements $AlertRequestCopyWith<$Res> {
  _$AlertRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thresholdLow = null,
    Object? thresholdHigh = null,
    Object? notifyVia = null,
    Object? active = null,
  }) {
    return _then(
      _value.copyWith(
            thresholdLow: null == thresholdLow
                ? _value.thresholdLow
                : thresholdLow // ignore: cast_nullable_to_non_nullable
                      as double,
            thresholdHigh: null == thresholdHigh
                ? _value.thresholdHigh
                : thresholdHigh // ignore: cast_nullable_to_non_nullable
                      as double,
            notifyVia: null == notifyVia
                ? _value.notifyVia
                : notifyVia // ignore: cast_nullable_to_non_nullable
                      as NotifyVia,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AlertRequestImplCopyWith<$Res>
    implements $AlertRequestCopyWith<$Res> {
  factory _$$AlertRequestImplCopyWith(
    _$AlertRequestImpl value,
    $Res Function(_$AlertRequestImpl) then,
  ) = __$$AlertRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double thresholdLow,
    double thresholdHigh,
    NotifyVia notifyVia,
    bool active,
  });
}

/// @nodoc
class __$$AlertRequestImplCopyWithImpl<$Res>
    extends _$AlertRequestCopyWithImpl<$Res, _$AlertRequestImpl>
    implements _$$AlertRequestImplCopyWith<$Res> {
  __$$AlertRequestImplCopyWithImpl(
    _$AlertRequestImpl _value,
    $Res Function(_$AlertRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlertRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thresholdLow = null,
    Object? thresholdHigh = null,
    Object? notifyVia = null,
    Object? active = null,
  }) {
    return _then(
      _$AlertRequestImpl(
        thresholdLow: null == thresholdLow
            ? _value.thresholdLow
            : thresholdLow // ignore: cast_nullable_to_non_nullable
                  as double,
        thresholdHigh: null == thresholdHigh
            ? _value.thresholdHigh
            : thresholdHigh // ignore: cast_nullable_to_non_nullable
                  as double,
        notifyVia: null == notifyVia
            ? _value.notifyVia
            : notifyVia // ignore: cast_nullable_to_non_nullable
                  as NotifyVia,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertRequestImpl implements _AlertRequest {
  const _$AlertRequestImpl({
    required this.thresholdLow,
    required this.thresholdHigh,
    required this.notifyVia,
    required this.active,
  });

  factory _$AlertRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertRequestImplFromJson(json);

  @override
  final double thresholdLow;
  @override
  final double thresholdHigh;
  @override
  final NotifyVia notifyVia;
  @override
  final bool active;

  @override
  String toString() {
    return 'AlertRequest(thresholdLow: $thresholdLow, thresholdHigh: $thresholdHigh, notifyVia: $notifyVia, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertRequestImpl &&
            (identical(other.thresholdLow, thresholdLow) ||
                other.thresholdLow == thresholdLow) &&
            (identical(other.thresholdHigh, thresholdHigh) ||
                other.thresholdHigh == thresholdHigh) &&
            (identical(other.notifyVia, notifyVia) ||
                other.notifyVia == notifyVia) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, thresholdLow, thresholdHigh, notifyVia, active);

  /// Create a copy of AlertRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertRequestImplCopyWith<_$AlertRequestImpl> get copyWith =>
      __$$AlertRequestImplCopyWithImpl<_$AlertRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertRequestImplToJson(this);
  }
}

abstract class _AlertRequest implements AlertRequest {
  const factory _AlertRequest({
    required final double thresholdLow,
    required final double thresholdHigh,
    required final NotifyVia notifyVia,
    required final bool active,
  }) = _$AlertRequestImpl;

  factory _AlertRequest.fromJson(Map<String, dynamic> json) =
      _$AlertRequestImpl.fromJson;

  @override
  double get thresholdLow;
  @override
  double get thresholdHigh;
  @override
  NotifyVia get notifyVia;
  @override
  bool get active;

  /// Create a copy of AlertRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertRequestImplCopyWith<_$AlertRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlertResponse _$AlertResponseFromJson(Map<String, dynamic> json) {
  return _AlertResponse.fromJson(json);
}

/// @nodoc
mixin _$AlertResponse {
  int get id => throw _privateConstructorUsedError;
  double get thresholdLow => throw _privateConstructorUsedError;
  double get thresholdHigh => throw _privateConstructorUsedError;
  NotifyVia get notifyVia => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this AlertResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertResponseCopyWith<AlertResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertResponseCopyWith<$Res> {
  factory $AlertResponseCopyWith(
    AlertResponse value,
    $Res Function(AlertResponse) then,
  ) = _$AlertResponseCopyWithImpl<$Res, AlertResponse>;
  @useResult
  $Res call({
    int id,
    double thresholdLow,
    double thresholdHigh,
    NotifyVia notifyVia,
    bool active,
    int userId,
  });
}

/// @nodoc
class _$AlertResponseCopyWithImpl<$Res, $Val extends AlertResponse>
    implements $AlertResponseCopyWith<$Res> {
  _$AlertResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? thresholdLow = null,
    Object? thresholdHigh = null,
    Object? notifyVia = null,
    Object? active = null,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            thresholdLow: null == thresholdLow
                ? _value.thresholdLow
                : thresholdLow // ignore: cast_nullable_to_non_nullable
                      as double,
            thresholdHigh: null == thresholdHigh
                ? _value.thresholdHigh
                : thresholdHigh // ignore: cast_nullable_to_non_nullable
                      as double,
            notifyVia: null == notifyVia
                ? _value.notifyVia
                : notifyVia // ignore: cast_nullable_to_non_nullable
                      as NotifyVia,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$AlertResponseImplCopyWith<$Res>
    implements $AlertResponseCopyWith<$Res> {
  factory _$$AlertResponseImplCopyWith(
    _$AlertResponseImpl value,
    $Res Function(_$AlertResponseImpl) then,
  ) = __$$AlertResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double thresholdLow,
    double thresholdHigh,
    NotifyVia notifyVia,
    bool active,
    int userId,
  });
}

/// @nodoc
class __$$AlertResponseImplCopyWithImpl<$Res>
    extends _$AlertResponseCopyWithImpl<$Res, _$AlertResponseImpl>
    implements _$$AlertResponseImplCopyWith<$Res> {
  __$$AlertResponseImplCopyWithImpl(
    _$AlertResponseImpl _value,
    $Res Function(_$AlertResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? thresholdLow = null,
    Object? thresholdHigh = null,
    Object? notifyVia = null,
    Object? active = null,
    Object? userId = null,
  }) {
    return _then(
      _$AlertResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        thresholdLow: null == thresholdLow
            ? _value.thresholdLow
            : thresholdLow // ignore: cast_nullable_to_non_nullable
                  as double,
        thresholdHigh: null == thresholdHigh
            ? _value.thresholdHigh
            : thresholdHigh // ignore: cast_nullable_to_non_nullable
                  as double,
        notifyVia: null == notifyVia
            ? _value.notifyVia
            : notifyVia // ignore: cast_nullable_to_non_nullable
                  as NotifyVia,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$AlertResponseImpl implements _AlertResponse {
  const _$AlertResponseImpl({
    required this.id,
    required this.thresholdLow,
    required this.thresholdHigh,
    required this.notifyVia,
    required this.active,
    required this.userId,
  });

  factory _$AlertResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertResponseImplFromJson(json);

  @override
  final int id;
  @override
  final double thresholdLow;
  @override
  final double thresholdHigh;
  @override
  final NotifyVia notifyVia;
  @override
  final bool active;
  @override
  final int userId;

  @override
  String toString() {
    return 'AlertResponse(id: $id, thresholdLow: $thresholdLow, thresholdHigh: $thresholdHigh, notifyVia: $notifyVia, active: $active, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.thresholdLow, thresholdLow) ||
                other.thresholdLow == thresholdLow) &&
            (identical(other.thresholdHigh, thresholdHigh) ||
                other.thresholdHigh == thresholdHigh) &&
            (identical(other.notifyVia, notifyVia) ||
                other.notifyVia == notifyVia) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    thresholdLow,
    thresholdHigh,
    notifyVia,
    active,
    userId,
  );

  /// Create a copy of AlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertResponseImplCopyWith<_$AlertResponseImpl> get copyWith =>
      __$$AlertResponseImplCopyWithImpl<_$AlertResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertResponseImplToJson(this);
  }
}

abstract class _AlertResponse implements AlertResponse {
  const factory _AlertResponse({
    required final int id,
    required final double thresholdLow,
    required final double thresholdHigh,
    required final NotifyVia notifyVia,
    required final bool active,
    required final int userId,
  }) = _$AlertResponseImpl;

  factory _AlertResponse.fromJson(Map<String, dynamic> json) =
      _$AlertResponseImpl.fromJson;

  @override
  int get id;
  @override
  double get thresholdLow;
  @override
  double get thresholdHigh;
  @override
  NotifyVia get notifyVia;
  @override
  bool get active;
  @override
  int get userId;

  /// Create a copy of AlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertResponseImplCopyWith<_$AlertResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlertHistory _$AlertHistoryFromJson(Map<String, dynamic> json) {
  return _AlertHistory.fromJson(json);
}

/// @nodoc
mixin _$AlertHistory {
  int get id => throw _privateConstructorUsedError;
  DateTime get triggeredAt => throw _privateConstructorUsedError;
  double get glucoseValue => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this AlertHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertHistoryCopyWith<AlertHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertHistoryCopyWith<$Res> {
  factory $AlertHistoryCopyWith(
    AlertHistory value,
    $Res Function(AlertHistory) then,
  ) = _$AlertHistoryCopyWithImpl<$Res, AlertHistory>;
  @useResult
  $Res call({
    int id,
    DateTime triggeredAt,
    double glucoseValue,
    String? message,
    int userId,
  });
}

/// @nodoc
class _$AlertHistoryCopyWithImpl<$Res, $Val extends AlertHistory>
    implements $AlertHistoryCopyWith<$Res> {
  _$AlertHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? triggeredAt = null,
    Object? glucoseValue = null,
    Object? message = freezed,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            triggeredAt: null == triggeredAt
                ? _value.triggeredAt
                : triggeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            glucoseValue: null == glucoseValue
                ? _value.glucoseValue
                : glucoseValue // ignore: cast_nullable_to_non_nullable
                      as double,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$AlertHistoryImplCopyWith<$Res>
    implements $AlertHistoryCopyWith<$Res> {
  factory _$$AlertHistoryImplCopyWith(
    _$AlertHistoryImpl value,
    $Res Function(_$AlertHistoryImpl) then,
  ) = __$$AlertHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    DateTime triggeredAt,
    double glucoseValue,
    String? message,
    int userId,
  });
}

/// @nodoc
class __$$AlertHistoryImplCopyWithImpl<$Res>
    extends _$AlertHistoryCopyWithImpl<$Res, _$AlertHistoryImpl>
    implements _$$AlertHistoryImplCopyWith<$Res> {
  __$$AlertHistoryImplCopyWithImpl(
    _$AlertHistoryImpl _value,
    $Res Function(_$AlertHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlertHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? triggeredAt = null,
    Object? glucoseValue = null,
    Object? message = freezed,
    Object? userId = null,
  }) {
    return _then(
      _$AlertHistoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        triggeredAt: null == triggeredAt
            ? _value.triggeredAt
            : triggeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        glucoseValue: null == glucoseValue
            ? _value.glucoseValue
            : glucoseValue // ignore: cast_nullable_to_non_nullable
                  as double,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$AlertHistoryImpl implements _AlertHistory {
  const _$AlertHistoryImpl({
    required this.id,
    required this.triggeredAt,
    required this.glucoseValue,
    this.message,
    required this.userId,
  });

  factory _$AlertHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertHistoryImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime triggeredAt;
  @override
  final double glucoseValue;
  @override
  final String? message;
  @override
  final int userId;

  @override
  String toString() {
    return 'AlertHistory(id: $id, triggeredAt: $triggeredAt, glucoseValue: $glucoseValue, message: $message, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.triggeredAt, triggeredAt) ||
                other.triggeredAt == triggeredAt) &&
            (identical(other.glucoseValue, glucoseValue) ||
                other.glucoseValue == glucoseValue) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, triggeredAt, glucoseValue, message, userId);

  /// Create a copy of AlertHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertHistoryImplCopyWith<_$AlertHistoryImpl> get copyWith =>
      __$$AlertHistoryImplCopyWithImpl<_$AlertHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertHistoryImplToJson(this);
  }
}

abstract class _AlertHistory implements AlertHistory {
  const factory _AlertHistory({
    required final int id,
    required final DateTime triggeredAt,
    required final double glucoseValue,
    final String? message,
    required final int userId,
  }) = _$AlertHistoryImpl;

  factory _AlertHistory.fromJson(Map<String, dynamic> json) =
      _$AlertHistoryImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get triggeredAt;
  @override
  double get glucoseValue;
  @override
  String? get message;
  @override
  int get userId;

  /// Create a copy of AlertHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertHistoryImplCopyWith<_$AlertHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlertHistoryResponse _$AlertHistoryResponseFromJson(Map<String, dynamic> json) {
  return _AlertHistoryResponse.fromJson(json);
}

/// @nodoc
mixin _$AlertHistoryResponse {
  int get id => throw _privateConstructorUsedError;
  DateTime get triggeredAt => throw _privateConstructorUsedError;
  double get glucoseValue => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this AlertHistoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertHistoryResponseCopyWith<AlertHistoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertHistoryResponseCopyWith<$Res> {
  factory $AlertHistoryResponseCopyWith(
    AlertHistoryResponse value,
    $Res Function(AlertHistoryResponse) then,
  ) = _$AlertHistoryResponseCopyWithImpl<$Res, AlertHistoryResponse>;
  @useResult
  $Res call({
    int id,
    DateTime triggeredAt,
    double glucoseValue,
    String? message,
    int userId,
  });
}

/// @nodoc
class _$AlertHistoryResponseCopyWithImpl<
  $Res,
  $Val extends AlertHistoryResponse
>
    implements $AlertHistoryResponseCopyWith<$Res> {
  _$AlertHistoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? triggeredAt = null,
    Object? glucoseValue = null,
    Object? message = freezed,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            triggeredAt: null == triggeredAt
                ? _value.triggeredAt
                : triggeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            glucoseValue: null == glucoseValue
                ? _value.glucoseValue
                : glucoseValue // ignore: cast_nullable_to_non_nullable
                      as double,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$AlertHistoryResponseImplCopyWith<$Res>
    implements $AlertHistoryResponseCopyWith<$Res> {
  factory _$$AlertHistoryResponseImplCopyWith(
    _$AlertHistoryResponseImpl value,
    $Res Function(_$AlertHistoryResponseImpl) then,
  ) = __$$AlertHistoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    DateTime triggeredAt,
    double glucoseValue,
    String? message,
    int userId,
  });
}

/// @nodoc
class __$$AlertHistoryResponseImplCopyWithImpl<$Res>
    extends _$AlertHistoryResponseCopyWithImpl<$Res, _$AlertHistoryResponseImpl>
    implements _$$AlertHistoryResponseImplCopyWith<$Res> {
  __$$AlertHistoryResponseImplCopyWithImpl(
    _$AlertHistoryResponseImpl _value,
    $Res Function(_$AlertHistoryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlertHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? triggeredAt = null,
    Object? glucoseValue = null,
    Object? message = freezed,
    Object? userId = null,
  }) {
    return _then(
      _$AlertHistoryResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        triggeredAt: null == triggeredAt
            ? _value.triggeredAt
            : triggeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        glucoseValue: null == glucoseValue
            ? _value.glucoseValue
            : glucoseValue // ignore: cast_nullable_to_non_nullable
                  as double,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$AlertHistoryResponseImpl implements _AlertHistoryResponse {
  const _$AlertHistoryResponseImpl({
    required this.id,
    required this.triggeredAt,
    required this.glucoseValue,
    this.message,
    required this.userId,
  });

  factory _$AlertHistoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertHistoryResponseImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime triggeredAt;
  @override
  final double glucoseValue;
  @override
  final String? message;
  @override
  final int userId;

  @override
  String toString() {
    return 'AlertHistoryResponse(id: $id, triggeredAt: $triggeredAt, glucoseValue: $glucoseValue, message: $message, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertHistoryResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.triggeredAt, triggeredAt) ||
                other.triggeredAt == triggeredAt) &&
            (identical(other.glucoseValue, glucoseValue) ||
                other.glucoseValue == glucoseValue) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, triggeredAt, glucoseValue, message, userId);

  /// Create a copy of AlertHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertHistoryResponseImplCopyWith<_$AlertHistoryResponseImpl>
  get copyWith =>
      __$$AlertHistoryResponseImplCopyWithImpl<_$AlertHistoryResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertHistoryResponseImplToJson(this);
  }
}

abstract class _AlertHistoryResponse implements AlertHistoryResponse {
  const factory _AlertHistoryResponse({
    required final int id,
    required final DateTime triggeredAt,
    required final double glucoseValue,
    final String? message,
    required final int userId,
  }) = _$AlertHistoryResponseImpl;

  factory _AlertHistoryResponse.fromJson(Map<String, dynamic> json) =
      _$AlertHistoryResponseImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get triggeredAt;
  @override
  double get glucoseValue;
  @override
  String? get message;
  @override
  int get userId;

  /// Create a copy of AlertHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertHistoryResponseImplCopyWith<_$AlertHistoryResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
