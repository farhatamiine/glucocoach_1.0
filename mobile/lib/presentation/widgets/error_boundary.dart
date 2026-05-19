import 'package:flutter/material.dart';

class ErrorBoundary extends StatelessWidget {
  final Widget child;

  const ErrorBoundary({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class GlobalErrorHandler {
  static void setup() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      // Log to crash reporting service
    };
  }
}
