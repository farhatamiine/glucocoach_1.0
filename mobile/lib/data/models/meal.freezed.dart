// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MealAnalysisResult _$MealAnalysisResultFromJson(Map<String, dynamic> json) {
  return _MealAnalysisResult.fromJson(json);
}

/// @nodoc
mixin _$MealAnalysisResult {
  String? get name => throw _privateConstructorUsedError;
  double? get estimatedCarbs => throw _privateConstructorUsedError;
  List<String>? get ingredients => throw _privateConstructorUsedError;
  String? get confidence => throw _privateConstructorUsedError;

  /// Serializes this MealAnalysisResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealAnalysisResultCopyWith<MealAnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealAnalysisResultCopyWith<$Res> {
  factory $MealAnalysisResultCopyWith(
    MealAnalysisResult value,
    $Res Function(MealAnalysisResult) then,
  ) = _$MealAnalysisResultCopyWithImpl<$Res, MealAnalysisResult>;
  @useResult
  $Res call({
    String? name,
    double? estimatedCarbs,
    List<String>? ingredients,
    String? confidence,
  });
}

/// @nodoc
class _$MealAnalysisResultCopyWithImpl<$Res, $Val extends MealAnalysisResult>
    implements $MealAnalysisResultCopyWith<$Res> {
  _$MealAnalysisResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? estimatedCarbs = freezed,
    Object? ingredients = freezed,
    Object? confidence = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            estimatedCarbs: freezed == estimatedCarbs
                ? _value.estimatedCarbs
                : estimatedCarbs // ignore: cast_nullable_to_non_nullable
                      as double?,
            ingredients: freezed == ingredients
                ? _value.ingredients
                : ingredients // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            confidence: freezed == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MealAnalysisResultImplCopyWith<$Res>
    implements $MealAnalysisResultCopyWith<$Res> {
  factory _$$MealAnalysisResultImplCopyWith(
    _$MealAnalysisResultImpl value,
    $Res Function(_$MealAnalysisResultImpl) then,
  ) = __$$MealAnalysisResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? name,
    double? estimatedCarbs,
    List<String>? ingredients,
    String? confidence,
  });
}

