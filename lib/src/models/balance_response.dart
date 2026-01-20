/// Response from balance API
class BalanceResponse {
  /// Creates a new balance response
  const BalanceResponse({
    required this.availableBalance,
    required this.bookedBalance,
    required this.currency,
  });

  /// Create from JSON
  factory BalanceResponse.fromJson(Map<String, dynamic> json) {
    return BalanceResponse(
      availableBalance: _parseDouble(json['availableBalance']),
      bookedBalance: _parseDouble(json['bookedBalance']),
      currency: json['currency'] as String? ?? 'ZMW',
    );
  }

  /// Available balance
  final double availableBalance;

  /// Booked balance
  final double bookedBalance;

  /// Currency code
  final String currency;

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'availableBalance': availableBalance,
        'bookedBalance': bookedBalance,
        'currency': currency,
      };

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  String toString() =>
      'BalanceResponse(available: $availableBalance, booked: $bookedBalance, currency: $currency)';
}
