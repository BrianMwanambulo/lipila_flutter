class TransactionStatus {
  TransactionStatus({
    String? referenceId,
    String? currency,
    num? amount,
    String? accountNumber,
    String? status,
    String? paymentType,
    String? type,
    String? ipAddress,
    String? identifier,
    String? externalId,
    String? message,
  }) {
    _referenceId = referenceId;
    _currency = currency;
    _amount = amount;
    _accountNumber = accountNumber;
    _status = status;
    _paymentType = paymentType;
    _type = type;
    _ipAddress = ipAddress;
    _identifier = identifier;
    _externalId = externalId;
    _message = message;
  }

  TransactionStatus.fromJson(Map<String, dynamic> json) {
    _referenceId = json['referenceId'] as String?;
    _currency = json['currency'] as String?;
    _amount = json['amount'] as num?;
    _accountNumber = json['accountNumber'] as String?;
    _status = json['status'] as String?;
    _paymentType = json['paymentType'] as String?;
    _type = json['type'] as String?;
    _ipAddress = json['ipAddress'] as String?;
    _identifier = json['identifier'] as String?;
    _externalId = json['externalId'] as String?;
    _message = json['message'] as String?;
  }

  String? _referenceId;
  String? _currency;
  num? _amount;
  String? _accountNumber;
  String? _status;
  String? _paymentType;
  String? _type;
  String? _ipAddress;
  String? _identifier;
  String? _externalId;
  String? _message;

  TransactionStatus copyWith({
    String? referenceId,
    String? currency,
    num? amount,
    String? accountNumber,
    String? status,
    String? paymentType,
    String? type,
    String? ipAddress,
    String? identifier,
    String? externalId,
    String? message,
  }) =>
      TransactionStatus(
        referenceId: referenceId ?? _referenceId,
        currency: currency ?? _currency,
        amount: amount ?? _amount,
        accountNumber: accountNumber ?? _accountNumber,
        status: status ?? _status,
        paymentType: paymentType ?? _paymentType,
        type: type ?? _type,
        ipAddress: ipAddress ?? _ipAddress,
        identifier: identifier ?? _identifier,
        externalId: externalId ?? _externalId,
        message: message ?? _message,
      );

  String? get referenceId => _referenceId;

  String? get currency => _currency;

  num? get amount => _amount;

  String? get accountNumber => _accountNumber;

  String? get status => _status;

  String? get paymentType => _paymentType;

  String? get type => _type;

  String? get ipAddress => _ipAddress;

  String? get identifier => _identifier;

  String? get externalId => _externalId;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referenceId'] = _referenceId;
    map['currency'] = _currency;
    map['amount'] = _amount;
    map['accountNumber'] = _accountNumber;
    map['status'] = _status;
    map['paymentType'] = _paymentType;
    map['type'] = _type;
    map['ipAddress'] = _ipAddress;
    map['identifier'] = _identifier;
    map['externalId'] = _externalId;
    map['message'] = _message;
    return map;
  }
}
