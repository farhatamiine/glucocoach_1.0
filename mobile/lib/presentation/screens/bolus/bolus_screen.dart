import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/models/models.dart';
import '../../../domain/providers/bolus_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_card.dart';

class BolusScreen extends ConsumerWidget {
  const BolusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bolusesAsync = ref.watch(bolusesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insulin Boluses'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: bolusesAsync.when(
        data: (boluses) => _BolusList(boluses: boluses),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 8),
              Text('Error: $err'),
              TextButton(
                onPressed: () => ref.invalidate(bolusesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/bolus/add'),
        icon: const Icon(Icons.add),
        label: const Text('Add Bolus'),
      ),
    );
  }
}

class _BolusList extends StatelessWidget {
  final List<BolusResponse> boluses;

  const _BolusList({required this.boluses});

  @override
  Widget build(BuildContext context) {
    if (boluses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.medication, size: 64, color: AppColors.textDisabled),
            SizedBox(height: 16),
            Text(
              'No boluses logged yet',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tap + to log your first bolus',
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
    final grouped = <String, List<BolusResponse>>{};
    for (final bolus in boluses) {
      final dateKey = DateFormat('yyyy-MM-dd').format(bolus.timestamp);
      grouped.putIfAbsent(dateKey, () => []).add(bolus);
    }

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final dateKey = sortedKeys[index];
        final dayBoluses = grouped[dateKey]!;
        dayBoluses.sort((a, b) => b.timestamp.compareTo(a.timestamp));

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
            ...dayBoluses.map((bolus) => _BolusCard(bolus: bolus)),
          ],
        );
      },
    );
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final bolusDate = DateTime(date.year, date.month, date.day);

    if (bolusDate == today) return 'Today';
    if (bolusDate == yesterday) return 'Yesterday';
    return DateFormat('EEEE, MMM d').format(date);
  }
}

class _BolusCard extends StatelessWidget {
  final BolusResponse bolus;

  const _BolusCard({required this.bolus});

  @override
  Widget build(BuildContext context) {
    final isMeal = bolus.bolusType == BolusType.MEAL;
    final color = isMeal ? AppColors.primary : AppColors.warning;

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isMeal ? Icons.restaurant : Icons.trending_down,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${bolus.amount.toStringAsFixed(1)} units',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isMeal ? 'Meal' : 'Correction',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ),
                    if (bolus.mealId != null) ...[
                      const SizedBox(width: 8),
                      const Text(
                        'Linked to meal',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Text(
            DateFormat('HH:mm').format(bolus.timestamp),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
