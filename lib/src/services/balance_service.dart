import 'package:lipila_flutter/src/client/endpoints.dart';
import 'package:lipila_flutter/src/client/http_client.dart';
import 'package:lipila_flutter/src/exceptions/lipila_exception.dart';
import 'package:lipila_flutter/src/models/balance_response.dart';

/// Service for balance operations
class BalanceService {
  /// Creates a new balance service
  const BalanceService(this._httpClient);

  final HttpClient _httpClient;

  /// Get wallet balance
  ///
  /// Returns the available and booked balance of your Lipila wallet.
  ///
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  /// Throws [NetworkException] if there's a network error.
  Future<BalanceResponse> getBalance() async {
    final response = await _httpClient.get(Endpoints.balance);
    return BalanceResponse.fromJson(response);
  }
}
