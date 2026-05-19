// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealsHash() => r'd539ce6a0771421144852d7a5ee982fe0594089d';

/// See also [meals].
@ProviderFor(meals)
final mealsProvider = AutoDisposeFutureProvider<List<MealResponse>>.internal(
  meals,
  name: r'mealsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mealsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MealsRef = AutoDisposeFutureProviderRef<List<MealResponse>>;
String _$mealNotifierHash() => r'ca0b649131850d272d3b8579ff6545c5b5b4977f';

/// See also [MealNotifier].
@ProviderFor(MealNotifier)
final mealNotifierProvider =
    AutoDisposeAsyncNotifierProvider<MealNotifier, MealResponse?>.internal(
      MealNotifier.new,
      name: r'mealNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$mealNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MealNotifier = AutoDisposeAsyncNotifier<MealResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
