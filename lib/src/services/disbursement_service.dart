import 'package:lipila_flutter/src/client/endpoints.dart';
import 'package:lipila_flutter/src/client/http_client.dart';
import 'package:lipila_flutter/src/exceptions/lipila_exception.dart';
import 'package:lipila_flutter/src/models/disbursement_request.dart';
import 'package:lipila_flutter/src/models/disbursement_response.dart';

/// Service for disbursement operations
class DisbursementService {
  /// Creates a new disbursement service
  const DisbursementService(this._httpClient);

  final HttpClient _httpClient;

  /// Create a mobile money disbursement
  ///
  /// Sends money to a recipient's mobile money account.
  ///
  /// [referenceId] - Unique reference for this transaction
  /// [amount] - Amount to disburse
  /// [accountNumber] - Recipient's phone number
  /// [currency] - Currency code (ZMW, USD, etc.)
  /// [narration] - Transaction description
  /// [callbackUrl] - Optional callback URL for transaction updates
  ///
  /// Throws [ValidationException] if parameters are invalid.
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  Future<DisbursementResponse> createMobileDisbursement({
    required String referenceId,
    required double amount,
    required String accountNumber,
    required String currency,
    required String narration,
    String? callbackUrl,
  }) async {
    final request = DisbursementRequest(
      referenceId: referenceId,
      amount: amount,
      accountNumber: accountNumber,
      currency: currency,
      narration: narration,
      callbackUrl: callbackUrl,
    );

    final response = await _httpClient.post(
      Endpoints.disbursements,
      request.toJson(),
    );

    return DisbursementResponse.fromJson(response);
  }

  /// Create a bank disbursement
  ///
  /// Sends money to a recipient's bank account.
  ///
  /// [referenceId] - Unique reference for this transaction
  /// [amount] - Amount to disburse
  /// [accountNumber] - Bank account number
  /// [currency] - Currency code (ZMW, USD, etc.)
  /// [swiftCode] - Bank SWIFT code
  /// [firstName] - Account holder's first name
  /// [lastName] - Account holder's last name
  /// [accountHolderName] - Account holder's full name
  /// [phoneNumber] - Contact phone number
  /// [email] - Email address (optional)
  /// [narration] - Transaction description (optional)
  /// [callbackUrl] - Optional callback URL for transaction updates
  ///
  /// Throws [ValidationException] if parameters are invalid.
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  Future<DisbursementResponse> createBankDisbursement({
    required String referenceId,
    required double amount,
    required String accountNumber,
    required String currency,
    required String swiftCode,
    required String firstName,
    required String lastName,
    required String accountHolderName,
    required String phoneNumber,
    String? email,
    String? narration,
    String? callbackUrl,
  }) async {
    final request = BankDisbursementRequest(
      referenceId: referenceId,
      amount: amount,
      accountNumber: accountNumber,
      currency: currency,
      swiftCode: swiftCode,
      firstName: firstName,
      lastName: lastName,
      accountHolderName: accountHolderName,
      phoneNumber: phoneNumber,
      email: email,
      narration: narration,
      callbackUrl: callbackUrl,
    );

    final response = await _httpClient.post(
      Endpoints.bankDisbursements,
      request.toJson(),
    );

    return DisbursementResponse.fromJson(response);
  }
}
