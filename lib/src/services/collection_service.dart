import 'package:lipila_flutter/src/client/endpoints.dart';
import 'package:lipila_flutter/src/client/http_client.dart';
import 'package:lipila_flutter/src/exceptions/lipila_exception.dart';
import 'package:lipila_flutter/src/models/collection_request.dart';
import 'package:lipila_flutter/src/models/collection_response.dart';

/// Service for collection operations
class CollectionService {
  /// Creates a new collection service
  const CollectionService(this._httpClient);

  final HttpClient _httpClient;

  /// Create a mobile money collection
  ///
  /// Initiates a collection request from a customer's mobile money account.
  ///
  /// [referenceId] - Unique reference for this transaction
  /// [amount] - Amount to collect
  /// [accountNumber] - Customer's phone number
  /// [currency] - Currency code (ZMW, USD, etc.)
  /// [callbackUrl] - Optional callback URL for transaction updates
  ///
  /// Throws [ValidationException] if parameters are invalid.
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  Future<CollectionResponse> createCollection({
    required String referenceId,
    required double amount,
    required String accountNumber,
    required String currency,
    String? callbackUrl,
  }) async {
    final request = CollectionRequest(
      referenceId: referenceId,
      amount: amount,
      accountNumber: accountNumber,
      currency: currency,
      callbackUrl: callbackUrl,
    );

    final response = await _httpClient.post(
      Endpoints.collections,
      request.toJson(),
    );

    return CollectionResponse.fromJson(response);
  }

  /// Create a card collection
  ///
  /// Initiates a card payment collection. Returns a checkout URL
  /// that the customer can use to complete the payment.
  ///
  /// [referenceId] - Unique reference for this transaction
  /// [amount] - Amount to collect
  /// [currency] - Currency code (ZMW, USD, etc.)
  /// [callbackUrl] - Optional callback URL for transaction updates
  ///
  /// Throws [ValidationException] if parameters are invalid.
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  Future<CollectionResponse> createCardCollection({
    required String referenceId,
    required double amount,
    required String currency,
    String? callbackUrl,
  }) async {
    final request = CardCollectionRequest(
      referenceId: referenceId,
      amount: amount,
      currency: currency,
      callbackUrl: callbackUrl,
    );

    final response = await _httpClient.post(
      Endpoints.collections,
      request.toJson(),
    );

    return CollectionResponse.fromJson(response);
  }
}
