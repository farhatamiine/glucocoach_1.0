import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class TIRBar extends StatelessWidget {
  final double inRangePercent;
  final double belowPercent;
  final double abovePercent;
  final double height;
  final bool showLabels;

  const TIRBar({
    super.key,
    required this.inRangePercent,
    required this.belowPercent,
    required this.abovePercent,
    this.height = 24,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    final total = inRangePercent + belowPercent + abovePercent;
    final normalizedInRange = total > 0 ? inRangePercent / total : 0;
    final normalizedBelow = total > 0 ? belowPercent / total : 0;
    final normalizedAbove = total > 0 ? abovePercent / total : 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: SizedBox(
            height: height,
            child: Row(
              children: [
                if (normalizedBelow > 0.01)
                  Expanded(
                    flex: (normalizedBelow * 100).round(),
                    child: Container(
                      color: AppColors.glucoseLow,
                      child: showLabels && normalizedBelow > 0.08
                          ? Center(
                              child: Text(
                                '${belowPercent.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                if (normalizedInRange > 0.01)
                  Expanded(
                    flex: (normalizedInRange * 100).round(),
                    child: Container(
                      color: AppColors.glucoseNormal,
                      child: showLabels && normalizedInRange > 0.08
                          ? Center(
                              child: Text(
                                '${inRangePercent.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                if (normalizedAbove > 0.01)
                  Expanded(
                    flex: (normalizedAbove * 100).round(),
                    child: Container(
                      color: AppColors.glucoseHigh,
                      child: showLabels && normalizedAbove > 0.08
                          ? Center(
                              child: Text(
                                '${abovePercent.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (showLabels) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LegendItem(
                color: AppColors.glucoseLow,
                label: 'Below 70',
                value: '${belowPercent.toStringAsFixed(1)}%',
              ),
              _LegendItem(
                color: AppColors.glucoseNormal,
                label: 'In Range',
                value: '${inRangePercent.toStringAsFixed(1)}%',
              ),
              _LegendItem(
                color: AppColors.glucoseHigh,
                label: 'Above 180',
                value: '${abovePercent.toStringAsFixed(1)}%',
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
