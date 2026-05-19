import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@riverpod
Stream<bool> isOnline(Ref ref) async* {
  final connectivity = Connectivity();
  
  // Initial check
  final result = await connectivity.checkConnectivity();
  yield !result.contains(ConnectivityResult.none);

  // Listen to changes
  await for (final result in connectivity.onConnectivityChanged) {
    yield !result.contains(ConnectivityResult.none);
  }
}
