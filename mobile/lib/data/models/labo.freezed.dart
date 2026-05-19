// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'labo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LaboAnalysis _$LaboAnalysisFromJson(Map<String, dynamic> json) {
  return _LaboAnalysis.fromJson(json);
}

/// @nodoc
mixin _$LaboAnalysis {
  int get id => throw _privateConstructorUsedError;
  double? get hba1c => throw _privateConstructorUsedError;
  double? get cholesterol => throw _privateConstructorUsedError;
  double? get triglycerides => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this LaboAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LaboAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LaboAnalysisCopyWith<LaboAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaboAnalysisCopyWith<$Res> {
  factory $LaboAnalysisCopyWith(
    LaboAnalysis value,
    $Res Function(LaboAnalysis) then,
  ) = _$LaboAnalysisCopyWithImpl<$Res, LaboAnalysis>;
  @useResult
  $Res call({
    int id,
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    DateTime date,
    int userId,
  });
}

/// @nodoc
class _$LaboAnalysisCopyWithImpl<$Res, $Val extends LaboAnalysis>
    implements $LaboAnalysisCopyWith<$Res> {
  _$LaboAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LaboAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hba1c = freezed,
    Object? cholesterol = freezed,
    Object? triglycerides = freezed,
    Object? date = null,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            hba1c: freezed == hba1c
                ? _value.hba1c
                : hba1c // ignore: cast_nullable_to_non_nullable
                      as double?,
            cholesterol: freezed == cholesterol
                ? _value.cholesterol
                : cholesterol // ignore: cast_nullable_to_non_nullable
                      as double?,
            triglycerides: freezed == triglycerides
                ? _value.triglycerides
                : triglycerides // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$LaboAnalysisImplCopyWith<$Res>
    implements $LaboAnalysisCopyWith<$Res> {
  factory _$$LaboAnalysisImplCopyWith(
    _$LaboAnalysisImpl value,
    $Res Function(_$LaboAnalysisImpl) then,
  ) = __$$LaboAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    DateTime date,
    int userId,
  });
}

