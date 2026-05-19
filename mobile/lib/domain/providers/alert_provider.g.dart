// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alertsHash() => r'5a60eb7dde904c223f4012e5310c2d6794060cf7';

/// See also [alerts].
@ProviderFor(alerts)
final alertsProvider = AutoDisposeFutureProvider<List<AlertResponse>>.internal(
  alerts,
  name: r'alertsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$alertsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlertsRef = AutoDisposeFutureProviderRef<List<AlertResponse>>;
String _$alertHistoryHash() => r'431c0058c12c1db6196b0ccf82371733c2731f37';

/// See also [alertHistory].
@ProviderFor(alertHistory)
final alertHistoryProvider =
    AutoDisposeFutureProvider<List<AlertHistoryResponse>>.internal(
      alertHistory,
      name: r'alertHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$alertHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlertHistoryRef =
    AutoDisposeFutureProviderRef<List<AlertHistoryResponse>>;
String _$alertNotifierHash() => r'3e319a76d55fe838791272a629878a2d84095331';

/// See also [AlertNotifier].
@ProviderFor(AlertNotifier)
final alertNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AlertNotifier, AlertResponse?>.internal(
      AlertNotifier.new,
      name: r'alertNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$alertNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AlertNotifier = AutoDisposeAsyncNotifier<AlertResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
