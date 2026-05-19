// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'juggluco.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

JugglucoReading _$JugglucoReadingFromJson(Map<String, dynamic> json) {
  return _JugglucoReading.fromJson(json);
}

/// @nodoc
mixin _$JugglucoReading {
  String? get sensorId => throw _privateConstructorUsedError;
  int? get nr => throw _privateConstructorUsedError;
  @JsonKey(name: 'unixTime')
  int? get unixTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'timestamp')
  String? get timestamp => throw _privateConstructorUsedError;
  int? get tz => throw _privateConstructorUsedError;
  int? get min => throw _privateConstructorUsedError;
  @JsonKey(name: 'mg/dL')
  int? get mgDl => throw _privateConstructorUsedError;
  double? get rate => throw _privateConstructorUsedError;
  String? get changeLabel => throw _privateConstructorUsedError;

  /// Serializes this JugglucoReading to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JugglucoReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JugglucoReadingCopyWith<JugglucoReading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JugglucoReadingCopyWith<$Res> {
  factory $JugglucoReadingCopyWith(
    JugglucoReading value,
    $Res Function(JugglucoReading) then,
  ) = _$JugglucoReadingCopyWithImpl<$Res, JugglucoReading>;
  @useResult
  $Res call({
    String? sensorId,
    int? nr,
    @JsonKey(name: 'unixTime') int? unixTime,
    @JsonKey(name: 'timestamp') String? timestamp,
    int? tz,
    int? min,
    @JsonKey(name: 'mg/dL') int? mgDl,
    double? rate,
    String? changeLabel,
  });
}

/// @nodoc
class _$JugglucoReadingCopyWithImpl<$Res, $Val extends JugglucoReading>
    implements $JugglucoReadingCopyWith<$Res> {
  _$JugglucoReadingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JugglucoReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sensorId = freezed,
    Object? nr = freezed,
    Object? unixTime = freezed,
    Object? timestamp = freezed,
    Object? tz = freezed,
    Object? min = freezed,
    Object? mgDl = freezed,
    Object? rate = freezed,
    Object? changeLabel = freezed,
  }) {
    return _then(
      _value.copyWith(
            sensorId: freezed == sensorId
                ? _value.sensorId
                : sensorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            nr: freezed == nr
                ? _value.nr
                : nr // ignore: cast_nullable_to_non_nullable
                      as int?,
            unixTime: freezed == unixTime
                ? _value.unixTime
                : unixTime // ignore: cast_nullable_to_non_nullable
                      as int?,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String?,
            tz: freezed == tz
                ? _value.tz
                : tz // ignore: cast_nullable_to_non_nullable
                      as int?,
            min: freezed == min
                ? _value.min
                : min // ignore: cast_nullable_to_non_nullable
                      as int?,
            mgDl: freezed == mgDl
                ? _value.mgDl
                : mgDl // ignore: cast_nullable_to_non_nullable
                      as int?,
            rate: freezed == rate
                ? _value.rate
                : rate // ignore: cast_nullable_to_non_nullable
                      as double?,
            changeLabel: freezed == changeLabel
                ? _value.changeLabel
                : changeLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JugglucoReadingImplCopyWith<$Res>
    implements $JugglucoReadingCopyWith<$Res> {
  factory _$$JugglucoReadingImplCopyWith(
    _$JugglucoReadingImpl value,
    $Res Function(_$JugglucoReadingImpl) then,
  ) = __$$JugglucoReadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? sensorId,
    int? nr,
    @JsonKey(name: 'unixTime') int? unixTime,
    @JsonKey(name: 'timestamp') String? timestamp,
    int? tz,
    int? min,
    @JsonKey(name: 'mg/dL') int? mgDl,
    double? rate,
    String? changeLabel,
  });
}

/// @nodoc
class __$$JugglucoReadingImplCopyWithImpl<$Res>
    extends _$JugglucoReadingCopyWithImpl<$Res, _$JugglucoReadingImpl>
    implements _$$JugglucoReadingImplCopyWith<$Res> {
  __$$JugglucoReadingImplCopyWithImpl(
    _$JugglucoReadingImpl _value,
    $Res Function(_$JugglucoReadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JugglucoReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sensorId = freezed,
    Object? nr = freezed,
    Object? unixTime = freezed,
    Object? timestamp = freezed,
    Object? tz = freezed,
    Object? min = freezed,
    Object? mgDl = freezed,
    Object? rate = freezed,
    Object? changeLabel = freezed,
  }) {
    return _then(
      _$JugglucoReadingImpl(
        sensorId: freezed == sensorId
            ? _value.sensorId
            : sensorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        nr: freezed == nr
            ? _value.nr
            : nr // ignore: cast_nullable_to_non_nullable
                  as int?,
        unixTime: freezed == unixTime
            ? _value.unixTime
            : unixTime // ignore: cast_nullable_to_non_nullable
                  as int?,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String?,
        tz: freezed == tz
            ? _value.tz
            : tz // ignore: cast_nullable_to_non_nullable
                  as int?,
        min: freezed == min
            ? _value.min
            : min // ignore: cast_nullable_to_non_nullable
                  as int?,
        mgDl: freezed == mgDl
            ? _value.mgDl
            : mgDl // ignore: cast_nullable_to_non_nullable
                  as int?,
        rate: freezed == rate
            ? _value.rate
            : rate // ignore: cast_nullable_to_non_nullable
                  as double?,
        changeLabel: freezed == changeLabel
            ? _value.changeLabel
            : changeLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JugglucoReadingImpl extends _JugglucoReading {
  const _$JugglucoReadingImpl({
    this.sensorId,
    this.nr,
    @JsonKey(name: 'unixTime') this.unixTime,
    @JsonKey(name: 'timestamp') this.timestamp,
    this.tz,
    this.min,
    @JsonKey(name: 'mg/dL') this.mgDl,
    this.rate,
    this.changeLabel,
  }) : super._();

  factory _$JugglucoReadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$JugglucoReadingImplFromJson(json);

  @override
  final String? sensorId;
  @override
  final int? nr;
  @override
  @JsonKey(name: 'unixTime')
  final int? unixTime;
  @override
  @JsonKey(name: 'timestamp')
  final String? timestamp;
  @override
  final int? tz;
  @override
  final int? min;
  @override
  @JsonKey(name: 'mg/dL')
  final int? mgDl;
  @override
  final double? rate;
  @override
  final String? changeLabel;

  @override
  String toString() {
    return 'JugglucoReading(sensorId: $sensorId, nr: $nr, unixTime: $unixTime, timestamp: $timestamp, tz: $tz, min: $min, mgDl: $mgDl, rate: $rate, changeLabel: $changeLabel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JugglucoReadingImpl &&
            (identical(other.sensorId, sensorId) ||
                other.sensorId == sensorId) &&
            (identical(other.nr, nr) || other.nr == nr) &&
            (identical(other.unixTime, unixTime) ||
                other.unixTime == unixTime) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.tz, tz) || other.tz == tz) &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.mgDl, mgDl) || other.mgDl == mgDl) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.changeLabel, changeLabel) ||
                other.changeLabel == changeLabel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sensorId,
    nr,
    unixTime,
    timestamp,
    tz,
    min,
    mgDl,
    rate,
    changeLabel,
  );

  /// Create a copy of JugglucoReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JugglucoReadingImplCopyWith<_$JugglucoReadingImpl> get copyWith =>
      __$$JugglucoReadingImplCopyWithImpl<_$JugglucoReadingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$JugglucoReadingImplToJson(this);
  }
}