/// @nodoc
class __$$MealAnalysisResultImplCopyWithImpl<$Res>
    extends _$MealAnalysisResultCopyWithImpl<$Res, _$MealAnalysisResultImpl>
    implements _$$MealAnalysisResultImplCopyWith<$Res> {
  __$$MealAnalysisResultImplCopyWithImpl(
    _$MealAnalysisResultImpl _value,
    $Res Function(_$MealAnalysisResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? estimatedCarbs = freezed,
    Object? ingredients = freezed,
    Object? confidence = freezed,
  }) {
    return _then(
      _$MealAnalysisResultImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        estimatedCarbs: freezed == estimatedCarbs
            ? _value.estimatedCarbs
            : estimatedCarbs // ignore: cast_nullable_to_non_nullable
                  as double?,
        ingredients: freezed == ingredients
            ? _value._ingredients
            : ingredients // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        confidence: freezed == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealAnalysisResultImpl implements _MealAnalysisResult {
  const _$MealAnalysisResultImpl({
    this.name,
    this.estimatedCarbs,
    final List<String>? ingredients,
    this.confidence,
  }) : _ingredients = ingredients;

  factory _$MealAnalysisResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealAnalysisResultImplFromJson(json);

  @override
  final String? name;
  @override
  final double? estimatedCarbs;
  final List<String>? _ingredients;
  @override
  List<String>? get ingredients {
    final value = _ingredients;
    if (value == null) return null;
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? confidence;

  @override
  String toString() {
    return 'MealAnalysisResult(name: $name, estimatedCarbs: $estimatedCarbs, ingredients: $ingredients, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealAnalysisResultImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.estimatedCarbs, estimatedCarbs) ||
                other.estimatedCarbs == estimatedCarbs) &&
            const DeepCollectionEquality().equals(
              other._ingredients,
              _ingredients,
            ) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    estimatedCarbs,
    const DeepCollectionEquality().hash(_ingredients),
    confidence,
  );

  /// Create a copy of MealAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealAnalysisResultImplCopyWith<_$MealAnalysisResultImpl> get copyWith =>
      __$$MealAnalysisResultImplCopyWithImpl<_$MealAnalysisResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MealAnalysisResultImplToJson(this);
  }
}

abstract class _MealAnalysisResult implements MealAnalysisResult {
  const factory _MealAnalysisResult({
    final String? name,
    final double? estimatedCarbs,
    final List<String>? ingredients,
    final String? confidence,
  }) = _$MealAnalysisResultImpl;

  factory _MealAnalysisResult.fromJson(Map<String, dynamic> json) =
      _$MealAnalysisResultImpl.fromJson;

  @override
  String? get name;
  @override
  double? get estimatedCarbs;
  @override
  List<String>? get ingredients;
  @override
  String? get confidence;

  /// Create a copy of MealAnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealAnalysisResultImplCopyWith<_$MealAnalysisResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Meal _$MealFromJson(Map<String, dynamic> json) {
  return _Meal.fromJson(json);
}

/// @nodoc
mixin _$Meal {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get carbs => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  MealAnalysisResult? get analysis => throw _privateConstructorUsedError;
  double? get estimatedCarbs => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Meal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealCopyWith<Meal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealCopyWith<$Res> {
  factory $MealCopyWith(Meal value, $Res Function(Meal) then) =
      _$MealCopyWithImpl<$Res, Meal>;
  @useResult
  $Res call({
    int id,
    String name,
    double carbs,
    DateTime timestamp,
    int userId,
    MealAnalysisResult? analysis,
    double? estimatedCarbs,
    String? imageUrl,
  });

  $MealAnalysisResultCopyWith<$Res>? get analysis;
}

/// @nodoc
class _$MealCopyWithImpl<$Res, $Val extends Meal>
    implements $MealCopyWith<$Res> {
  _$MealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? carbs = null,
    Object? timestamp = null,
    Object? userId = null,
    Object? analysis = freezed,
    Object? estimatedCarbs = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            carbs: null == carbs
                ? _value.carbs
                : carbs // ignore: cast_nullable_to_non_nullable
                      as double,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            analysis: freezed == analysis
                ? _value.analysis
                : analysis // ignore: cast_nullable_to_non_nullable
                      as MealAnalysisResult?,
            estimatedCarbs: freezed == estimatedCarbs
                ? _value.estimatedCarbs
                : estimatedCarbs // ignore: cast_nullable_to_non_nullable
                      as double?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealAnalysisResultCopyWith<$Res>? get analysis {
    if (_value.analysis == null) {
      return null;
    }

    return $MealAnalysisResultCopyWith<$Res>(_value.analysis!, (value) {
      return _then(_value.copyWith(analysis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealImplCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$$MealImplCopyWith(
    _$MealImpl value,
    $Res Function(_$MealImpl) then,
  ) = __$$MealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    double carbs,
    DateTime timestamp,
    int userId,
    MealAnalysisResult? analysis,
    double? estimatedCarbs,
    String? imageUrl,
  });

  @override
  $MealAnalysisResultCopyWith<$Res>? get analysis;
}

/// @nodoc
class __$$MealImplCopyWithImpl<$Res>
    extends _$MealCopyWithImpl<$Res, _$MealImpl>
    implements _$$MealImplCopyWith<$Res> {
  __$$MealImplCopyWithImpl(_$MealImpl _value, $Res Function(_$MealImpl) _then)
    : super(_value, _then);

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? carbs = null,
    Object? timestamp = null,
    Object? userId = null,
    Object? analysis = freezed,
    Object? estimatedCarbs = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$MealImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        carbs: null == carbs
            ? _value.carbs
            : carbs // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        analysis: freezed == analysis
            ? _value.analysis
            : analysis // ignore: cast_nullable_to_non_nullable
                  as MealAnalysisResult?,
        estimatedCarbs: freezed == estimatedCarbs
            ? _value.estimatedCarbs
            : estimatedCarbs // ignore: cast_nullable_to_non_nullable
                  as double?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealImpl implements _Meal {
  const _$MealImpl({
    required this.id,
    required this.name,
    required this.carbs,
    required this.timestamp,
    required this.userId,
    this.analysis,
    this.estimatedCarbs,
    this.imageUrl,
  });

  factory _$MealImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final double carbs;
  @override
  final DateTime timestamp;
  @override
  final int userId;
  @override
  final MealAnalysisResult? analysis;
  @override
  final double? estimatedCarbs;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'Meal(id: $id, name: $name, carbs: $carbs, timestamp: $timestamp, userId: $userId, analysis: $analysis, estimatedCarbs: $estimatedCarbs, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis) &&
            (identical(other.estimatedCarbs, estimatedCarbs) ||
                other.estimatedCarbs == estimatedCarbs) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    carbs,
    timestamp,
    userId,
    analysis,
    estimatedCarbs,
    imageUrl,
  );

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealImplCopyWith<_$MealImpl> get copyWith =>
      __$$MealImplCopyWithImpl<_$MealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealImplToJson(this);
  }
}

abstract class _Meal implements Meal {
  const factory _Meal({
    required final int id,
    required final String name,
    required final double carbs,
    required final DateTime timestamp,
    required final int userId,
    final MealAnalysisResult? analysis,
    final double? estimatedCarbs,
    final String? imageUrl,
  }) = _$MealImpl;

  factory _Meal.fromJson(Map<String, dynamic> json) = _$MealImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  double get carbs;
  @override
  DateTime get timestamp;
  @override
  int get userId;
  @override
  MealAnalysisResult? get analysis;
  @override
  double? get estimatedCarbs;
  @override
  String? get imageUrl;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealImplCopyWith<_$MealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealRequest _$MealRequestFromJson(Map<String, dynamic> json) {
  return _MealRequest.fromJson(json);
}

/// @nodoc
mixin _$MealRequest {
  String get name => throw _privateConstructorUsedError;
  double get carbs => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MealRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealRequestCopyWith<MealRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealRequestCopyWith<$Res> {
  factory $MealRequestCopyWith(
    MealRequest value,
    $Res Function(MealRequest) then,
  ) = _$MealRequestCopyWithImpl<$Res, MealRequest>;
  @useResult
  $Res call({String name, double carbs, DateTime timestamp});
}

/// @nodoc
class _$MealRequestCopyWithImpl<$Res, $Val extends MealRequest>
    implements $MealRequestCopyWith<$Res> {
  _$MealRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? carbs = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            carbs: null == carbs
                ? _value.carbs
                : carbs // ignore: cast_nullable_to_non_nullable
                      as double,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MealRequestImplCopyWith<$Res>
    implements $MealRequestCopyWith<$Res> {
  factory _$$MealRequestImplCopyWith(
    _$MealRequestImpl value,
    $Res Function(_$MealRequestImpl) then,
  ) = __$$MealRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double carbs, DateTime timestamp});
}

/// @nodoc
class __$$MealRequestImplCopyWithImpl<$Res>
    extends _$MealRequestCopyWithImpl<$Res, _$MealRequestImpl>
    implements _$$MealRequestImplCopyWith<$Res> {
  __$$MealRequestImplCopyWithImpl(
    _$MealRequestImpl _value,
    $Res Function(_$MealRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? carbs = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$MealRequestImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        carbs: null == carbs
            ? _value.carbs
            : carbs // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealRequestImpl implements _MealRequest {
  const _$MealRequestImpl({
    required this.name,
    required this.carbs,
    required this.timestamp,
  });

  factory _$MealRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealRequestImplFromJson(json);

  @override
  final String name;
  @override
  final double carbs;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'MealRequest(name: $name, carbs: $carbs, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, carbs, timestamp);

  /// Create a copy of MealRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealRequestImplCopyWith<_$MealRequestImpl> get copyWith =>
      __$$MealRequestImplCopyWithImpl<_$MealRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealRequestImplToJson(this);
  }
}

abstract class _MealRequest implements MealRequest {
  const factory _MealRequest({
    required final String name,
    required final double carbs,
    required final DateTime timestamp,
  }) = _$MealRequestImpl;

  factory _MealRequest.fromJson(Map<String, dynamic> json) =
      _$MealRequestImpl.fromJson;

  @override
  String get name;
  @override
  double get carbs;
  @override
  DateTime get timestamp;

  /// Create a copy of MealRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealRequestImplCopyWith<_$MealRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealResponse _$MealResponseFromJson(Map<String, dynamic> json) {
  return _MealResponse.fromJson(json);
}

/// @nodoc
mixin _$MealResponse {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get carbs => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  MealAnalysisResult? get analysis => throw _privateConstructorUsedError;
  double? get estimatedCarbs => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this MealResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealResponseCopyWith<MealResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealResponseCopyWith<$Res> {
  factory $MealResponseCopyWith(
    MealResponse value,
    $Res Function(MealResponse) then,
  ) = _$MealResponseCopyWithImpl<$Res, MealResponse>;
  @useResult
  $Res call({
    int id,
    String name,
    double carbs,
    DateTime timestamp,
    int userId,
    MealAnalysisResult? analysis,
    double? estimatedCarbs,
    String? imageUrl,
  });

  $MealAnalysisResultCopyWith<$Res>? get analysis;
}

/// @nodoc
class _$MealResponseCopyWithImpl<$Res, $Val extends MealResponse>
    implements $MealResponseCopyWith<$Res> {
  _$MealResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? carbs = null,
    Object? timestamp = null,
    Object? userId = null,
    Object? analysis = freezed,
    Object? estimatedCarbs = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            carbs: null == carbs
                ? _value.carbs
                : carbs // ignore: cast_nullable_to_non_nullable
                      as double,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            analysis: freezed == analysis
                ? _value.analysis
                : analysis // ignore: cast_nullable_to_non_nullable
                      as MealAnalysisResult?,
            estimatedCarbs: freezed == estimatedCarbs
                ? _value.estimatedCarbs
                : estimatedCarbs // ignore: cast_nullable_to_non_nullable
                      as double?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of MealResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealAnalysisResultCopyWith<$Res>? get analysis {
    if (_value.analysis == null) {
      return null;
    }

    return $MealAnalysisResultCopyWith<$Res>(_value.analysis!, (value) {
      return _then(_value.copyWith(analysis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealResponseImplCopyWith<$Res>
    implements $MealResponseCopyWith<$Res> {
  factory _$$MealResponseImplCopyWith(
    _$MealResponseImpl value,
    $Res Function(_$MealResponseImpl) then,
  ) = __$$MealResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    double carbs,
    DateTime timestamp,
    int userId,
    MealAnalysisResult? analysis,
    double? estimatedCarbs,
    String? imageUrl,
  });

  @override
  $MealAnalysisResultCopyWith<$Res>? get analysis;
}

/// @nodoc
class __$$MealResponseImplCopyWithImpl<$Res>
    extends _$MealResponseCopyWithImpl<$Res, _$MealResponseImpl>
    implements _$$MealResponseImplCopyWith<$Res> {
  __$$MealResponseImplCopyWithImpl(
    _$MealResponseImpl _value,
    $Res Function(_$MealResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? carbs = null,
    Object? timestamp = null,
    Object? userId = null,
    Object? analysis = freezed,
    Object? estimatedCarbs = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$MealResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        carbs: null == carbs
            ? _value.carbs
            : carbs // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        analysis: freezed == analysis
            ? _value.analysis
            : analysis // ignore: cast_nullable_to_non_nullable
                  as MealAnalysisResult?,
        estimatedCarbs: freezed == estimatedCarbs
            ? _value.estimatedCarbs
            : estimatedCarbs // ignore: cast_nullable_to_non_nullable
                  as double?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealResponseImpl implements _MealResponse {
  const _$MealResponseImpl({
    required this.id,
    required this.name,
    required this.carbs,
    required this.timestamp,
    required this.userId,
    this.analysis,
    this.estimatedCarbs,
    this.imageUrl,
  });

  factory _$MealResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealResponseImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final double carbs;
  @override
  final DateTime timestamp;
  @override
  final int userId;
  @override
  final MealAnalysisResult? analysis;
  @override
  final double? estimatedCarbs;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'MealResponse(id: $id, name: $name, carbs: $carbs, timestamp: $timestamp, userId: $userId, analysis: $analysis, estimatedCarbs: $estimatedCarbs, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis) &&
            (identical(other.estimatedCarbs, estimatedCarbs) ||
                other.estimatedCarbs == estimatedCarbs) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    carbs,
    timestamp,
    userId,
    analysis,
    estimatedCarbs,
    imageUrl,
  );

  /// Create a copy of MealResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealResponseImplCopyWith<_$MealResponseImpl> get copyWith =>
      __$$MealResponseImplCopyWithImpl<_$MealResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealResponseImplToJson(this);
  }
}

abstract class _MealResponse implements MealResponse {
  const factory _MealResponse({
    required final int id,
    required final String name,
    required final double carbs,
    required final DateTime timestamp,
    required final int userId,
    final MealAnalysisResult? analysis,
    final double? estimatedCarbs,
    final String? imageUrl,
  }) = _$MealResponseImpl;

  factory _MealResponse.fromJson(Map<String, dynamic> json) =
      _$MealResponseImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  double get carbs;
  @override
  DateTime get timestamp;
  @override
  int get userId;
  @override
  MealAnalysisResult? get analysis;
  @override
  double? get estimatedCarbs;
  @override
  String? get imageUrl;

  /// Create a copy of MealResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealResponseImplCopyWith<_$MealResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
