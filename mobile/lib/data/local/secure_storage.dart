import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/constants.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  Future<void> writeTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(
      key: AppConstants.jwtAccessTokenKey,
      value: accessToken,
    );
    await _storage.write(
      key: AppConstants.jwtRefreshTokenKey,
      value: refreshToken,
    );
  }

  Future<String?> readAccessToken() async {
    return _storage.read(key: AppConstants.jwtAccessTokenKey);
  }

  Future<String?> readRefreshToken() async {
    return _storage.read(key: AppConstants.jwtRefreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: AppConstants.jwtAccessTokenKey);
    await _storage.delete(key: AppConstants.jwtRefreshTokenKey);
  }

  Future<bool> hasTokens() async {
    final access = await readAccessToken();
    return access != null && access.isNotEmpty;
  }
}