abstract class _JugglucoReading extends JugglucoReading {
  const factory _JugglucoReading({
    final String? sensorId,
    final int? nr,
    @JsonKey(name: 'unixTime') final int? unixTime,
    @JsonKey(name: 'timestamp') final String? timestamp,
    final int? tz,
    final int? min,
    @JsonKey(name: 'mg/dL') final int? mgDl,
    final double? rate,
    final String? changeLabel,
  }) = _$JugglucoReadingImpl;
  const _JugglucoReading._() : super._();

  factory _JugglucoReading.fromJson(Map<String, dynamic> json) =
      _$JugglucoReadingImpl.fromJson;

  @override
  String? get sensorId;
  @override
  int? get nr;
  @override
  @JsonKey(name: 'unixTime')
  int? get unixTime;
  @override
  @JsonKey(name: 'timestamp')
  String? get timestamp;
  @override
  int? get tz;
  @override
  int? get min;
  @override
  @JsonKey(name: 'mg/dL')
  int? get mgDl;
  @override
  double? get rate;
  @override
  String? get changeLabel;

  /// Create a copy of JugglucoReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JugglucoReadingImplCopyWith<_$JugglucoReadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JugglucoGlucose _$JugglucoGlucoseFromJson(Map<String, dynamic> json) {
  return _JugglucoGlucose.fromJson(json);
}

