import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:http/http.dart' as http;

import 'package:lipila_flutter/src/config/lipila_config.dart';
import 'package:lipila_flutter/src/exceptions/lipila_exception.dart';
import 'package:lipila_flutter/src/utils/logger.dart';

/// HTTP client for making API requests
class HttpClient {
  /// Creates a new HTTP client
  HttpClient(this.config, this.logger);

  /// SDK configuration
  final LipilaConfig config;

  /// Logger instance
  final LipilaLogger logger;

  /// HTTP client instance
  final http.Client _client = http.Client();

  /// Get request headers
  Map<String, String> get _headers => {
        'x-api-key': config.apiKey,
        if (config.callbackUrl != null) 'callbackUrl': config.callbackUrl!,
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  /// Make a GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('${config.baseUrl}$endpoint');

    logger.logRequest('GET', url.toString(), null);

    try {
      final headers = Map<String, String>.from(_headers)
      ..remove('content-type');

      final response =
          await _client.get(url, headers: headers).timeout(config.timeout);

      return _handleResponse(response);
    } on io.SocketException catch (e) {
      logger.logError('Network error', e);
      throw NetworkException('Network error: ${e.message}');
    } on TimeoutException {
      logger.logError('Request timeout');
      throw const TimeoutException('Request timed out');
    } catch (e) {
      logger.logError('Unexpected error', e);
      rethrow;
    }
  }

  /// Make a POST request
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('${config.baseUrl}$endpoint');

    logger.logRequest('POST', url.toString(), body);


    try {
      final response = await _client
          .post(
            url,
            headers: _headers,
            body: jsonEncode(body),
          )
          .timeout(config.timeout);

      return _handleResponse(response);
    } on io.SocketException catch (e) {
      logger.logError('Network error', e);
      throw NetworkException('Network error: ${e.message}');
    } on TimeoutException {
      logger.logError('Request timeout');
      throw const TimeoutException('Request timed out');
    } catch (e) {
      logger.logError('Unexpected error', e);
      if(e is ApiException){
        if(e.statusCode == 500){
          throw ApiException('Internal Server Error ', e.statusCode);
        }
      }
      rethrow;
    }
  }

  /// Handle HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    logger.logResponse(response.statusCode, response.body);

    // Try to parse response body
    dynamic responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (e) {
      responseBody = {'message': response.body};
    }

    // Handle successful responses
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (responseBody is Map<String, dynamic>) {
        return responseBody;
      }
      return {'data': responseBody};
    }

    // Handle error responses
    final errorMessage = _extractErrorMessage(responseBody);

    switch (response.statusCode) {
      case 401:
        throw AuthException(errorMessage ?? 'Authentication failed');
      case 400:
        throw ValidationException(
          errorMessage ?? 'Validation failed',
          _extractValidationErrors(responseBody),
        );
      case 404:
        throw ApiException(
          errorMessage ?? 'Resource not found',
          response.statusCode,
        );
      case 429:
        throw ApiException(
          errorMessage ?? 'Too many requests',
          response.statusCode,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        throw ApiException(
          errorMessage ?? 'Server error',
          response.statusCode,
        );
      default:
        throw ApiException(
          errorMessage ?? 'Request failed',
          response.statusCode,
        );
    }
  }

  /// Extract error message from response
  String? _extractErrorMessage(dynamic responseBody) {
    if (responseBody is Map<String, dynamic>) {
      return responseBody['message'] as String? ??
          responseBody['error'] as String? ??
          responseBody['msg'] as String?;
    }
    return null;
  }

  /// Extract validation errors from response
  Map<String, String> _extractValidationErrors(dynamic responseBody) {
    if (responseBody is Map<String, dynamic>) {
      final errors = responseBody['errors'];
      if (errors is Map<String, dynamic>) {
        return errors.map(
          (key, value) => MapEntry(key, value.toString()),
        );
      }
    }
    return {};
  }

  /// Close the HTTP client
  void close() {
    _client.close();
  }
}
