import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveBoxes {
  static const String meals = 'meals';
  static const String boluses = 'boluses';
  static const String glucoseSummary = 'glucose_summary';
  static const String syncQueue = 'sync_queue';
  static const String alerts = 'alerts';
  static const String alertHistory = 'alert_history';

  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox<Map<String, dynamic>>(meals);
    await Hive.openBox<Map<String, dynamic>>(boluses);
    await Hive.openBox<Map<String, dynamic>>(glucoseSummary);
    await Hive.openBox<Map<String, dynamic>>(syncQueue);
    await Hive.openBox<Map<String, dynamic>>(alerts);
    await Hive.openBox<Map<String, dynamic>>(alertHistory);
  }

  static Box<Map<String, dynamic>> get mealsBox =>
      Hive.box<Map<String, dynamic>>(meals);
  static Box<Map<String, dynamic>> get bolusesBox =>
      Hive.box<Map<String, dynamic>>(boluses);
  static Box<Map<String, dynamic>> get glucoseSummaryBox =>
      Hive.box<Map<String, dynamic>>(glucoseSummary);
  static Box<Map<String, dynamic>> get syncQueueBox =>
      Hive.box<Map<String, dynamic>>(syncQueue);
  static Box<Map<String, dynamic>> get alertsBox =>
      Hive.box<Map<String, dynamic>>(alerts);
  static Box<Map<String, dynamic>> get alertHistoryBox =>
      Hive.box<Map<String, dynamic>>(alertHistory);
}
