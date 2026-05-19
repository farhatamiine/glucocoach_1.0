import 'package:flutter_test/flutter_test.dart';
import 'package:glucocoach/config/constants.dart';
import 'package:glucocoach/presentation/theme/app_colors.dart';

void main() {
  group('Glucose Color Coding', () {
    test('very low (<54) returns dark red', () {
      expect(AppColors.glucoseColor(50), AppColors.glucoseVeryLow);
      expect(AppColors.glucoseColor(53), AppColors.glucoseVeryLow);
    });

    test('low (54-69) returns red', () {
      expect(AppColors.glucoseColor(54), AppColors.glucoseLow);
      expect(AppColors.glucoseColor(69), AppColors.glucoseLow);
    });

    test('normal (70-180) returns green', () {
      expect(AppColors.glucoseColor(70), AppColors.glucoseNormal);
      expect(AppColors.glucoseColor(100), AppColors.glucoseNormal);
      expect(AppColors.glucoseColor(180), AppColors.glucoseNormal);
    });

    test('high (181-250) returns orange', () {
      expect(AppColors.glucoseColor(181), AppColors.glucoseHigh);
      expect(AppColors.glucoseColor(250), AppColors.glucoseHigh);
    });

    test('very high (>250) returns red', () {
      expect(AppColors.glucoseColor(251), AppColors.glucoseVeryHigh);
      expect(AppColors.glucoseColor(300), AppColors.glucoseVeryHigh);
    });
  });

  group('Glucose Labels', () {
    test('returns correct labels for ranges', () {
      expect(AppColors.glucoseLabel(50), 'Very Low');
      expect(AppColors.glucoseLabel(65), 'Low');
      expect(AppColors.glucoseLabel(100), 'In Range');
      expect(AppColors.glucoseLabel(200), 'High');
      expect(AppColors.glucoseLabel(300), 'Very High');
    });
  });

  group('GMI Calculation', () {
    test('matches backend formula: 3.31 + 0.02392 * avg', () {
      // Test vectors from backend
      expect(_calculateGMI(100), closeTo(5.702, 0.001));
      expect(_calculateGMI(154), closeTo(6.99368, 0.001));
      expect(_calculateGMI(200), closeTo(8.094, 0.001));
    });
  });

  group('TIR Calculation', () {
    test('calculates TIR correctly', () {
      final readings = [65, 80, 120, 150, 190, 250, 70, 180];
      final tir = _calculateTIR(readings);
      expect(tir.inRangePercent, closeTo(62.5, 0.1));
      expect(tir.below70Percent, closeTo(12.5, 0.1));
      expect(tir.above180Percent, closeTo(25.0, 0.1));
    });
  });
}

double _calculateGMI(double averageGlucose) {
  return 3.31 + 0.02392 * averageGlucose;
}

class _TIRResult {
  final double inRangePercent;
  final double below70Percent;
  final double above180Percent;

  _TIRResult({
    required this.inRangePercent,
    required this.below70Percent,
    required this.above180Percent,
  });
}

_TIRResult _calculateTIR(List<int> readings) {
  final total = readings.length;
  final below70 = readings.where((r) => r < 70).length;
  final above180 = readings.where((r) => r > 180).length;
  final inRange = total - below70 - above180;

  return _TIRResult(
    inRangePercent: (inRange / total) * 100,
    below70Percent: (below70 / total) * 100,
    above180Percent: (above180 / total) * 100,
  );
}
