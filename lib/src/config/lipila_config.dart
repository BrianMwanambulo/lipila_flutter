import 'package:lipila_flutter/src/config/environment.dart';

/// Configuration for the Lipila SDK
class LipilaConfig {
  /// Creates a new Lipila configuration
  const LipilaConfig({
    required this.apiKey,
    required this.environment,
    this.timeout = const Duration(seconds: 30),
    this.enableLogging = false,
    this.callbackUrl,
    this.logLevel = LogLevel.info,
  });

  /// API key for authentication
  final String apiKey;

  /// Environment (sandbox or production)
  final Environment environment;

  /// Request timeout duration
  final Duration timeout;

  /// Enable SDK logging
  final bool enableLogging;

  /// Log level for SDK operations
  final LogLevel logLevel;

  /// Base URL for API requests
  String get baseUrl => environment.baseUrl;

  /// callback URL for redirects
  final String? callbackUrl;
}

/// Log levels for SDK operations
enum LogLevel {
  /// No logging
  none,

  /// Only errors
  error,

  /// Warnings and errors
  warning,

  /// Info, warnings, and errors
  info,

  /// All logs including debug information
  debug,
}
