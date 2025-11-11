import 'package:flutter/material.dart';

class AppLogger {
  static void logError(String message, [Object? error, StackTrace? stack]) {
    debugPrint('❌ ERROR: $message');
    if (error != null) debugPrint('   Details: $error');
  }

  static void logInfo(String message) {
    debugPrint('ℹ️ INFO: $message');
  }
}
