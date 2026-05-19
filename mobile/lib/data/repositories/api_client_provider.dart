import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/env.dart';
import 'api_client.dart';
import 'dio_provider.dart';

part 'api_client_provider.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio, baseUrl: Env.apiBaseUrl);
}
