import 'payment_type.dart';

/// Response from disbursement API
class DisbursementResponse {
  /// Creates a new disbursement response
  const DisbursementResponse({
    required this.referenceId,
    required this.status,
    required this.identifier,
    required this.paymentType,
    required this.createdAt,
    this.message,
  });

  /// Create from JSON
  factory DisbursementResponse.fromJson(Map<String, dynamic> json) {
    return DisbursementResponse(
      referenceId: json['referenceId'] as String? ?? '',
      status: json['status'] as String? ?? 'Pending',
      identifier: json['identifier'] as String? ?? '',
      paymentType: PaymentType.fromString(
        json['paymentType'] as String? ?? 'Mobile',
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      message: json['message'] as String?,
    );
  }

  /// Reference ID
  final String referenceId;

  /// Transaction status
  final String status;

  /// Transaction identifier
  final String identifier;

  /// Payment type
  final PaymentType paymentType;

  /// Creation timestamp
  final DateTime createdAt;

  /// Response message
  final String? message;

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'status': status,
        'identifier': identifier,
        'paymentType': paymentType.value,
        'createdAt': createdAt.toIso8601String(),
        if (message != null) 'message': message,
      };

  @override
  String toString() =>
      'DisbursementResponse(ref: $referenceId, status: $status, identifier: $identifier)';
}
