import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class TimeRangeChips extends StatelessWidget {
  final List<int> ranges;
  final int selectedRange;
  final ValueChanged<int> onSelected;
  final String Function(int)? labelBuilder;

  const TimeRangeChips({
    super.key,
    required this.ranges,
    required this.selectedRange,
    required this.onSelected,
    this.labelBuilder,
  });

  String _defaultLabel(int range) {
    if (range < 24) return '${range}h';
    if (range == 24) return '1d';
    if (range == 168) return '7d';
    if (range == 336) return '14d';
    if (range == 720) return '30d';
    if (range == 2160) return '90d';
    return '$range';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: ranges.map((range) {
          final isSelected = range == selectedRange;
          final label = labelBuilder?.call(range) ?? _defaultLabel(range);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label),
              selected: isSelected,
              onSelected: (_) => onSelected(range),
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.primary.withValues(alpha: 0.15),
              labelStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
          );
        }).toList(),
      ),
    );
  }
}
