import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../theme/app_colors.dart';

class GlucoseValue extends StatelessWidget {
  final int sgv;
  final String? direction;
  final double? fontSize;
  final bool showLabel;
  final bool showTrendArrow;

  const GlucoseValue({
    super.key,
    required this.sgv,
    this.direction,
    this.fontSize,
    this.showLabel = true,
    this.showTrendArrow = true,
  });

  String get _trendArrow {
    switch (direction?.toUpperCase()) {
      case 'DOUBLEUP':
      case 'SINGLEUP':
      case 'FORTYFIVEUP':
        return '↗';
      case 'FLAT':
        return '→';
      case 'FORTYFIVEDOWN':
      case 'SINGLEDOWN':
      case 'DOUBLEDOWN':
        return '↘';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors.glucoseColor(sgv.toDouble());
    final label = AppColors.glucoseLabel(sgv.toDouble());
    final size = fontSize ?? 48;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$sgv',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: size,
                fontWeight: FontWeight.w700,
                color: color,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            if (showTrendArrow && _trendArrow.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                _trendArrow,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: size * 0.6,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ],
        ),
        if (showLabel)
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: size * 0.25,
              fontWeight: FontWeight.w500,
              color: color.withValues(alpha: 0.8),
            ),
          ),
      ],
    );
  }
}
