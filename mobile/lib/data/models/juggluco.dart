import 'package:freezed_annotation/freezed_annotation.dart';

part 'juggluco.freezed.dart';
part 'juggluco.g.dart';

/// Represents a single glucose reading from Juggluco's stream endpoint.
///
/// The stream returns TSV data with columns:
/// SensorId, nr, UnixTime, YYYY-mm-dd-HH:MM:SS, TZ, Min, mg/dL, Rate, ChangeLabel
///
/// Example row:
/// 30208K2RA5W  2602  1778641960  2026-05-13T05:12:40  2  2737  247  +1.41  RISING
@freezed
class JugglucoReading with _$JugglucoReading {
  const factory JugglucoReading({
    String? sensorId,
    int? nr,
    @JsonKey(name: 'unixTime') int? unixTime,
    @JsonKey(name: 'timestamp') String? timestamp,
    int? tz,
    int? min,
    @JsonKey(name: 'mg/dL') int? mgDl,
    double? rate,
    String? changeLabel,
  }) = _JugglucoReading;

  factory JugglucoReading.fromJson(Map<String, dynamic> json) =>
      _$JugglucoReadingFromJson(json);

  const JugglucoReading._();

  /// Parses a single TSV line from the Juggluco stream.
  /// Returns null if the line is empty, a comment, or cannot be parsed.
  static JugglucoReading? fromTsvLine(String line) {
    final trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.startsWith('#')) return null;

    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length < 9) return null;

    try {
      return JugglucoReading(
        sensorId: parts[0].isEmpty ? null : parts[0],
        nr: int.tryParse(parts[1]),
        unixTime: int.tryParse(parts[2]),
        timestamp: parts[3].isEmpty ? null : parts[3],
        tz: int.tryParse(parts[4]),
        min: int.tryParse(parts[5]),
        mgDl: int.tryParse(parts[6]),
        rate: double.tryParse(parts[7].replaceAll(',', '.')),
        changeLabel: parts[8].isEmpty ? null : parts[8],
      );
    } catch (_) {
      return null;
    }
  }

  /// Converts Juggluco's ChangeLabel to a Nightscout-style direction string.
  String? get direction {
    switch (changeLabel?.toUpperCase()) {
      case 'RISING':
      case 'FAST_RISING':
        return 'SINGLEUP';
      case 'SLOW_RISING':
        return 'FORTYFIVEUP';
      case 'FLAT':
        return 'FLAT';
      case 'SLOW_FALLING':
        return 'FORTYFIVEDOWN';
      case 'FALLING':
      case 'FAST_FALLING':
        return 'SINGLEDOWN';
      default:
        return null;
    }
  }

  /// The glucose value in mg/dL.
  int? get glucose => mgDl;

  /// The reading time as a DateTime.
  DateTime? get dateTime {
    if (unixTime != null) {
      return DateTime.fromMillisecondsSinceEpoch(unixTime! * 1000);
    }
    if (timestamp != null) {
      return DateTime.tryParse(timestamp!);
    }
    return null;
  }

  /// Whether this reading is considered valid (has a glucose value).
  bool get isValid => mgDl != null && mgDl! > 0;
}

/// Wrapper for the latest reading with metadata about the source.
@freezed
class JugglucoGlucose with _$JugglucoGlucose {
  const factory JugglucoGlucose({
    required int glucose,
    String? direction,
    required DateTime timestamp,
    double? rate,
    String? changeLabel,
    bool? isConnected,
  }) = _JugglucoGlucose;

  factory JugglucoGlucose.fromJson(Map<String, dynamic> json) =>
      _$JugglucoGlucoseFromJson(json);
}
