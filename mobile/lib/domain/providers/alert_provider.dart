import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/models.dart';
import '../../data/repositories/api_client_provider.dart';

part 'alert_provider.g.dart';

@riverpod
Future<List<AlertResponse>> alerts(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  return client.getAlerts();
}

@riverpod
Future<List<AlertHistoryResponse>> alertHistory(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  return client.getAlertHistory();
}

@riverpod
class AlertNotifier extends _$AlertNotifier {
  @override
  Future<AlertResponse?> build() async => null;

  Future<void> createAlert(AlertRequest request) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.createAlert(request);
      ref.invalidate(alertsProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateAlert(int id, AlertRequest request) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.updateAlert(id, request);
      ref.invalidate(alertsProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteAlert(int id) async {
    try {
      final client = ref.read(apiClientProvider);
      await client.deleteAlert(id);
      ref.invalidate(alertsProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
