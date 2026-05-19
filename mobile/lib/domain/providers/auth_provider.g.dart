// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'de96a0f555426c731221942755fc6e6bd98c87d8';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeFutureProvider<UserResponse>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeFutureProviderRef<UserResponse>;
String _$authStateHash() => r'8d806be2344ee0b32de348929381caa982ca0ad0';

/// See also [AuthState].
@ProviderFor(AuthState)
final authStateProvider =
    AutoDisposeAsyncNotifierProvider<AuthState, AuthResponse?>.internal(
      AuthState.new,
      name: r'authStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthState = AutoDisposeAsyncNotifier<AuthResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
