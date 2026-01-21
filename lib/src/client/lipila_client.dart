import 'package:lipila_flutter/src/client/http_client.dart';
import 'package:lipila_flutter/src/config/environment.dart';
import 'package:lipila_flutter/src/config/lipila_config.dart';
import 'package:lipila_flutter/src/services/balance_service.dart';
import 'package:lipila_flutter/src/services/collection_service.dart';
import 'package:lipila_flutter/src/services/disbursement_service.dart';
import 'package:lipila_flutter/src/services/status_service.dart';
import 'package:lipila_flutter/src/utils/logger.dart';
import 'package:lipila_flutter/src/utils/validators.dart';

/// Main client for Lipila SDK
///
/// Example usage:
/// ```dart
/// final client = LipilaClient.sandbox('your-api-key');
///
/// // Get balance
/// final balance = await client.balance.getBalance();
/// print('Balance: ${balance.availableBalance} ${balance.currency}');
///
/// // Create collection
/// final collection = await client.collections.createCollection(
///   referenceId: 'ORDER-123',
///   amount: 100.0,
///   accountNumber: '260977123456',
///   currency: 'ZMW',
/// );
/// ```
class LipilaClient {
  /// Creates a new Lipila client with custom configuration
  LipilaClient({required LipilaConfig config})
      : _config = config,
        _logger = LipilaLogger(config),
        _httpClient = HttpClient(config, LipilaLogger(config)) {
    // Validate API key
    Validators.validateApiKey(config.apiKey);

    // Initialize services
    balance = BalanceService(_httpClient);
    collections = CollectionService(_httpClient);
    disbursements = DisbursementService(_httpClient);
    status = StatusService(_httpClient);
  }

  /// Creates a new Lipila client for sandbox environment
  ///
  /// Use this constructor for testing and development.
  ///
  /// [apiKey] - Your Lipila sandbox API key (starts with Lsk_)
  factory LipilaClient.sandbox(
    String apiKey, {
    Duration timeout = const Duration(seconds: 30),
    bool enableLogging = true,
    String? callbackUrl,
    LogLevel logLevel = LogLevel.debug,
  }) {
    return LipilaClient(
      config: LipilaConfig(
        apiKey: apiKey,
        environment: Environment.sandbox,
        timeout: timeout,
        callbackUrl: callbackUrl,
        enableLogging: enableLogging,
        logLevel: logLevel,
      ),
    );
  }

  /// Creates a new Lipila client for production environment
  ///
  /// Use this constructor for live transactions.
  ///
  /// [apiKey] - Your Lipila production API key (starts with Lpk_)
  factory LipilaClient.production(
    String apiKey, {
    Duration timeout = const Duration(seconds: 30),
    bool enableLogging = false,
    String ?  callbackUrl,
    LogLevel logLevel = LogLevel.error,
  }) {
    return LipilaClient(
      config: LipilaConfig(
        apiKey: apiKey,
        environment: Environment.production,
        timeout: timeout,
        callbackUrl: callbackUrl,
        enableLogging: enableLogging,
        logLevel: logLevel,
      ),
    );
  }

  final LipilaConfig _config;
  final LipilaLogger _logger;
  final HttpClient _httpClient;

  /// Balance operations
  late final BalanceService balance;

  /// Collection operations
  late final CollectionService collections;

  /// Disbursement operations
  late final DisbursementService disbursements;

  /// Transaction status operations
  late final StatusService status;

  /// Get the current configuration
  LipilaConfig get config => _config;

  /// Get the logger instance
  LipilaLogger get logger => _logger;

  /// Close the client and release resources
  void close() {
    _httpClient.close();
  }
}
