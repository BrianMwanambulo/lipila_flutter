class DisbursementResponse {
  DisbursementResponse({
    num? amount,
    dynamic externalId,
    String? narration,
    String? ipAddress,
    String? referenceId,
    String? status,
    String? currency,
    String? type,
    String? accountNumber,
    String? paymentType,
    String? createdAt,
    String? identifier,
  }) {
    _amount = amount;
    _externalId = externalId;
    _narration = narration;
    _ipAddress = ipAddress;
    _referenceId = referenceId;
    _status = status;
    _currency = currency;
    _type = type;
    _accountNumber = accountNumber;
    _paymentType = paymentType;
    _createdAt = createdAt;
    _identifier = identifier;
  }

  DisbursementResponse.fromJson(dynamic json) {
    _amount = json['amount'] as num?;
    _externalId = json['externalId'] as String?;
    _narration = json['narration'] as String?;
    _ipAddress = json['ipAddress'] as String?;
    _referenceId = json['referenceId'] as String?;
    _status = json['status'] as String?;
    _currency = json['currency'] as String?;
    _type = json['type'] as String?;
    _accountNumber = json['accountNumber'] as String?;
    _paymentType = json['paymentType'] as String?;
    _createdAt = json['createdAt'] as String?;
    _identifier = json['identifier'] as String?;
  }

  num? _amount;
  dynamic _externalId;
  String? _narration;
  String? _ipAddress;
  String? _referenceId;
  String? _status;
  String? _currency;
  String? _type;
  String? _accountNumber;
  String? _paymentType;
  String? _createdAt;
  String? _identifier;

  DisbursementResponse copyWith({
    num? amount,
    dynamic externalId,
    String? narration,
    String? ipAddress,
    String? referenceId,
    String? status,
    String? currency,
    String? type,
    String? accountNumber,
    String? paymentType,
    String? createdAt,
    String? identifier,
  }) =>
      DisbursementResponse(
        amount: amount ?? _amount,
        externalId: externalId ?? _externalId,
        narration: narration ?? _narration,
        ipAddress: ipAddress ?? _ipAddress,
        referenceId: referenceId ?? _referenceId,
        status: status ?? _status,
        currency: currency ?? _currency,
        type: type ?? _type,
        accountNumber: accountNumber ?? _accountNumber,
        paymentType: paymentType ?? _paymentType,
        createdAt: createdAt ?? _createdAt,
        identifier: identifier ?? _identifier,
      );

  num? get amount => _amount;

  dynamic get externalId => _externalId;

  String? get narration => _narration;

  String? get ipAddress => _ipAddress;

  String? get referenceId => _referenceId;

  String? get status => _status;

  String? get currency => _currency;

  String? get type => _type;

  String? get accountNumber => _accountNumber;

  String? get paymentType => _paymentType;

  String? get createdAt => _createdAt;

  String? get identifier => _identifier;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    map['externalId'] = _externalId;
    map['narration'] = _narration;
    map['ipAddress'] = _ipAddress;
    map['referenceId'] = _referenceId;
    map['status'] = _status;
    map['currency'] = _currency;
    map['type'] = _type;
    map['accountNumber'] = _accountNumber;
    map['paymentType'] = _paymentType;
    map['createdAt'] = _createdAt;
    map['identifier'] = _identifier;
    return map;
  }
}
