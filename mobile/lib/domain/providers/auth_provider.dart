import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/local/secure_storage.dart';
import '../../data/models/models.dart';
import '../../data/repositories/api_client_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  Future<AuthResponse?> build() async {
    final hasTokens = await ref.read(secureStorageProvider).hasTokens();
    if (hasTokens) {
      return AuthResponse(
        accessToken: await ref.read(secureStorageProvider).readAccessToken() ?? '',
        refreshToken: await ref.read(secureStorageProvider).readRefreshToken() ?? '',
        tokenType: 'Bearer',
      );
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.login(
        LoginRequest(email: email, password: password),
      );
      await ref.read(secureStorageProvider).writeTokens(
            accessToken: response.accessToken,
            refreshToken: response.refreshToken,
          );
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> register(RegisterRequest request) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.register(request);
      await ref.read(secureStorageProvider).writeTokens(
            accessToken: response.accessToken,
            refreshToken: response.refreshToken,
          );
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    try {
      final refreshToken = await ref.read(secureStorageProvider).readRefreshToken();
      if (refreshToken != null) {
        final client = ref.read(apiClientProvider);
        await client.logout(RefreshRequest(refreshToken: refreshToken));
      }
    } catch (_) {
      // Ignore logout errors
    } finally {
      await ref.read(secureStorageProvider).clearTokens();
      state = const AsyncValue.data(null);
    }
  }

  Future<void> forgotPassword(String email) async {
    final client = ref.read(apiClientProvider);
    await client.forgetPassword(ForgetPasswordRequest(email: email));
  }

  Future<void> resetPassword(String token, String newPassword) async {
    final client = ref.read(apiClientProvider);
    await client.resetPassword(
      ResetPasswordRequest(token: token, newPassword: newPassword),
    );
  }
}

@riverpod
Future<UserResponse> currentUser(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  return client.getMe();
}
