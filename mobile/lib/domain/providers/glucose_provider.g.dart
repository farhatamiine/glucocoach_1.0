// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glucose_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$glucoseHealthDataHash() => r'2817d2c5108e9e8344bb18afe5d0f39453653c23';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [glucoseHealthData].
@ProviderFor(glucoseHealthData)
const glucoseHealthDataProvider = GlucoseHealthDataFamily();

/// See also [glucoseHealthData].
class GlucoseHealthDataFamily
    extends Family<AsyncValue<GlucoseSummaryResponse>> {
  /// See also [glucoseHealthData].
  const GlucoseHealthDataFamily();

  /// See also [glucoseHealthData].
  GlucoseHealthDataProvider call({int days = 90}) {
    return GlucoseHealthDataProvider(days: days);
  }

  @override
  GlucoseHealthDataProvider getProviderOverride(
    covariant GlucoseHealthDataProvider provider,
  ) {
    return call(days: provider.days);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'glucoseHealthDataProvider';
}

/// See also [glucoseHealthData].
class GlucoseHealthDataProvider
    extends AutoDisposeFutureProvider<GlucoseSummaryResponse> {
  /// See also [glucoseHealthData].
  GlucoseHealthDataProvider({int days = 90})
    : this._internal(
        (ref) => glucoseHealthData(ref as GlucoseHealthDataRef, days: days),
        from: glucoseHealthDataProvider,
        name: r'glucoseHealthDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$glucoseHealthDataHash,
        dependencies: GlucoseHealthDataFamily._dependencies,
        allTransitiveDependencies:
            GlucoseHealthDataFamily._allTransitiveDependencies,
        days: days,
      );

  GlucoseHealthDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<GlucoseSummaryResponse> Function(GlucoseHealthDataRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GlucoseHealthDataProvider._internal(
        (ref) => create(ref as GlucoseHealthDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GlucoseSummaryResponse> createElement() {
    return _GlucoseHealthDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GlucoseHealthDataProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GlucoseHealthDataRef
    on AutoDisposeFutureProviderRef<GlucoseSummaryResponse> {
  /// The parameter `days` of this provider.
  int get days;
}

class _GlucoseHealthDataProviderElement
    extends AutoDisposeFutureProviderElement<GlucoseSummaryResponse>
    with GlucoseHealthDataRef {
  _GlucoseHealthDataProviderElement(super.provider);

  @override
  int get days => (origin as GlucoseHealthDataProvider).days;
}

String _$glucoseTrendHash() => r'd2044ffe1561346d4caf449fbd541dfe0415ed89';

/// See also [glucoseTrend].
@ProviderFor(glucoseTrend)
final glucoseTrendProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      glucoseTrend,
      name: r'glucoseTrendProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$glucoseTrendHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GlucoseTrendRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$tirByDayHash() => r'2d4c16ff708d2283301dbd00edba3e4d4cd5be26';

/// See also [tirByDay].
@ProviderFor(tirByDay)
const tirByDayProvider = TirByDayFamily();

/// See also [tirByDay].
class TirByDayFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [tirByDay].
  const TirByDayFamily();

  /// See also [tirByDay].
  TirByDayProvider call({int days = 30}) {
    return TirByDayProvider(days: days);
  }

  @override
  TirByDayProvider getProviderOverride(covariant TirByDayProvider provider) {
    return call(days: provider.days);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tirByDayProvider';
}

/// See also [tirByDay].
class TirByDayProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [tirByDay].
  TirByDayProvider({int days = 30})
    : this._internal(
        (ref) => tirByDay(ref as TirByDayRef, days: days),
        from: tirByDayProvider,
        name: r'tirByDayProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tirByDayHash,
        dependencies: TirByDayFamily._dependencies,
        allTransitiveDependencies: TirByDayFamily._allTransitiveDependencies,
        days: days,
      );

  TirByDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(TirByDayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TirByDayProvider._internal(
        (ref) => create(ref as TirByDayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _TirByDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TirByDayProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TirByDayRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _TirByDayProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with TirByDayRef {
  _TirByDayProviderElement(super.provider);

  @override
  int get days => (origin as TirByDayProvider).days;
}

String _$agpDataHash() => r'681001cdd6dc6c39e9e83ec7db0cbc707c7f0082';

/// See also [agpData].
@ProviderFor(agpData)
const agpDataProvider = AgpDataFamily();

/// See also [agpData].
class AgpDataFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [agpData].
  const AgpDataFamily();

  /// See also [agpData].
  AgpDataProvider call({int days = 90}) {
    return AgpDataProvider(days: days);
  }

  @override
  AgpDataProvider getProviderOverride(covariant AgpDataProvider provider) {
    return call(days: provider.days);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'agpDataProvider';
}

/// See also [agpData].
class AgpDataProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [agpData].
  AgpDataProvider({int days = 90})
    : this._internal(
        (ref) => agpData(ref as AgpDataRef, days: days),
        from: agpDataProvider,
        name: r'agpDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$agpDataHash,
        dependencies: AgpDataFamily._dependencies,
        allTransitiveDependencies: AgpDataFamily._allTransitiveDependencies,
        days: days,
      );

  AgpDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(AgpDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AgpDataProvider._internal(
        (ref) => create(ref as AgpDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _AgpDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AgpDataProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AgpDataRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _AgpDataProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with AgpDataRef {
  _AgpDataProviderElement(super.provider);

  @override
  int get days => (origin as AgpDataProvider).days;
}

String _$dailyAverageByHourHash() =>
    r'937c4b7f7201796bd0431cfc36d55a4383c7b6ac';

/// See also [dailyAverageByHour].
@ProviderFor(dailyAverageByHour)
const dailyAverageByHourProvider = DailyAverageByHourFamily();

/// See also [dailyAverageByHour].
class DailyAverageByHourFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [dailyAverageByHour].
  const DailyAverageByHourFamily();

  /// See also [dailyAverageByHour].
  DailyAverageByHourProvider call({int days = 90}) {
    return DailyAverageByHourProvider(days: days);
  }

  @override
  DailyAverageByHourProvider getProviderOverride(
    covariant DailyAverageByHourProvider provider,
  ) {
    return call(days: provider.days);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dailyAverageByHourProvider';
}

/// See also [dailyAverageByHour].
class DailyAverageByHourProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [dailyAverageByHour].
  DailyAverageByHourProvider({int days = 90})
    : this._internal(
        (ref) => dailyAverageByHour(ref as DailyAverageByHourRef, days: days),
        from: dailyAverageByHourProvider,
        name: r'dailyAverageByHourProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dailyAverageByHourHash,
        dependencies: DailyAverageByHourFamily._dependencies,
        allTransitiveDependencies:
            DailyAverageByHourFamily._allTransitiveDependencies,
        days: days,
      );

  DailyAverageByHourProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(DailyAverageByHourRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DailyAverageByHourProvider._internal(
        (ref) => create(ref as DailyAverageByHourRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _DailyAverageByHourProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyAverageByHourProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DailyAverageByHourRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _DailyAverageByHourProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with DailyAverageByHourRef {
  _DailyAverageByHourProviderElement(super.provider);

  @override
  int get days => (origin as DailyAverageByHourProvider).days;
}

String _$rapidEventsHash() => r'7c578d2e88b31b1525ced18701fddf3ed2da8ab0';

/// See also [rapidEvents].
@ProviderFor(rapidEvents)
const rapidEventsProvider = RapidEventsFamily();

/// See also [rapidEvents].
class RapidEventsFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [rapidEvents].
  const RapidEventsFamily();

  /// See also [rapidEvents].
  RapidEventsProvider call({int days = 7}) {
    return RapidEventsProvider(days: days);
  }

  @override
  RapidEventsProvider getProviderOverride(
    covariant RapidEventsProvider provider,
  ) {
    return call(days: provider.days);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'rapidEventsProvider';
}

/// See also [rapidEvents].
class RapidEventsProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [rapidEvents].
  RapidEventsProvider({int days = 7})
    : this._internal(
        (ref) => rapidEvents(ref as RapidEventsRef, days: days),
        from: rapidEventsProvider,
        name: r'rapidEventsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$rapidEventsHash,
        dependencies: RapidEventsFamily._dependencies,
        allTransitiveDependencies: RapidEventsFamily._allTransitiveDependencies,
        days: days,
      );

  RapidEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(RapidEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RapidEventsProvider._internal(
        (ref) => create(ref as RapidEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _RapidEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RapidEventsProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RapidEventsRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _RapidEventsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RapidEventsRef {
  _RapidEventsProviderElement(super.provider);

  @override
  int get days => (origin as RapidEventsProvider).days;
}

String _$riskDataHash() => r'e435fdb71b89db68db1a5c30bb242b7491fc2124';

/// See also [riskData].
@ProviderFor(riskData)
const riskDataProvider = RiskDataFamily();

/// See also [riskData].
class RiskDataFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [riskData].
  const RiskDataFamily();

  /// See also [riskData].
  RiskDataProvider call({int days = 90}) {
    return RiskDataProvider(days: days);
  }

  @override
  RiskDataProvider getProviderOverride(covariant RiskDataProvider provider) {
    return call(days: provider.days);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'riskDataProvider';
}

/// See also [riskData].
class RiskDataProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [riskData].
  RiskDataProvider({int days = 90})
    : this._internal(
        (ref) => riskData(ref as RiskDataRef, days: days),
        from: riskDataProvider,
        name: r'riskDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$riskDataHash,
        dependencies: RiskDataFamily._dependencies,
        allTransitiveDependencies: RiskDataFamily._allTransitiveDependencies,
        days: days,
      );

  RiskDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(RiskDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RiskDataProvider._internal(
        (ref) => create(ref as RiskDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _RiskDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RiskDataProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RiskDataRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _RiskDataProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RiskDataRef {
  _RiskDataProviderElement(super.provider);

  @override
  int get days => (origin as RiskDataProvider).days;
}

String _$insulinSensitivityHash() =>
    r'2cb7e6c7dfdfbe253dcecbdf790b87f70e83f610';

/// See also [insulinSensitivity].
@ProviderFor(insulinSensitivity)
const insulinSensitivityProvider = InsulinSensitivityFamily();

/// See also [insulinSensitivity].
class InsulinSensitivityFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [insulinSensitivity].
  const InsulinSensitivityFamily();

  /// See also [insulinSensitivity].
  InsulinSensitivityProvider call({int days = 90}) {
    return InsulinSensitivityProvider(days: days);
  }

  @override
  InsulinSensitivityProvider getProviderOverride(
    covariant InsulinSensitivityProvider provider,
  ) {
    return call(days: provider.days);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'insulinSensitivityProvider';
}

/// See also [insulinSensitivity].
class InsulinSensitivityProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [insulinSensitivity].
  InsulinSensitivityProvider({int days = 90})
    : this._internal(
        (ref) => insulinSensitivity(ref as InsulinSensitivityRef, days: days),
        from: insulinSensitivityProvider,
        name: r'insulinSensitivityProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$insulinSensitivityHash,
        dependencies: InsulinSensitivityFamily._dependencies,
        allTransitiveDependencies:
            InsulinSensitivityFamily._allTransitiveDependencies,
        days: days,
      );

  InsulinSensitivityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(InsulinSensitivityRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InsulinSensitivityProvider._internal(
        (ref) => create(ref as InsulinSensitivityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _InsulinSensitivityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InsulinSensitivityProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InsulinSensitivityRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _InsulinSensitivityProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with InsulinSensitivityRef {
  _InsulinSensitivityProviderElement(super.provider);

  @override
  int get days => (origin as InsulinSensitivityProvider).days;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