/// @nodoc
mixin _$JugglucoGlucose {
  int get glucose => throw _privateConstructorUsedError;
  String? get direction => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double? get rate => throw _privateConstructorUsedError;
  String? get changeLabel => throw _privateConstructorUsedError;
  bool? get isConnected => throw _privateConstructorUsedError;

  /// Serializes this JugglucoGlucose to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JugglucoGlucose
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JugglucoGlucoseCopyWith<JugglucoGlucose> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JugglucoGlucoseCopyWith<$Res> {
  factory $JugglucoGlucoseCopyWith(
    JugglucoGlucose value,
    $Res Function(JugglucoGlucose) then,
  ) = _$JugglucoGlucoseCopyWithImpl<$Res, JugglucoGlucose>;
  @useResult
  $Res call({
    int glucose,
    String? direction,
    DateTime timestamp,
    double? rate,
    String? changeLabel,
    bool? isConnected,
  });
}

/// @nodoc
class _$JugglucoGlucoseCopyWithImpl<$Res, $Val extends JugglucoGlucose>
    implements $JugglucoGlucoseCopyWith<$Res> {
  _$JugglucoGlucoseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JugglucoGlucose
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? glucose = null,
    Object? direction = freezed,
    Object? timestamp = null,
    Object? rate = freezed,
    Object? changeLabel = freezed,
    Object? isConnected = freezed,
  }) {
    return _then(
      _value.copyWith(
            glucose: null == glucose
                ? _value.glucose
                : glucose // ignore: cast_nullable_to_non_nullable
                      as int,
            direction: freezed == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            rate: freezed == rate
                ? _value.rate
                : rate // ignore: cast_nullable_to_non_nullable
                      as double?,
            changeLabel: freezed == changeLabel
                ? _value.changeLabel
                : changeLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            isConnected: freezed == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JugglucoGlucoseImplCopyWith<$Res>
    implements $JugglucoGlucoseCopyWith<$Res> {
  factory _$$JugglucoGlucoseImplCopyWith(
    _$JugglucoGlucoseImpl value,
    $Res Function(_$JugglucoGlucoseImpl) then,
  ) = __$$JugglucoGlucoseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int glucose,
    String? direction,
    DateTime timestamp,
    double? rate,
    String? changeLabel,
    bool? isConnected,
  });
}

/// @nodoc
class __$$JugglucoGlucoseImplCopyWithImpl<$Res>
    extends _$JugglucoGlucoseCopyWithImpl<$Res, _$JugglucoGlucoseImpl>
    implements _$$JugglucoGlucoseImplCopyWith<$Res> {
  __$$JugglucoGlucoseImplCopyWithImpl(
    _$JugglucoGlucoseImpl _value,
    $Res Function(_$JugglucoGlucoseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JugglucoGlucose
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? glucose = null,
    Object? direction = freezed,
    Object? timestamp = null,
    Object? rate = freezed,
    Object? changeLabel = freezed,
    Object? isConnected = freezed,
  }) {
    return _then(
      _$JugglucoGlucoseImpl(
        glucose: null == glucose
            ? _value.glucose
            : glucose // ignore: cast_nullable_to_non_nullable
                  as int,
        direction: freezed == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        rate: freezed == rate
            ? _value.rate
            : rate // ignore: cast_nullable_to_non_nullable
                  as double?,
        changeLabel: freezed == changeLabel
            ? _value.changeLabel
            : changeLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        isConnected: freezed == isConnected
            ? _value.isConnected
            : isConnected // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JugglucoGlucoseImpl implements _JugglucoGlucose {
  const _$JugglucoGlucoseImpl({
    required this.glucose,
    this.direction,
    required this.timestamp,
    this.rate,
    this.changeLabel,
    this.isConnected,
  });

  factory _$JugglucoGlucoseImpl.fromJson(Map<String, dynamic> json) =>
      _$$JugglucoGlucoseImplFromJson(json);

  @override
  final int glucose;
  @override
  final String? direction;
  @override
  final DateTime timestamp;
  @override
  final double? rate;
  @override
  final String? changeLabel;
  @override
  final bool? isConnected;

  @override
  String toString() {
    return 'JugglucoGlucose(glucose: $glucose, direction: $direction, timestamp: $timestamp, rate: $rate, changeLabel: $changeLabel, isConnected: $isConnected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JugglucoGlucoseImpl &&
            (identical(other.glucose, glucose) || other.glucose == glucose) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.changeLabel, changeLabel) ||
                other.changeLabel == changeLabel) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    glucose,
    direction,
    timestamp,
    rate,
    changeLabel,
    isConnected,
  );

  /// Create a copy of JugglucoGlucose
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JugglucoGlucoseImplCopyWith<_$JugglucoGlucoseImpl> get copyWith =>
      __$$JugglucoGlucoseImplCopyWithImpl<_$JugglucoGlucoseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$JugglucoGlucoseImplToJson(this);
  }
}

abstract class _JugglucoGlucose implements JugglucoGlucose {
  const factory _JugglucoGlucose({
    required final int glucose,
    final String? direction,
    required final DateTime timestamp,
    final double? rate,
    final String? changeLabel,
    final bool? isConnected,
  }) = _$JugglucoGlucoseImpl;

  factory _JugglucoGlucose.fromJson(Map<String, dynamic> json) =
      _$JugglucoGlucoseImpl.fromJson;

  @override
  int get glucose;
  @override
  String? get direction;
  @override
  DateTime get timestamp;
  @override
  double? get rate;
  @override
  String? get changeLabel;
  @override
  bool? get isConnected;

  /// Create a copy of JugglucoGlucose
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JugglucoGlucoseImplCopyWith<_$JugglucoGlucoseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
