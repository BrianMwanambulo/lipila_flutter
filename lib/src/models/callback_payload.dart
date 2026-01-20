/// Callback payload from Lipila webhooks
class CallbackPayload {
  /// Creates a new callback payload
  const CallbackPayload({
    required this.referenceId,
    required this.currency,
    required this.amount,
    required this.accountNumber,
    required this.status,
    required this.paymentType,
    required this.type,
    required this.ipAddress,
    required this.identifier,
    required this.message,
    this.externalId,
  });

  /// Create from JSON webhook payload
  factory CallbackPayload.fromJson(Map<String, dynamic> json) {
    return CallbackPayload(
      referenceId: json['referenceId'] as String? ?? '',
      currency: json['currency'] as String? ?? 'ZMW',
      amount: _parseDouble(json['amount']),
      accountNumber: json['accountNumber'] as String? ?? '',
      status: json['status'] as String? ?? '',
      paymentType: json['paymentType'] as String? ?? '',
      type: json['type'] as String? ?? '',
      ipAddress: json['ipAddress'] as String? ?? '',
      identifier: json['identifier'] as String? ?? '',
      message: json['message'] as String? ?? '',
      externalId: json['externalId'] as String?,
    );
  }

  /// Reference ID
  final String referenceId;

  /// Currency code
  final String currency;

  /// Transaction amount
  final double amount;

  /// Account number
  final String accountNumber;

  /// Transaction status
  final String status;

  /// Payment type
  final String paymentType;

  /// Transaction type (collection/disbursement)
  final String type;

  /// IP address
  final String ipAddress;

  /// Transaction identifier
  final String identifier;

  /// Status message
  final String message;

  /// External ID (if any)
  final String? externalId;

  /// Check if transaction was successful
  bool get isSuccessful => status.toLowerCase() == 'successful';

  /// Check if transaction failed
  bool get isFailed => status.toLowerCase() == 'failed';

  /// Check if transaction is pending
  bool get isPending => status.toLowerCase() == 'pending';

  /// Check if this is a collection callback
  bool get isCollection => type.toLowerCase() == 'collection';

  /// Check if this is a disbursement callback
  bool get isDisbursement => type.toLowerCase() == 'disbursement';

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'currency': currency,
        'amount': amount,
        'accountNumber': accountNumber,
        'status': status,
        'paymentType': paymentType,
        'type': type,
        'ipAddress': ipAddress,
        'identifier': identifier,
        'message': message,
        if (externalId != null) 'externalId': externalId,
      };

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  String toString() =>
      'CallbackPayload(ref: $referenceId, status: $status, amount: $amount, type: $type)';
}
