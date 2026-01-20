import 'payment_type.dart';

/// Response from collection API
class CollectionResponse {
  /// Creates a new collection response
  const CollectionResponse({
    required this.referenceId,
    required this.status,
    required this.identifier,
    required this.paymentType,
    required this.createdAt,
    this.checkoutUrl,
    this.message,
  });

  /// Create from JSON
  factory CollectionResponse.fromJson(Map<String, dynamic> json) {
    return CollectionResponse(
      referenceId: json['referenceId'] as String? ?? '',
      status: json['status'] as String? ?? 'Pending',
      identifier: json['identifier'] as String? ?? '',
      paymentType: PaymentType.fromString(
        json['paymentType'] as String? ?? 'Mobile',
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      checkoutUrl: json['checkoutUrl'] as String?,
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

  /// Checkout URL (for card payments)
  final String? checkoutUrl;

  /// Response message
  final String? message;

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'status': status,
        'identifier': identifier,
        'paymentType': paymentType.value,
        'createdAt': createdAt.toIso8601String(),
        if (checkoutUrl != null) 'checkoutUrl': checkoutUrl,
        if (message != null) 'message': message,
      };

  @override
  String toString() =>
      'CollectionResponse(ref: $referenceId, status: $status, identifier: $identifier)';
}