/// @nodoc
class __$$LaboAnalysisImplCopyWithImpl<$Res>
    extends _$LaboAnalysisCopyWithImpl<$Res, _$LaboAnalysisImpl>
    implements _$$LaboAnalysisImplCopyWith<$Res> {
  __$$LaboAnalysisImplCopyWithImpl(
    _$LaboAnalysisImpl _value,
    $Res Function(_$LaboAnalysisImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LaboAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hba1c = freezed,
    Object? cholesterol = freezed,
    Object? triglycerides = freezed,
    Object? date = null,
    Object? userId = null,
  }) {
    return _then(
      _$LaboAnalysisImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        hba1c: freezed == hba1c
            ? _value.hba1c
            : hba1c // ignore: cast_nullable_to_non_nullable
                  as double?,
        cholesterol: freezed == cholesterol
            ? _value.cholesterol
            : cholesterol // ignore: cast_nullable_to_non_nullable
                  as double?,
        triglycerides: freezed == triglycerides
            ? _value.triglycerides
            : triglycerides // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$LaboAnalysisImpl implements _LaboAnalysis {
  const _$LaboAnalysisImpl({
    required this.id,
    this.hba1c,
    this.cholesterol,
    this.triglycerides,
    required this.date,
    required this.userId,
  });

  factory _$LaboAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaboAnalysisImplFromJson(json);

  @override
  final int id;
  @override
  final double? hba1c;
  @override
  final double? cholesterol;
  @override
  final double? triglycerides;
  @override
  final DateTime date;
  @override
  final int userId;

  @override
  String toString() {
    return 'LaboAnalysis(id: $id, hba1c: $hba1c, cholesterol: $cholesterol, triglycerides: $triglycerides, date: $date, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaboAnalysisImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hba1c, hba1c) || other.hba1c == hba1c) &&
            (identical(other.cholesterol, cholesterol) ||
                other.cholesterol == cholesterol) &&
            (identical(other.triglycerides, triglycerides) ||
                other.triglycerides == triglycerides) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    hba1c,
    cholesterol,
    triglycerides,
    date,
    userId,
  );

  /// Create a copy of LaboAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LaboAnalysisImplCopyWith<_$LaboAnalysisImpl> get copyWith =>
      __$$LaboAnalysisImplCopyWithImpl<_$LaboAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaboAnalysisImplToJson(this);
  }
}

abstract class _LaboAnalysis implements LaboAnalysis {
  const factory _LaboAnalysis({
    required final int id,
    final double? hba1c,
    final double? cholesterol,
    final double? triglycerides,
    required final DateTime date,
    required final int userId,
  }) = _$LaboAnalysisImpl;

  factory _LaboAnalysis.fromJson(Map<String, dynamic> json) =
      _$LaboAnalysisImpl.fromJson;

  @override
  int get id;
  @override
  double? get hba1c;
  @override
  double? get cholesterol;
  @override
  double? get triglycerides;
  @override
  DateTime get date;
  @override
  int get userId;

  /// Create a copy of LaboAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LaboAnalysisImplCopyWith<_$LaboAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LaboAnalysisRequest _$LaboAnalysisRequestFromJson(Map<String, dynamic> json) {
  return _LaboAnalysisRequest.fromJson(json);
}

/// @nodoc
mixin _$LaboAnalysisRequest {
  double? get hba1c => throw _privateConstructorUsedError;
  double? get cholesterol => throw _privateConstructorUsedError;
  double? get triglycerides => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Serializes this LaboAnalysisRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LaboAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LaboAnalysisRequestCopyWith<LaboAnalysisRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaboAnalysisRequestCopyWith<$Res> {
  factory $LaboAnalysisRequestCopyWith(
    LaboAnalysisRequest value,
    $Res Function(LaboAnalysisRequest) then,
  ) = _$LaboAnalysisRequestCopyWithImpl<$Res, LaboAnalysisRequest>;
  @useResult
  $Res call({
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    DateTime date,
  });
}

/// @nodoc
class _$LaboAnalysisRequestCopyWithImpl<$Res, $Val extends LaboAnalysisRequest>
    implements $LaboAnalysisRequestCopyWith<$Res> {
  _$LaboAnalysisRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LaboAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hba1c = freezed,
    Object? cholesterol = freezed,
    Object? triglycerides = freezed,
    Object? date = null,
  }) {
    return _then(
      _value.copyWith(
            hba1c: freezed == hba1c
                ? _value.hba1c
                : hba1c // ignore: cast_nullable_to_non_nullable
                      as double?,
            cholesterol: freezed == cholesterol
                ? _value.cholesterol
                : cholesterol // ignore: cast_nullable_to_non_nullable
                      as double?,
            triglycerides: freezed == triglycerides
                ? _value.triglycerides
                : triglycerides // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$LaboAnalysisRequestImplCopyWith<$Res>
    implements $LaboAnalysisRequestCopyWith<$Res> {
  factory _$$LaboAnalysisRequestImplCopyWith(
    _$LaboAnalysisRequestImpl value,
    $Res Function(_$LaboAnalysisRequestImpl) then,
  ) = __$$LaboAnalysisRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    DateTime date,
  });
}

/// @nodoc
class __$$LaboAnalysisRequestImplCopyWithImpl<$Res>
    extends _$LaboAnalysisRequestCopyWithImpl<$Res, _$LaboAnalysisRequestImpl>
    implements _$$LaboAnalysisRequestImplCopyWith<$Res> {
  __$$LaboAnalysisRequestImplCopyWithImpl(
    _$LaboAnalysisRequestImpl _value,
    $Res Function(_$LaboAnalysisRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LaboAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hba1c = freezed,
    Object? cholesterol = freezed,
    Object? triglycerides = freezed,
    Object? date = null,
  }) {
    return _then(
      _$LaboAnalysisRequestImpl(
        hba1c: freezed == hba1c
            ? _value.hba1c
            : hba1c // ignore: cast_nullable_to_non_nullable
                  as double?,
        cholesterol: freezed == cholesterol
            ? _value.cholesterol
            : cholesterol // ignore: cast_nullable_to_non_nullable
                  as double?,
        triglycerides: freezed == triglycerides
            ? _value.triglycerides
            : triglycerides // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$LaboAnalysisRequestImpl implements _LaboAnalysisRequest {
  const _$LaboAnalysisRequestImpl({
    this.hba1c,
    this.cholesterol,
    this.triglycerides,
    required this.date,
  });

  factory _$LaboAnalysisRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaboAnalysisRequestImplFromJson(json);

  @override
  final double? hba1c;
  @override
  final double? cholesterol;
  @override
  final double? triglycerides;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'LaboAnalysisRequest(hba1c: $hba1c, cholesterol: $cholesterol, triglycerides: $triglycerides, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaboAnalysisRequestImpl &&
            (identical(other.hba1c, hba1c) || other.hba1c == hba1c) &&
            (identical(other.cholesterol, cholesterol) ||
                other.cholesterol == cholesterol) &&
            (identical(other.triglycerides, triglycerides) ||
                other.triglycerides == triglycerides) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hba1c, cholesterol, triglycerides, date);

  /// Create a copy of LaboAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LaboAnalysisRequestImplCopyWith<_$LaboAnalysisRequestImpl> get copyWith =>
      __$$LaboAnalysisRequestImplCopyWithImpl<_$LaboAnalysisRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LaboAnalysisRequestImplToJson(this);
  }
}

abstract class _LaboAnalysisRequest implements LaboAnalysisRequest {
  const factory _LaboAnalysisRequest({
    final double? hba1c,
    final double? cholesterol,
    final double? triglycerides,
    required final DateTime date,
  }) = _$LaboAnalysisRequestImpl;

  factory _LaboAnalysisRequest.fromJson(Map<String, dynamic> json) =
      _$LaboAnalysisRequestImpl.fromJson;

  @override
  double? get hba1c;
  @override
  double? get cholesterol;
  @override
  double? get triglycerides;
  @override
  DateTime get date;

  /// Create a copy of LaboAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LaboAnalysisRequestImplCopyWith<_$LaboAnalysisRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LaboAnalysisResponse _$LaboAnalysisResponseFromJson(Map<String, dynamic> json) {
  return _LaboAnalysisResponse.fromJson(json);
}

/// @nodoc
mixin _$LaboAnalysisResponse {
  int get id => throw _privateConstructorUsedError;
  double? get hba1c => throw _privateConstructorUsedError;
  double? get cholesterol => throw _privateConstructorUsedError;
  double? get triglycerides => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this LaboAnalysisResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LaboAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LaboAnalysisResponseCopyWith<LaboAnalysisResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaboAnalysisResponseCopyWith<$Res> {
  factory $LaboAnalysisResponseCopyWith(
    LaboAnalysisResponse value,
    $Res Function(LaboAnalysisResponse) then,
  ) = _$LaboAnalysisResponseCopyWithImpl<$Res, LaboAnalysisResponse>;
  @useResult
  $Res call({
    int id,
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    DateTime date,
    int userId,
  });
}

/// @nodoc
class _$LaboAnalysisResponseCopyWithImpl<
  $Res,
  $Val extends LaboAnalysisResponse
>
    implements $LaboAnalysisResponseCopyWith<$Res> {
  _$LaboAnalysisResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LaboAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hba1c = freezed,
    Object? cholesterol = freezed,
    Object? triglycerides = freezed,
    Object? date = null,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            hba1c: freezed == hba1c
                ? _value.hba1c
                : hba1c // ignore: cast_nullable_to_non_nullable
                      as double?,
            cholesterol: freezed == cholesterol
                ? _value.cholesterol
                : cholesterol // ignore: cast_nullable_to_non_nullable
                      as double?,
            triglycerides: freezed == triglycerides
                ? _value.triglycerides
                : triglycerides // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$LaboAnalysisResponseImplCopyWith<$Res>
    implements $LaboAnalysisResponseCopyWith<$Res> {
  factory _$$LaboAnalysisResponseImplCopyWith(
    _$LaboAnalysisResponseImpl value,
    $Res Function(_$LaboAnalysisResponseImpl) then,
  ) = __$$LaboAnalysisResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double? hba1c,
    double? cholesterol,
    double? triglycerides,
    DateTime date,
    int userId,
  });
}

/// @nodoc
class __$$LaboAnalysisResponseImplCopyWithImpl<$Res>
    extends _$LaboAnalysisResponseCopyWithImpl<$Res, _$LaboAnalysisResponseImpl>
    implements _$$LaboAnalysisResponseImplCopyWith<$Res> {
  __$$LaboAnalysisResponseImplCopyWithImpl(
    _$LaboAnalysisResponseImpl _value,
    $Res Function(_$LaboAnalysisResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LaboAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hba1c = freezed,
    Object? cholesterol = freezed,
    Object? triglycerides = freezed,
    Object? date = null,
    Object? userId = null,
  }) {
    return _then(
      _$LaboAnalysisResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        hba1c: freezed == hba1c
            ? _value.hba1c
            : hba1c // ignore: cast_nullable_to_non_nullable
                  as double?,
        cholesterol: freezed == cholesterol
            ? _value.cholesterol
            : cholesterol // ignore: cast_nullable_to_non_nullable
                  as double?,
        triglycerides: freezed == triglycerides
            ? _value.triglycerides
            : triglycerides // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$LaboAnalysisResponseImpl implements _LaboAnalysisResponse {
  const _$LaboAnalysisResponseImpl({
    required this.id,
    this.hba1c,
    this.cholesterol,
    this.triglycerides,
    required this.date,
    required this.userId,
  });

  factory _$LaboAnalysisResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaboAnalysisResponseImplFromJson(json);

  @override
  final int id;
  @override
  final double? hba1c;
  @override
  final double? cholesterol;
  @override
  final double? triglycerides;
  @override
  final DateTime date;
  @override
  final int userId;

  @override
  String toString() {
    return 'LaboAnalysisResponse(id: $id, hba1c: $hba1c, cholesterol: $cholesterol, triglycerides: $triglycerides, date: $date, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaboAnalysisResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hba1c, hba1c) || other.hba1c == hba1c) &&
            (identical(other.cholesterol, cholesterol) ||
                other.cholesterol == cholesterol) &&
            (identical(other.triglycerides, triglycerides) ||
                other.triglycerides == triglycerides) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    hba1c,
    cholesterol,
    triglycerides,
    date,
    userId,
  );

  /// Create a copy of LaboAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LaboAnalysisResponseImplCopyWith<_$LaboAnalysisResponseImpl>
  get copyWith =>
      __$$LaboAnalysisResponseImplCopyWithImpl<_$LaboAnalysisResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LaboAnalysisResponseImplToJson(this);
  }
}

abstract class _LaboAnalysisResponse implements LaboAnalysisResponse {
  const factory _LaboAnalysisResponse({
    required final int id,
    final double? hba1c,
    final double? cholesterol,
    final double? triglycerides,
    required final DateTime date,
    required final int userId,
  }) = _$LaboAnalysisResponseImpl;

  factory _LaboAnalysisResponse.fromJson(Map<String, dynamic> json) =
      _$LaboAnalysisResponseImpl.fromJson;

  @override
  int get id;
  @override
  double? get hba1c;
  @override
  double? get cholesterol;
  @override
  double? get triglycerides;
  @override
  DateTime get date;
  @override
  int get userId;

  /// Create a copy of LaboAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LaboAnalysisResponseImplCopyWith<_$LaboAnalysisResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
