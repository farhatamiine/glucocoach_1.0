// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bolus_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bolusesHash() => r'cc4c5ae309e0bbb7faaf38102d1595101f39eb5d';

/// See also [boluses].
@ProviderFor(boluses)
final bolusesProvider = AutoDisposeFutureProvider<List<BolusResponse>>.internal(
  boluses,
  name: r'bolusesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bolusesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BolusesRef = AutoDisposeFutureProviderRef<List<BolusResponse>>;
String _$bolusNotifierHash() => r'cb0ea61f0c341576ef64adb8e0c9a0b0688921ad';

/// See also [BolusNotifier].
@ProviderFor(BolusNotifier)
final bolusNotifierProvider =
    AutoDisposeAsyncNotifierProvider<BolusNotifier, BolusResponse?>.internal(
      BolusNotifier.new,
      name: r'bolusNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bolusNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BolusNotifier = AutoDisposeAsyncNotifier<BolusResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
