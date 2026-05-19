import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/juggluco.dart';
import '../../data/repositories/juggluco_client.dart';

part 'juggluco_provider.g.dart';

/// The Juggluco HTTP client (no auth, local-only).
final jugglucoClientProvider = Provider<JugglucoClient>((ref) {
  return JugglucoClient();
});

/// Polls Juggluco's local server every 10 seconds for the latest glucose reading.
///
/// This provider uses a Stream to enable continuous polling. When the widget
/// is no longer listened to (autoDispose), polling stops automatically.
///
/// The returned [AsyncValue] will update every 10 seconds with fresh data.
/// A value of `null` means Juggluco is not reachable (phone server off, no sensor).
///
/// Use [ref.invalidate(jugglucoGlucoseProvider)] to force an immediate refresh.
@Riverpod(keepAlive: false)
Stream<JugglucoGlucose?> jugglucoGlucose(Ref ref) {
  final client = ref.watch(jugglucoClientProvider);

  // Create a controller so we can emit values on our own schedule
  final controller = StreamController<JugglucoGlucose?>();

  Timer? timer;
  bool isDisposed = false;

  Future<void> fetch() async {
    if (isDisposed) return;

    final reading = await client.getLatestReading();

    if (isDisposed) return;

    if (reading != null && reading.glucose != null && reading.dateTime != null) {
      controller.add(
        JugglucoGlucose(
          glucose: reading.glucose!,
          direction: reading.direction,
          timestamp: reading.dateTime!,
          rate: reading.rate,
          changeLabel: reading.changeLabel,
          isConnected: true,
        ),
      );
    } else {
      // Emit null to indicate Juggluco is not available
      controller.add(null);
    }
  }

  // Fetch immediately on first listen
  fetch();

  // Then poll every 10 seconds
  timer = Timer.periodic(const Duration(seconds: 10), (_) => fetch());

  // Clean up when the provider is disposed
  ref.onDispose(() {
    isDisposed = true;
    timer?.cancel();
    controller.close();
  });

  return controller.stream;
}
