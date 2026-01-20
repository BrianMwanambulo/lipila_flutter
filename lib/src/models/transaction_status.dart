/// Transaction status enumeration
enum TransactionStatusEnum {
  /// Transaction was successful
  successful('Successful'),

  /// Transaction is pending
  pending('Pending'),

  /// Transaction failed
  failed('Failed'),

  /// Transaction was cancelled
  cancelled('Cancelled');

  const TransactionStatusEnum(this.value);

  /// String value
  final String value;

  /// Create from string
  static TransactionStatusEnum fromString(String value) {
    return TransactionStatusEnum.values.firstWhere(
      (status) => status.value.toLowerCase() == value.toLowerCase(),
      orElse: () => TransactionStatusEnum.pending,
    );
  }

  @override
  String toString() => value;
}

/// Transaction status response
class TransactionStatus {
  /// Creates a new transaction status
  const TransactionStatus({
    required this.referenceId,
    required this.status,
    required this.amount,
    required this.accountNumber,
    required this.paymentType,
    this.message,
    this.currency,
    this.createdAt,
  });

  /// Create from JSON
  factory TransactionStatus.fromJson(Map<String, dynamic> json) {
    return TransactionStatus(
      referenceId: json['referenceId'] as String? ?? '',
      status: TransactionStatusEnum.fromString(
        json['status'] as String? ?? 'Pending',
      ),
      amount: _parseDouble(json['amount']),
      accountNumber: json['accountNumber'] as String? ?? '',
      paymentType: json['paymentType'] as String? ?? '',
      message: json['message'] as String?,
      currency: json['currency'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  /// Reference ID
  final String referenceId;

  /// Transaction status
  final TransactionStatusEnum status;

  /// Transaction amount
  final double amount;

  /// Account number
  final String accountNumber;

  /// Payment type
  final String paymentType;

  /// Status message
  final String? message;

  /// Currency code
  final String? currency;

  /// Creation timestamp
  final DateTime? createdAt;

  /// Check if transaction is successful
  bool get isSuccessful => status == TransactionStatusEnum.successful;

  /// Check if transaction is pending
  bool get isPending => status == TransactionStatusEnum.pending;

  /// Check if transaction failed
  bool get isFailed => status == TransactionStatusEnum.failed;

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'status': status.value,
        'amount': amount,
        'accountNumber': accountNumber,
        'paymentType': paymentType,
        if (message != null) 'message': message,
        if (currency != null) 'currency': currency,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      };

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  String toString() =>
      'TransactionStatus(ref: $referenceId, status: ${status.value}, amount: $amount)';
}
