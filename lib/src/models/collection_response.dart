class CollectionResponse {
  CollectionResponse({
      String? currency, 
      num? amount, 
      String? accountNumber, 
      String? status, 
      String? paymentType, 
      String? ipAddress, 
      String? cardRedirectionUrl,
      String? createdAt, 
      String? referenceId, 
      String? identifier, 
      String? message,}){
    _currency = currency;
    _amount = amount;
    _accountNumber = accountNumber;
    _status = status;
    _paymentType = paymentType;
    _ipAddress = ipAddress;
    _cardRedirectionUrl = cardRedirectionUrl;
    _createdAt = createdAt;
    _referenceId = referenceId;
    _identifier = identifier;
    _message = message;
}

  CollectionResponse.fromJson(dynamic json) {
    _currency = json['currency'] as String?;
    _amount = json['amount'] as num?;
    _accountNumber = json['accountNumber'] as String?;
    _status = json['status'] as String?;
    _paymentType = json['paymentType'] as String?;
    _ipAddress = json['ipAddress'] as String?;
    _cardRedirectionUrl = json['cardRedirectionUrl'] as String?;
    _createdAt = json['createdAt'] as String?;
    _referenceId = json['referenceId'] as String?;
    _identifier = json['identifier'] as String?;
    _message = json['message'] as String?;
  }
  String? _currency;
  num? _amount;
  String? _accountNumber;
  String? _status;
  String? _paymentType;
  String? _ipAddress;
  String? _cardRedirectionUrl;
  String? _createdAt;
  String? _referenceId;
  String? _identifier;
  String? _message;
CollectionResponse copyWith({  String? currency,
  num? amount,
  String? accountNumber,
  String? status,
  String? paymentType,
  String? ipAddress,
  String? cardRedirectionUrl,
  String? createdAt,
  String? referenceId,
  String? identifier,
  String? message,
}) => CollectionResponse(  currency: currency ?? _currency,
  amount: amount ?? _amount,
  accountNumber: accountNumber ?? _accountNumber,
  status: status ?? _status,
  paymentType: paymentType ?? _paymentType,
  ipAddress: ipAddress ?? _ipAddress,
  cardRedirectionUrl: cardRedirectionUrl ?? _cardRedirectionUrl,
  createdAt: createdAt ?? _createdAt,
  referenceId: referenceId ?? _referenceId,
  identifier: identifier ?? _identifier,
  message: message ?? _message,
);
  String? get currency => _currency;
  num? get amount => _amount;
  String? get accountNumber => _accountNumber;
  String? get status => _status;
  String? get paymentType => _paymentType;
  String? get ipAddress => _ipAddress;
  String? get cardRedirectionUrl => _cardRedirectionUrl;
  String? get createdAt => _createdAt;
  String? get referenceId => _referenceId;
  String? get identifier => _identifier;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = _currency;
    map['amount'] = _amount;
    map['accountNumber'] = _accountNumber;
    map['status'] = _status;
    map['paymentType'] = _paymentType;
    map['ipAddress'] = _ipAddress;
    map['cardRedirectionUrl'] = _cardRedirectionUrl;
    map['createdAt'] = _createdAt;
    map['referenceId'] = _referenceId;
    map['identifier'] = _identifier;
    map['message'] = _message;
    return map;
  }

}