import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/models.dart';
import '../../data/repositories/api_client_provider.dart';

part 'meal_provider.g.dart';

@riverpod
Future<List<MealResponse>> meals(Ref ref) async {
  final client = ref.watch(apiClientProvider);
  return client.getMeals();
}

@riverpod
class MealNotifier extends _$MealNotifier {
  @override
  Future<MealResponse?> build() async => null;

  Future<void> createMeal(MealRequest request) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.createMeal(request);
      ref.invalidate(mealsProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateMeal(int id, MealRequest request) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.updateMeal(id, request);
      ref.invalidate(mealsProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteMeal(int id) async {
    try {
      final client = ref.read(apiClientProvider);
      await client.deleteMeal(id);
      ref.invalidate(mealsProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> uploadImage(int mealId, List<int> bytes, String filename) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.uploadMealImage(mealId, bytes);
      ref.invalidate(mealsProvider);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
