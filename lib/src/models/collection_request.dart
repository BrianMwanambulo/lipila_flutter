import '../utils/validators.dart';

/// Request for creating a collection
class CollectionRequest {
  /// Creates a new collection request
  CollectionRequest({
    required this.referenceId,
    required this.amount,
    required this.accountNumber,
    required this.currency,
    this.callbackUrl,
  }) {
    // Validate inputs
    Validators.validateReferenceId(referenceId);
    Validators.validateAmount(amount);
    Validators.validateAccountNumber(accountNumber);
    Validators.validateCurrency(currency);
  }

  /// Unique reference ID for the transaction
  final String referenceId;

  /// Amount to collect
  final double amount;

  /// Customer's account number (phone number for mobile money)
  final String accountNumber;

  /// Currency code (e.g., ZMW, USD)
  final String currency;

  /// Callback URL for transaction updates
  final String? callbackUrl;

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'amount': amount,
        'accountNumber': accountNumber,
        'currency': currency.toUpperCase(),
        if (callbackUrl != null) 'callbackUrl': callbackUrl,
      };

  @override
  String toString() =>
      'CollectionRequest(ref: $referenceId, amount: $amount, account: $accountNumber)';
}

/// Request for creating a card collection
class CardCollectionRequest {
  /// Creates a new card collection request
  CardCollectionRequest({
    required this.referenceId,
    required this.amount,
    required this.currency,
    this.callbackUrl,
  }) {
    // Validate inputs
    Validators.validateReferenceId(referenceId);
    Validators.validateAmount(amount);
    Validators.validateCurrency(currency);
  }

  /// Unique reference ID for the transaction
  final String referenceId;

  /// Amount to collect
  final double amount;

  /// Currency code (e.g., ZMW, USD)
  final String currency;

  /// Callback URL for transaction updates
  final String? callbackUrl;

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'amount': amount,
        'currency': currency.toUpperCase(),
        if (callbackUrl != null) 'callbackUrl': callbackUrl,
      };

  @override
  String toString() =>
      'CardCollectionRequest(ref: $referenceId, amount: $amount)';
}
