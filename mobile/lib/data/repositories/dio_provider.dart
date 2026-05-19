import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/constants.dart';
import '../../config/env.dart';
import '../local/secure_storage.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: AppConstants.connectionTimeoutSeconds),
      receiveTimeout: const Duration(seconds: AppConstants.receiveTimeoutSeconds),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Logging interceptor for debug
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );
  }

  // Auth interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final secureStorage = ref.read(secureStorageProvider);
        final token = await secureStorage.readAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final secureStorage = ref.read(secureStorageProvider);
          final refreshToken = await secureStorage.readRefreshToken();
          if (refreshToken != null && refreshToken.isNotEmpty) {
            try {
              final refreshDio = Dio(
                BaseOptions(baseUrl: Env.apiBaseUrl),
              );
              final response = await refreshDio.post<Map<String, dynamic>>(
                '/api/auth/refresh',
                data: {'refreshToken': refreshToken},
              );
              final newAccessToken = response.data?['accessToken'] as String?;
              final newRefreshToken = response.data?['refreshToken'] as String?;
              if (newAccessToken != null) {
                await secureStorage.writeTokens(
                  accessToken: newAccessToken,
                  refreshToken: newRefreshToken ?? refreshToken,
                );
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';
                final retryResponse = await dio.fetch<dynamic>(
                  error.requestOptions,
                );
                handler.resolve(retryResponse);
                return;
              }
            } catch (_) {
              await secureStorage.clearTokens();
            }
          }
        }
        handler.next(error);
      },
    ),
  );

  return dio;
}
