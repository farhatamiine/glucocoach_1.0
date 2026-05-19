import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/models/models.dart';
import '../../../domain/providers/meal_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_card.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAsync = ref.watch(mealsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: mealsAsync.when(
        data: (meals) => _MealsList(meals: meals),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 8),
              Text('Error: $err'),
              TextButton(
                onPressed: () => ref.invalidate(mealsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/meals/add'),
        icon: const Icon(Icons.add),
        label: const Text('Add Meal'),
      ),
    );
  }
}

class _MealsList extends StatelessWidget {
  final List<MealResponse> meals;

  const _MealsList({required this.meals});

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant, size: 64, color: AppColors.textDisabled),
            SizedBox(height: 16),
            Text(
              'No meals logged yet',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tap + to log your first meal',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColors.textDisabled,
              ),
            ),
          ],
        ),
      );
    }

    // Group by date
    final grouped = <String, List<MealResponse>>{};
    for (final meal in meals) {
      final dateKey = DateFormat('yyyy-MM-dd').format(meal.timestamp);
      grouped.putIfAbsent(dateKey, () => []).add(meal);
    }

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final dateKey = sortedKeys[index];
        final dayMeals = grouped[dateKey]!;
        dayMeals.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                _formatDateHeader(DateTime.parse(dateKey)),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ...dayMeals.map((meal) => _MealCard(meal: meal)),
          ],
        );
      },
    );
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final mealDate = DateTime(date.year, date.month, date.day);

    if (mealDate == today) return 'Today';
    if (mealDate == yesterday) return 'Yesterday';
    return DateFormat('EEEE, MMM d').format(date);
  }
}

class _MealCard extends StatelessWidget {
  final MealResponse meal;

  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    final hasAiEstimate = meal.estimatedCarbs != null &&
        meal.estimatedCarbs! > 0 &&
        meal.carbs == 0;

    return AppCard(
      onTap: () => _showMealDetail(context),
      child: Row(
        children: [
          // Thumbnail or placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              image: meal.imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(meal.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: meal.imageUrl == null
                ? const Icon(Icons.restaurant, color: AppColors.textDisabled)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        meal.name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (hasAiEstimate)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'AI Estimate',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${meal.carbs.toStringAsFixed(0)}g carbs',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (meal.estimatedCarbs != null &&
                        meal.estimatedCarbs! > 0) ...[
                      const SizedBox(width: 8),
                      Text(
                        'Est: ${meal.estimatedCarbs!.toStringAsFixed(0)}g',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat('HH:mm').format(meal.timestamp),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: AppColors.textDisabled,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textDisabled,
          ),
        ],
      ),
    );
  }

  void _showMealDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (meal.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      meal.imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  meal.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _DetailChip(
                      icon: Icons.restaurant,
                      label: '${meal.carbs.toStringAsFixed(0)}g carbs',
                    ),
                    const SizedBox(width: 8),
                    _DetailChip(
                      icon: Icons.access_time,
                      label: DateFormat('MMM d, HH:mm').format(meal.timestamp),
                    ),
                  ],
                ),
                if (meal.estimatedCarbs != null && meal.estimatedCarbs! > 0) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AI Analysis',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Estimated Carbs: ${meal.estimatedCarbs!.toStringAsFixed(1)}g',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                          ),
                        ),
                        if (meal.analysis != null) ...[
                          if (meal.analysis!.confidence != null)
                            Text(
                              'Confidence: ${meal.analysis!.confidence}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          if (meal.analysis!.ingredients != null &&
                              meal.analysis!.ingredients!.isNotEmpty)
                            Text(
                              'Ingredients: ${meal.analysis!.ingredients!.join(', ')}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
