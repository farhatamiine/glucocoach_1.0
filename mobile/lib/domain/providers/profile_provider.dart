import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/models.dart';
import '../../data/repositories/api_client_provider.dart';

part 'profile_provider.g.dart';

@riverpod
Future<ProfileResponse> userProfile(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  return client.getProfile();
}

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<ProfileResponse?> build() async => null;

  Future<void> createProfile(ProfileRequest request) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.createProfile(request);
      ref.invalidate(userProfileProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProfile(ProfileRequest request) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.updateProfile(request);
      ref.invalidate(userProfileProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
