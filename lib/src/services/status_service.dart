import 'package:lipila_flutter/src/client/endpoints.dart';
import 'package:lipila_flutter/src/client/http_client.dart';
import 'package:lipila_flutter/src/exceptions/lipila_exception.dart';
import 'package:lipila_flutter/src/models/transaction_status.dart';

/// Service for checking transaction status
class StatusService {
  /// Creates a new status service
  const StatusService(this._httpClient);

  final HttpClient _httpClient;

  /// Check collection transaction status
  ///
  /// Queries the status of a collection transaction.
  ///
  /// [referenceId] - Reference ID of the transaction to check
  ///
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  Future<TransactionStatus> checkCollectionStatus(String referenceId) async {
    final response = await _httpClient.get(
      '${Endpoints.collectionStatus}/$referenceId',
    );
    return TransactionStatus.fromJson(response);
  }

  /// Check disbursement transaction status
  ///
  /// Queries the status of a disbursement transaction.
  ///
  /// [referenceId] - Reference ID of the transaction to check
  ///
  /// Throws [AuthException] if API key is invalid.
  /// Throws [ApiException] if the request fails.
  Future<TransactionStatus> checkDisbursementStatus(String referenceId) async {
    final response = await _httpClient.get(
      '${Endpoints.disbursementStatus}/$referenceId',
    );
    return TransactionStatus.fromJson(response);
  }
}
