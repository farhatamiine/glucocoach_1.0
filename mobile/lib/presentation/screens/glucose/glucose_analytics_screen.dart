import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/models/glucose.dart';
import '../../../domain/providers/glucose_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_card.dart';
import '../../widgets/time_range_chips.dart';
import '../../widgets/tir_bar_widget.dart';

class GlucoseAnalyticsScreen extends ConsumerStatefulWidget {
  const GlucoseAnalyticsScreen({super.key});

  @override
  ConsumerState<GlucoseAnalyticsScreen> createState() =>
      _GlucoseAnalyticsScreenState();
}

class _GlucoseAnalyticsScreenState
    extends ConsumerState<GlucoseAnalyticsScreen> {
  int _selectedRange = 24; // hours

  final List<int> _ranges = [1, 3, 6, 24, 168, 336, 720, 2160];

  int _getDaysFromRange(int rangeHours) {
    return (rangeHours / 24).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysFromRange(_selectedRange);
    final healthDataAsync = ref.watch(glucoseHealthDataProvider(days: days));
    final tirByDayAsync = ref.watch(tirByDayProvider(days: days));
    final agpAsync = ref.watch(agpDataProvider(days: days));
    final dailyAvgAsync = ref.watch(dailyAverageByHourProvider(days: days));
    final riskAsync = ref.watch(riskDataProvider(days: days));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Glucose Analytics'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  TimeRangeChips(
                    ranges: _ranges,
                    selectedRange: _selectedRange,
                    onSelected: (range) => setState(() => _selectedRange = range),
                  ),
                  const SizedBox(height: 16),
                  healthDataAsync.when(
                    data: (data) => _buildTrendChart(context, data),
                    loading: () => const _LoadingCard(height: 300),
                    error: (_, __) => const _ErrorCard(),
                  ),
                  healthDataAsync.when(
                    data: (data) => _buildTIRCard(context, data),
                    loading: () => const _LoadingCard(height: 150),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  agpAsync.when(
                    data: (agp) => _buildAGPCard(context, agp),
                    loading: () => const _LoadingCard(height: 250),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  dailyAvgAsync.when(
                    data: (avg) => _buildDailyAvgCard(context, avg),
                    loading: () => const _LoadingCard(height: 250),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  riskAsync.when(
                    data: (risk) => _buildRiskCard(context, risk),
                    loading: () => const _LoadingCard(height: 120),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChart(BuildContext context, dynamic data) {
    final entries = <FlSpot>[];
    final rapidRise = data.rapidRiseEntries ?? [];
    final rapidFall = data.rapidFallEntries ?? [];
    final allEntries = [...rapidRise, ...rapidFall];

    int parseDate(NightscoutEntryDTO entry) {
      final sysTime = entry.sysTime;
      if (sysTime == null) return 0;
      return DateTime.tryParse(sysTime)?.millisecondsSinceEpoch ?? 0;
    }

    if (allEntries.isNotEmpty) {
      allEntries.sort((a, b) => (parseDate(a)).compareTo(parseDate(b)));
      final minDate = parseDate(allEntries.first);
      for (var i = 0; i < allEntries.length; i++) {
        final entry = allEntries[i];
        if (entry.sgv != null) {
          final x = (parseDate(entry) - minDate) / (1000 * 60 * 60);
          entries.add(FlSpot(x.toDouble(), entry.sgv!.toDouble()));
        }
      }
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Glucose Trend',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: entries.isEmpty
                ? const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 50,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: AppColors.border,
                            strokeWidth: 1,
                            dashArray: value == 70 || value == 180
                                ? [5, 5]
                                : null,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            interval: 50,
                            getTitlesWidget: (value, meta) => Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        bottomTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minY: 40,
                      maxY: 400,
                      lineBarsData: [
                        LineChartBarData(
                          spots: entries,
                          isCurved: true,
                          curveSmoothness: 0.3,
                          color: AppColors.chartLine,
                          barWidth: 2,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.chartLine.withValues(alpha: 0.1),
                          ),
                        ),
                      ],
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          HorizontalLine(
                            y: 70,
                            color: AppColors.chartHypoLine,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                            label: HorizontalLineLabel(
                              show: true,
                              labelResolver: (_) => '70',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.chartHypoLine,
                              ),
                            ),
                          ),
                          HorizontalLine(
                            y: 180,
                            color: AppColors.chartHyperLine,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                            label: HorizontalLineLabel(
                              show: true,
                              labelResolver: (_) => '180',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.chartHyperLine,
                              ),
                            ),
                          ),
                        ],
                      ),
                      rangeAnnotations: RangeAnnotations(
                        horizontalRangeAnnotations: [
                          HorizontalRangeAnnotation(
                            y1: 70,
                            y2: 180,
                            color: AppColors.chartTargetBand,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTIRCard(BuildContext context, dynamic data) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time in Range',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          TIRBar(
            inRangePercent: data.tir,
            belowPercent: data.tbr,
            abovePercent: data.tar,
            height: 32,
            showLabels: true,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat('Hypos', '${data.hypos}', AppColors.glucoseLow),
              _MiniStat('Severe', '${data.severeHypos}', AppColors.glucoseVeryLow),
              _MiniStat('Hypers', '${data.hypers}', AppColors.glucoseHigh),
              _MiniStat('Severe', '${data.severeHypers}', AppColors.glucoseVeryHigh),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAGPCard(BuildContext context, Map<String, dynamic> agp) {
    final hourlyData = <_AGPPoint>[];
    agp.forEach((hourStr, percentiles) {
      final hour = int.tryParse(hourStr);
      if (hour != null && percentiles is Map) {
        hourlyData.add(_AGPPoint(
          hour: hour,
          p5: (percentiles['p5'] as num?)?.toDouble() ?? 0,
          p25: (percentiles['p25'] as num?)?.toDouble() ?? 0,
          p50: (percentiles['p50'] as num?)?.toDouble() ?? 0,
          p75: (percentiles['p75'] as num?)?.toDouble() ?? 0,
          p95: (percentiles['p95'] as num?)?.toDouble() ?? 0,
        ));
      }
    });
    hourlyData.sort((a, b) => a.hour.compareTo(b.hour));

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ambulatory Glucose Profile (AGP)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Percentile bands per hour of day',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: hourlyData.isEmpty
                ? const Center(
                    child: Text(
                      'No AGP data',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 50,
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 35,
                            interval: 100,
                            getTitlesWidget: (value, meta) => Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 3,
                            getTitlesWidget: (value, meta) {
                              final hour = value.toInt();
                              return Text(
                                '${hour.toString().padLeft(2, '0')}:00',
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: AppColors.textSecondary,
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minY: 40,
                      maxY: 400,
                      lineBarsData: [
                        _buildAGPBar(hourlyData, 'p95', AppColors.glucoseVeryHigh.withValues(alpha: 0.3)),
                        _buildAGPBar(hourlyData, 'p75', AppColors.glucoseHigh.withValues(alpha: 0.4)),
                        _buildAGPBar(hourlyData, 'p50', AppColors.primary, barWidth: 2.5),
                        _buildAGPBar(hourlyData, 'p25', AppColors.glucoseHigh.withValues(alpha: 0.4)),
                        _buildAGPBar(hourlyData, 'p5', AppColors.glucoseVeryHigh.withValues(alpha: 0.3)),
                      ],
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          HorizontalLine(
                            y: 70,
                            color: AppColors.chartHypoLine,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          ),
                          HorizontalLine(
                            y: 180,
                            color: AppColors.chartHyperLine,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _buildAGPBar(
    List<_AGPPoint> data,
    String percentile,
    Color color, {
    double barWidth = 1,
  }) {
    final spots = data.map((p) {
      double y;
      switch (percentile) {
        case 'p5':
          y = p.p5;
          break;
        case 'p25':
          y = p.p25;
          break;
        case 'p50':
          y = p.p50;
          break;
        case 'p75':
          y = p.p75;
          break;
        case 'p95':
          y = p.p95;
          break;
        default:
          y = p.p50;
      }
      return FlSpot(p.hour.toDouble(), y);
    }).toList();

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      curveSmoothness: 0.3,
      color: color,
      barWidth: barWidth,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  Widget _buildDailyAvgCard(BuildContext context, Map<String, dynamic> avg) {
    final hourlyData = <FlSpot>[];
    final sortedKeys = avg.keys.toList()..sort();
    for (final key in sortedKeys) {
      final hour = int.tryParse(key);
      final value = (avg[key] as num?)?.toDouble();
      if (hour != null && value != null) {
        hourlyData.add(FlSpot(hour.toDouble(), value));
      }
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Average by Hour',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: hourlyData.isEmpty
                ? const Center(
                    child: Text(
                      'No data',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : BarChart(
                    BarChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 50,
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 35,
                            interval: 100,
                            getTitlesWidget: (value, meta) => Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 3,
                            getTitlesWidget: (value, meta) {
                              final hour = value.toInt();
                              return Text(
                                '${hour.toString().padLeft(2, '0')}:00',
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: AppColors.textSecondary,
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minY: 0,
                      maxY: 400,
                      barGroups: hourlyData.map((spot) {
                        return BarChartGroupData(
                          x: spot.x.toInt(),
                          barRods: [
                            BarChartRodData(
                              toY: spot.y,
                              color: spot.y < 70
                                  ? AppColors.glucoseLow
                                  : spot.y > 180
                                      ? AppColors.glucoseHigh
                                      : AppColors.glucoseNormal,
                              width: 8,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(BuildContext context, Map<String, dynamic> risk) {
    final lbgi = (risk['lbgi'] as num?)?.toDouble() ?? 0;
    final hbgi = (risk['hbgi'] as num?)?.toDouble() ?? 0;

    Color lbgiColor;
    if (lbgi < 2.5) {
      lbgiColor = AppColors.glucoseNormal;
    } else if (lbgi < 5) {
      lbgiColor = AppColors.glucoseHigh;
    } else {
      lbgiColor = AppColors.glucoseLow;
    }

    Color hbgiColor;
    if (hbgi < 2.5) {
      hbgiColor = AppColors.glucoseNormal;
    } else if (hbgi < 5) {
      hbgiColor = AppColors.glucoseHigh;
    } else {
      hbgiColor = AppColors.glucoseVeryHigh;
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Glucose Risk Indices',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _RiskCard(
                  label: 'LBGI',
                  value: lbgi.toStringAsFixed(2),
                  subtitle: 'Low BG Risk',
                  color: lbgiColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RiskCard(
                  label: 'HBGI',
                  value: hbgi.toStringAsFixed(2),
                  subtitle: 'High BG Risk',
                  color: hbgiColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AGPPoint {
  final int hour;
  final double p5;
  final double p25;
  final double p50;
  final double p75;
  final double p95;

  _AGPPoint({
    required this.hour,
    required this.p5,
    required this.p25,
    required this.p50,
    required this.p75,
    required this.p95,
  });
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _RiskCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final Color color;

  const _RiskCard({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  final double height;

  const _LoadingCard({required this.height});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 8),
              const Text(
                'Failed to load data',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
