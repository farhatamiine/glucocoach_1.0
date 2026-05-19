import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/models/juggluco.dart';
import '../../../domain/providers/glucose_provider.dart';
import '../../../domain/providers/juggluco_provider.dart';
import '../../../domain/providers/meal_provider.dart';
import '../../../domain/providers/bolus_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glucose_value_widget.dart';
import '../../widgets/tir_bar_widget.dart';
import '../../widgets/app_card.dart';
import '../../widgets/offline_banner.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;

  final _screens = const [
    _HomeTab(),
    _GlucoseTabPlaceholder(),
    _MealsTabPlaceholder(),
    _BolusTabPlaceholder(),
    _ProfileTabPlaceholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 1) {
            context.push('/glucose');
            return;
          }
          if (index == 2) {
            context.push('/meals');
            return;
          }
          if (index == 3) {
            context.push('/bolus');
            return;
          }
          if (index == 4) {
            context.push('/profile');
            return;
          }
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.show_chart),
            label: 'Glucose',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: 'Meals',
          ),
          NavigationDestination(
            icon: Icon(Icons.medication_outlined),
            selectedIcon: Icon(Icons.medication),
            label: 'Bolus',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends ConsumerWidget {
  const _HomeTab();

  Future<void> _onRefresh(WidgetRef ref) async {
    // Refresh Juggluco (local) data
    ref.invalidate(jugglucoGlucoseProvider);
    // Refresh backend data
    ref.invalidate(glucoseHealthDataProvider);
    ref.invalidate(mealsProvider);
    ref.invalidate(bolusesProvider);
    // Give the providers a moment to start fetching
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jugglucoAsync = ref.watch(jugglucoGlucoseProvider);
    final healthDataAsync = ref.watch(glucoseHealthDataProvider(days: 1));
    final mealsAsync = ref.watch(mealsProvider);
    final bolusesAsync = ref.watch(bolusesProvider);

    // Determine if we have a local Juggluco reading
    final jugglucoValue = jugglucoAsync.valueOrNull;
    final hasJuggluco = jugglucoValue != null;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(ref),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  OfflineBanner(isOffline: !hasJuggluco && healthDataAsync.hasError),
                  const SizedBox(height: 16),
                  _buildGlucoseCard(
                    context,
                    jugglucoAsync: jugglucoAsync,
                    healthDataAsync: healthDataAsync,
                  ),
                  _buildQuickStats(context, healthDataAsync, bolusesAsync),
                  _buildRecentActivity(context, mealsAsync, bolusesAsync),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlucoseCard(
    BuildContext context, {
    required AsyncValue<JugglucoGlucose?> jugglucoAsync,
    required AsyncValue healthDataAsync,
  }) {
    return AppCard(
      child: jugglucoAsync.when(
        data: (juggluco) {
          // Prefer Juggluco (local, real-time) if available
          if (juggluco != null) {
            return _GlucoseDisplay(
              glucose: juggluco.glucose,
              direction: juggluco.direction,
              timestamp: juggluco.timestamp,
              source: 'Juggluco',
              tir: healthDataAsync.valueOrNull?.tir ?? 0,
              tbr: healthDataAsync.valueOrNull?.tbr ?? 0,
              tar: healthDataAsync.valueOrNull?.tar ?? 0,
            );
          }

          // Fall back to backend data
          return healthDataAsync.when(
            data: (data) {
              final trend = data.currentTrend;
              final sgv = trend != null && trend['sgv'] != null
                  ? (trend['sgv'] as num).toInt()
                  : data.average.toInt();
              final direction =
                  trend != null ? trend['direction'] as String? : null;

              return _GlucoseDisplay(
                glucose: sgv,
                direction: direction,
                timestamp: DateTime.now(),
                source: 'Nightscout',
                tir: data.tir,
                tbr: data.tbr,
                tar: data.tar,
              );
            },
            loading: () => const _LoadingGlucose(),
            error: (err, _) => _ErrorGlucose(
              onRetry: () {
                // Refresh both sources
                // ignore: unused_result
                jugglucoAsync.value;
              },
            ),
          );
        },
        loading: () {
          // While Juggluco is loading, try to show backend data
          return healthDataAsync.when(
            data: (data) {
              final trend = data.currentTrend;
              final sgv = trend != null && trend['sgv'] != null
                  ? (trend['sgv'] as num).toInt()
                  : data.average.toInt();
              final direction =
                  trend != null ? trend['direction'] as String? : null;

              return _GlucoseDisplay(
                glucose: sgv,
                direction: direction,
                timestamp: DateTime.now(),
                source: 'Nightscout',
                tir: data.tir,
                tbr: data.tbr,
                tar: data.tar,
              );
            },
            loading: () => const _LoadingGlucose(),
            error: (_, __) => const _LoadingGlucose(),
          );
        },
        error: (err, _) {
          // On Juggluco error, fall back to backend
          return healthDataAsync.when(
            data: (data) {
              final trend = data.currentTrend;
              final sgv = trend != null && trend['sgv'] != null
                  ? (trend['sgv'] as num).toInt()
                  : data.average.toInt();
              final direction =
                  trend != null ? trend['direction'] as String? : null;

              return _GlucoseDisplay(
                glucose: sgv,
                direction: direction,
                timestamp: DateTime.now(),
                source: 'Nightscout',
                tir: data.tir,
                tbr: data.tbr,
                tar: data.tar,
              );
            },
            loading: () => const _LoadingGlucose(),
            error: (_, __) => _ErrorGlucose(
              onRetry: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickStats(
    BuildContext context,
    AsyncValue healthDataAsync,
    AsyncValue bolusesAsync,
  ) {
    return AppCard(
      child: healthDataAsync.when(
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Summary',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _StatItem(
                    icon: Icons.check_circle,
                    color: AppColors.glucoseNormal,
                    label: 'TIR',
                    value: '${data.tir.toStringAsFixed(1)}%',
                  ),
                  _StatItem(
                    icon: Icons.trending_flat,
                    color: AppColors.primary,
                    label: 'Avg',
                    value: '${data.average.toStringAsFixed(0)}',
                  ),
                  _StatItem(
                    icon: Icons.analytics,
                    color: AppColors.info,
                    label: 'GMI',
                    value: '${data.gmi.toStringAsFixed(1)}%',
                  ),
                  _StatItem(
                    icon: Icons.medication,
                    color: AppColors.primaryLight,
                    label: 'Boluses',
                    value: bolusesAsync.when(
                      data: (boluses) => '${boluses.length}',
                      loading: () => '-',
                      error: (_, __) => '-',
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => const SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildRecentActivity(
    BuildContext context,
    AsyncValue mealsAsync,
    AsyncValue bolusesAsync,
  ) {
    final items = <Map<String, dynamic>>[];

    mealsAsync.whenData((meals) {
      for (final meal in meals.take(3)) {
        items.add({
          'type': 'meal',
          'name': meal.name,
          'detail': '${meal.carbs.toStringAsFixed(0)}g carbs',
          'time': meal.timestamp,
          'icon': Icons.restaurant,
          'color': AppColors.glucoseNormal,
        });
      }
    });

    bolusesAsync.whenData((boluses) {
      for (final bolus in boluses.take(3)) {
        items.add({
          'type': 'bolus',
          'name': bolus.bolusType.name == 'MEAL' ? 'Meal Bolus' : 'Correction',
          'detail': '${bolus.amount.toStringAsFixed(1)} units',
          'time': bolus.timestamp,
          'icon': Icons.medication,
          'color': bolus.bolusType.name == 'MEAL'
              ? AppColors.primary
              : AppColors.warning,
        });
      }
    });

    items.sort((a, b) => (b['time'] as DateTime).compareTo(a['time'] as DateTime));
    final recentItems = items.take(5).toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          if (recentItems.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'No recent activity',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            )
          else
            ...recentItems.map((item) => _ActivityItem(
                  icon: item['icon'] as IconData,
                  color: item['color'] as Color,
                  name: item['name'] as String,
                  detail: item['detail'] as String,
                  time: item['time'] as DateTime,
                )),
        ],
      ),
    );
  }
}

/// Displays the current glucose value with trend, timestamp, and TIR bar.
class _GlucoseDisplay extends StatelessWidget {
  final int glucose;
  final String? direction;
  final DateTime timestamp;
  final String source;
  final double tir;
  final double tbr;
  final double tar;

  const _GlucoseDisplay({
    required this.glucose,
    this.direction,
    required this.timestamp,
    required this.source,
    required this.tir,
    required this.tbr,
    required this.tar,
  });

  String get _timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat('HH:mm').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Current Glucose',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                // Source badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: source == 'Juggluco'
                        ? AppColors.glucoseNormal.withValues(alpha: 0.15)
                        : AppColors.textSecondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    source == 'Juggluco' ? 'Live' : 'Cloud',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: source == 'Juggluco'
                          ? AppColors.glucoseNormal
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        GlucoseValue(
          sgv: glucose,
          direction: direction,
          fontSize: 64,
        ),
        const SizedBox(height: 8),
        Text(
          'Last updated: $_timeAgo',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 16),
        TIRBar(
          inRangePercent: tir,
          belowPercent: tbr,
          abovePercent: tar,
          height: 20,
          showLabels: false,
        ),
      ],
    );
  }
}

class _LoadingGlucose extends StatelessWidget {
  const _LoadingGlucose();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorGlucose extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorGlucose({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 8),
            Text(
              'Unable to load glucose data',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
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

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;
  final String detail;
  final DateTime time;

  const _ActivityItem({
    required this.icon,
    required this.color,
    required this.name,
    required this.detail,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('HH:mm').format(time),
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

class _GlucoseTabPlaceholder extends StatelessWidget {
  const _GlucoseTabPlaceholder();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _MealsTabPlaceholder extends StatelessWidget {
  const _MealsTabPlaceholder();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _BolusTabPlaceholder extends StatelessWidget {
  const _BolusTabPlaceholder();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _ProfileTabPlaceholder extends StatelessWidget {
  const _ProfileTabPlaceholder();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
