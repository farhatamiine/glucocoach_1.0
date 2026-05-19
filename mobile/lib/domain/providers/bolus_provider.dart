import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/models.dart';
import '../../data/repositories/api_client_provider.dart';

part 'bolus_provider.g.dart';

@riverpod
Future<List<BolusResponse>> boluses(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  return client.getBoluses();
}

@riverpod
class BolusNotifier extends _$BolusNotifier {
  @override
  Future<BolusResponse?> build() async => null;

  Future<void> createBolus(BolusRequest request) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.createBolus(request);
      ref.invalidate(bolusesProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteBolus(int id) async {
    try {
      final client = ref.read(apiClientProvider);
      await client.deleteBolus(id);
      ref.invalidate(bolusesProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
