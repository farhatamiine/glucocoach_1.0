import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/models.dart';
import '../../data/repositories/api_client_provider.dart';

part 'glucose_provider.g.dart';

@riverpod
Future<GlucoseSummaryResponse> glucoseHealthData(Ref ref, {int days = 90}) async {
  final client = ref.watch(apiClientProvider);
  return client.getHealthData(days);
}

@riverpod
Future<Map<String, dynamic>> glucoseTrend(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  return client.getTrend();
}

@riverpod
Future<Map<String, dynamic>> tirByDay(Ref ref, {int days = 30}) async {
  final client = ref.watch(apiClientProvider);
  return client.getTirByDay(days);
}

@riverpod
Future<Map<String, dynamic>> agpData(Ref ref, {int days = 90}) async {
  final client = ref.watch(apiClientProvider);
  return client.getAgp(days);
}

@riverpod
Future<Map<String, dynamic>> dailyAverageByHour(Ref ref, {int days = 90}) async {
  final client = ref.watch(apiClientProvider);
  return client.getDailyAverageByHour(days);
}

@riverpod
Future<Map<String, dynamic>> rapidEvents(Ref ref, {int days = 7}) async {
  final client = ref.watch(apiClientProvider);
  return client.getRapidEvents(days);
}

@riverpod
Future<Map<String, dynamic>> riskData(Ref ref, {int days = 90}) async {
  final client = ref.watch(apiClientProvider);
  return client.getRisk(days);
}

@riverpod
Future<Map<String, dynamic>> insulinSensitivity(Ref ref, {int days = 90}) async {
  final client = ref.watch(apiClientProvider);
  return client.getInsulinSensitivity(days);
}
