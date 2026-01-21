import 'package:lipila_flutter/lipila_flutter.dart';
import 'package:lipila_flutter/src/client/endpoints.dart';
import 'package:lipila_flutter/src/client/http_client.dart';
import 'package:lipila_flutter/src/exceptions/lipila_exception.dart';
import 'package:lipila_flutter/src/models/card_collection_request.dart';
import 'package:lipila_flutter/src/models/collection_response.dart';
import 'package:lipila_flutter/src/models/mobile_money_collection_request.dart';

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
  ///
  /// Throws [ValidationException] if parameters are invalid.
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  Future<CollectionResponse> createCollection({
    required String referenceId,
    required double amount,
    required String narration,
    required String accountNumber,
    required String currency,
    String? email,
  }) async {

    Validators.isValidZambianPhone(accountNumber);
    Validators.validateAmount(amount);
    Validators.validateCurrency(currency);
    Validators.validateReferenceId(referenceId);

    final request = MobileMoneyCollectionRequest(
      referenceId: referenceId,
      amount: amount,
      narration: narration,
      accountNumber: accountNumber,
      currency: currency,
      email: email,
    );

    final response = await _httpClient.post(
      Endpoints.mobileMoneyCollections,
      request.toJson(),
    );

    return CollectionResponse.fromJson(response);
  }

  /// Create a card collection
  ///
  /// Initiates a card payment collection. Returns a checkout URL
  /// that the customer can use to complete the payment.
  /// Throws [ValidationException] if parameters are invalid.
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  Future<CollectionResponse> createCardCollection({
    required CollectionRequest collectionRequest,
    required CustomerInfo customerInfo,
  }) async {
    final request = CardCollectionRequest(
      collectionRequest: collectionRequest,
      customerInfo: customerInfo,
    );

    final response = await _httpClient.post(
      Endpoints.cardCollections,
      request.toJson(),
    );

    return CollectionResponse.fromJson(response);
  }
}
