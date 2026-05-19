// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juggluco_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jugglucoGlucoseHash() => r'3e2ac2b5513d4062bc47bd5a46b5609c0f24bbb3';

/// Polls Juggluco's local server every 10 seconds for the latest glucose reading.
///
/// This provider uses a Stream to enable continuous polling. When the widget
/// is no longer listened to (autoDispose), polling stops automatically.
///
/// The returned [AsyncValue] will update every 10 seconds with fresh data.
/// A value of `null` means Juggluco is not reachable (phone server off, no sensor).
///
/// Use [ref.invalidate(jugglucoGlucoseProvider)] to force an immediate refresh.
///
/// Copied from [jugglucoGlucose].
@ProviderFor(jugglucoGlucose)
final jugglucoGlucoseProvider =
    AutoDisposeStreamProvider<JugglucoGlucose?>.internal(
      jugglucoGlucose,
      name: r'jugglucoGlucoseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$jugglucoGlucoseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JugglucoGlucoseRef = AutoDisposeStreamProviderRef<JugglucoGlucose?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
