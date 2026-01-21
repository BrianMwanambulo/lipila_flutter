/// Debugging utilities for Lipila SDK
///
/// Use these utilities to troubleshoot connection and API issues.
library lipila_flutter_debug;

import 'package:http/http.dart' as http;

/// Debug helper for testing Lipila API connectivity
class LipilaDebug {
  /// Test if a given base URL is reachable
  ///
  /// Example:
  /// ```dart
  /// final isReachable = await LipilaDebug.testConnection('https://api.lipila.io');
  /// if (!isReachable) {
  ///   print('Cannot reach API server');
  /// }
  /// ```
  static Future<bool> testConnection(String baseUrl) async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 10));
      print('Connection test to $baseUrl: ${response.statusCode}');
      return true;
    } catch (e) {
      print('Connection test to $baseUrl failed: $e');
      return false;
    }
  }

  /// Test API key and endpoint
  ///
  /// Example:
  /// ```dart
  /// await LipilaDebug.testApiKey(
  ///   'https://api.lipila.io',
  ///   'your_api_key',
  ///   '/wallet/balance',
  /// );
  /// ```
  static Future<void> testApiKey(
    String baseUrl,
    String apiKey,
    String endpoint,
  ) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      print('Testing: $url');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
    } catch (e) {
      print('Test failed: $e');
    }
  }

  /// Print current SDK configuration
  static void printEnvironmentInfo(String baseUrl, String apiKey) {
    print('=== Lipila SDK Debug Info ===');
    print('Base URL: $baseUrl');
    print('API Key: ${apiKey.substring(0, 8)}...');
    print('API Key Format: ${apiKey.startsWith('Lsk_') ? 'Sandbox' : apiKey.startsWith('Lpk_') ? 'Production' : 'Unknown'}');
    print('============================');
  }
}
