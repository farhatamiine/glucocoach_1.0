import 'dart:convert';

import 'package:hive_ce/hive.dart';

class SyncQueueItem {
  final String id;
  final String endpoint;
  final String method;
  final Map<String, dynamic> payload;
  final DateTime createdAt;

  SyncQueueItem({
    required this.id,
    required this.endpoint,
    required this.method,
    required this.payload,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'endpoint': endpoint,
        'method': method,
        'payload': payload,
        'createdAt': createdAt.toIso8601String(),
      };

  factory SyncQueueItem.fromJson(Map<String, dynamic> json) => SyncQueueItem(
        id: json['id'] as String,
        endpoint: json['endpoint'] as String,
        method: json['method'] as String,
        payload: json['payload'] as Map<String, dynamic>,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}

class SyncQueueService {
  static const String _boxName = 'sync_queue';
  Box<String>? _box;

  Future<Box<String>> get _syncBox async {
    _box ??= await Hive.openBox<String>(_boxName);
    return _box!;
  }

  Future<void> enqueue(SyncQueueItem item) async {
    final box = await _syncBox;
    await box.put(item.id, jsonEncode(item.toJson()));
  }

  Future<List<SyncQueueItem>> getPending() async {
    final box = await _syncBox;
    return box.values
        .map((v) => SyncQueueItem.fromJson(jsonDecode(v)))
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Future<void> remove(String id) async {
    final box = await _syncBox;
    await box.delete(id);
  }

  Future<void> clear() async {
    final box = await _syncBox;
    await box.clear();
  }

  Future<int> get pendingCount async {
    final box = await _syncBox;
    return box.length;
  }
}
