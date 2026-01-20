import '../exceptions/lipila_exception.dart';
import '../utils/validators.dart';

/// Request for creating a mobile money disbursement
class DisbursementRequest {
  /// Creates a new disbursement request
  DisbursementRequest({
    required this.referenceId,
    required this.amount,
    required this.accountNumber,
    required this.currency,
    required this.narration,
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

  /// Amount to disburse
  final double amount;

  /// Recipient's account number (phone number for mobile money)
  final String accountNumber;

  /// Currency code (e.g., ZMW, USD)
  final String currency;

  /// Transaction narration/description
  final String narration;

  /// Callback URL for transaction updates
  final String? callbackUrl;

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'amount': amount,
        'accountNumber': accountNumber,
        'currency': currency.toUpperCase(),
        'narration': narration,
        if (callbackUrl != null) 'callbackUrl': callbackUrl,
      };

  @override
  String toString() =>
      'DisbursementRequest(ref: $referenceId, amount: $amount, account: $accountNumber)';
}

/// Request for creating a bank disbursement
class BankDisbursementRequest {
  /// Creates a new bank disbursement request
  BankDisbursementRequest({
    required this.referenceId,
    required this.amount,
    required this.accountNumber,
    required this.currency,
    required this.swiftCode,
    required this.firstName,
    required this.lastName,
    required this.accountHolderName,
    required this.phoneNumber,
    this.email,
    this.narration,
    this.callbackUrl,
  }) {
    // Validate inputs
    Validators.validateReferenceId(referenceId);
    Validators.validateAmount(amount);
    Validators.validateAccountNumber(accountNumber);
    Validators.validateCurrency(currency);
    Validators.validateSwiftCode(swiftCode);

    if (email != null && !Validators.isValidEmail(email!)) {
      throw const ValidationException(
        'Invalid email format',
        {'email': 'Must be a valid email address'},
      );
    }
  }

  /// Unique reference ID for the transaction
  final String referenceId;

  /// Amount to disburse
  final double amount;

  /// Bank account number
  final String accountNumber;

  /// Currency code (e.g., ZMW, USD)
  final String currency;

  /// Bank SWIFT code
  final String swiftCode;

  /// Account holder's first name
  final String firstName;

  /// Account holder's last name
  final String lastName;

  /// Account holder's full name
  final String accountHolderName;

  /// Contact phone number
  final String phoneNumber;

  /// Email address (optional)
  final String? email;

  /// Transaction narration/description
  final String? narration;

  /// Callback URL for transaction updates
  final String? callbackUrl;

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'amount': amount,
        'accountNumber': accountNumber,
        'currency': currency.toUpperCase(),
        'swiftCode': swiftCode,
        'firstName': firstName,
        'lastName': lastName,
        'accountHolderName': accountHolderName,
        'phoneNumber': phoneNumber,
        if (email != null) 'email': email,
        if (narration != null) 'narration': narration,
        if (callbackUrl != null) 'callbackUrl': callbackUrl,
      };

  @override
  String toString() =>
      'BankDisbursementRequest(ref: $referenceId, amount: $amount, account: $accountNumber)';
}
