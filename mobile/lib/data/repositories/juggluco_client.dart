import 'package:dio/dio.dart';

import '../models/juggluco.dart';

/// Client for Juggluco's local web server.
///
/// Juggluco runs an HTTP server on the phone (default port 17580)
/// that streams CGM data. This client fetches from it directly
/// without authentication — useful when offline or without 5G.
///
/// Endpoint: http://127.0.0.1:17580/x/stream?header&mg/dL
/// Returns TSV with columns: SensorId nr UnixTime YYYY-mm-dd-HH:MM:SS TZ Min mg/dL Rate ChangeLabel
class JugglucoClient {
  static const String _defaultBaseUrl = 'http://127.0.0.1:17580';
  static const String _streamPath = '/x/stream';

  final Dio _dio;

  JugglucoClient({Dio? dio, String? baseUrl})
    : _dio = dio ?? _createDio(baseUrl: baseUrl);

  static Dio _createDio({String? baseUrl}) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl ?? _defaultBaseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          'Accept': 'text/plain',
        },
      ),
    );
  }

  /// Fetches the latest glucose stream from Juggluco.
  ///
  /// [header] — include column headers in response (default true)
  /// [mgDl]   — return values in mg/dL (default true)
  ///
  /// Returns the most recent valid reading, or null if:
  /// - Juggluco server is not reachable
  /// - No valid readings in the stream
  Future<JugglucoReading?> getLatestReading({
    bool header = true,
    bool mgDl = true,
  }) async {
    final query = <String, dynamic>{};
    if (header) query['header'] = '';
    if (mgDl) query['mg/dL'] = '';

    try {
      final response = await _dio.get<String>(
        _streamPath,
        queryParameters: query,
      );

      final body = response.data;
      if (body == null || body.isEmpty) return null;

      // Parse TSV: last line is the most recent reading
      final lines = body.split('\n');
      JugglucoReading? latest;

      for (final line in lines.reversed) {
        final reading = JugglucoReading.fromTsvLine(line);
        if (reading != null && reading.isValid) {
          latest = reading;
          break;
        }
      }

      return latest;
    } on DioException catch (_) {
      // Juggluco server not available (offline, not running, etc.)
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Fetches multiple recent readings from the stream.
  ///
  /// [count] — maximum number of readings to return (default 24)
  Future<List<JugglucoReading>> getRecentReadings({
    bool header = true,
    bool mgDl = true,
    int count = 24,
  }) async {
    final query = <String, dynamic>{};
    if (header) query['header'] = '';
    if (mgDl) query['mg/dL'] = '';

    try {
      final response = await _dio.get<String>(
        _streamPath,
        queryParameters: query,
      );

      final body = response.data;
      if (body == null || body.isEmpty) return [];

      final lines = body.split('\n');
      final readings = <JugglucoReading>[];

      for (final line in lines.reversed) {
        if (readings.length >= count) break;
        final reading = JugglucoReading.fromTsvLine(line);
        if (reading != null && reading.isValid) {
          readings.add(reading);
        }
      }

      return readings.reversed.toList();
    } on DioException catch (_) {
      return [];
    } catch (_) {
      return [];
    }
  }

  /// Checks if the Juggluco server is reachable.
  Future<bool> isAvailable() async {
    try {
      final response = await _dio.get<String>(_streamPath);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
