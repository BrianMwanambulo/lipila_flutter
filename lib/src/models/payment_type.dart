/// Payment type enumeration
enum PaymentType {
  /// Mobile money payment
  mobile('Mobile'),

  /// Card payment
  card('Card'),

  /// Bank transfer
  bank('Bank');

  const PaymentType(this.value);

  /// String value
  final String value;

  /// Create from string
  static PaymentType fromString(String value) {
    return PaymentType.values.firstWhere(
      (type) => type.value.toLowerCase() == value.toLowerCase(),
      orElse: () => PaymentType.mobile,
    );
  }

  @override
  String toString() => value;
}
