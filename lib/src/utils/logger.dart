import 'dart:developer' as developer;

import 'package:lipila_flutter/src/config/lipila_config.dart';

/// Logger for Lipila SDK operations
class LipilaLogger {
  /// Creates a new logger
  const LipilaLogger(this.config);

  /// SDK configuration
  final LipilaConfig config;

  /// Log a request
  void logRequest(String method, String url, Map<String, dynamic>? body) {
    if (!config.enableLogging || _shouldSkipLog(LogLevel.debug)) return;

    final message = '→ $method $url';
    if (body != null && body.isNotEmpty) {
      developer.log(
        '$message\nBody: ${_sanitizeBody(body)}',
        name: 'Lipila',
      );
    } else {
      developer.log(message, name: 'Lipila');
    }
  }

  /// Log a response
  void logResponse(int statusCode, dynamic body) {
    if (!config.enableLogging || _shouldSkipLog(LogLevel.debug)) return;

    developer.log(
      '← Response $statusCode\n${body is String ? body : body.toString()}',
      name: 'Lipila',
    );
  }

  /// Log an error
  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    if (!config.enableLogging || _shouldSkipLog(LogLevel.error)) return;

    developer.log(
      message,
      name: 'Lipila',
      error: error,
      stackTrace: stackTrace,
      level: 1000, // Error level
    );
  }

  /// Log a warning
  void logWarning(String message) {
    if (!config.enableLogging || _shouldSkipLog(LogLevel.warning)) return;

    developer.log(
      message,
      name: 'Lipila',
      level: 900, // Warning level
    );
  }

  /// Log informational message
  void logInfo(String message) {
    if (!config.enableLogging || _shouldSkipLog(LogLevel.info)) return;

    developer.log(message, name: 'Lipila');
  }

  /// Check if log should be skipped based on level
  bool _shouldSkipLog(LogLevel level) {
    final levels = LogLevel.values;
    final currentIndex = levels.indexOf(config.logLevel);
    final requestedIndex = levels.indexOf(level);
    return requestedIndex < currentIndex;
  }

  /// Sanitize request body to hide sensitive data
  Map<String, dynamic> _sanitizeBody(Map<String, dynamic> body) {
    final sanitized = Map<String, dynamic>.from(body);

    // Hide sensitive fields
    const sensitiveFields = ['apiKey', 'api_key', 'password', 'secret'];
    for (final field in sensitiveFields) {
      if (sanitized.containsKey(field)) {
        sanitized[field] = '***';
      }
    }

    return sanitized;
  }
}
