import 'package:flutter/material.dart';

class AppColors {
  // Glucose colors
  static const Color glucoseNormal = Color(0xFF4CAF50);
  static const Color glucoseHigh = Color(0xFFFF9800);
  static const Color glucoseVeryHigh = Color(0xFFF44336);
  static const Color glucoseLow = Color(0xFFF44336);
  static const Color glucoseVeryLow = Color(0xFFB71C1C);

  // Brand
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF0D47A1);

  // Surface
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // Status
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFB8C00);
  static const Color info = Color(0xFF1E88E5);

  // Borders
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFBDBDBD);

  // Chart
  static const Color chartTargetBand = Color(0xFFE8F5E9);
  static const Color chartLine = Color(0xFF1976D2);
  static const Color chartHypoLine = Color(0xFFE53935);
  static const Color chartHyperLine = Color(0xFFFF9800);

  static Color glucoseColor(double sgv) {
    if (sgv < 54) return glucoseVeryLow;
    if (sgv < 70) return glucoseLow;
    if (sgv <= 180) return glucoseNormal;
    if (sgv <= 250) return glucoseHigh;
    return glucoseVeryHigh;
  }

  static String glucoseLabel(double sgv) {
    if (sgv < 54) return 'Very Low';
    if (sgv < 70) return 'Low';
    if (sgv <= 180) return 'In Range';
    if (sgv <= 250) return 'High';
    return 'Very High';
  }
}
