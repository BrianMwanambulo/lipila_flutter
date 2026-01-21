class CardCollectionRequest {
  CardCollectionRequest({
    CustomerInfo? customerInfo,
    CollectionRequest? collectionRequest,
  }) {
    _customerInfo = customerInfo;
    _collectionRequest = collectionRequest;
  }

  CardCollectionRequest.fromJson(Map<String, dynamic> json) {
    _customerInfo = json['customerInfo'] != null
        ? CustomerInfo.fromJson(json['customerInfo'] as Map<String, dynamic>)
        : null;
    _collectionRequest = json['collectionRequest'] != null
        ? CollectionRequest.fromJson(
            json['collectionRequest'] as Map<String, dynamic>)
        : null;
  }

  CustomerInfo? _customerInfo;
  CollectionRequest? _collectionRequest;

  CardCollectionRequest copyWith({
    CustomerInfo? customerInfo,
    CollectionRequest? collectionRequest,
  }) =>
      CardCollectionRequest(
        customerInfo: customerInfo ?? _customerInfo,
        collectionRequest: collectionRequest ?? _collectionRequest,
      );

  CustomerInfo? get customerInfo => _customerInfo;

  CollectionRequest? get collectionRequest => _collectionRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_customerInfo != null) {
      map['customerInfo'] = _customerInfo?.toJson();
    }
    if (_collectionRequest != null) {
      map['collectionRequest'] = _collectionRequest?.toJson();
    }
    return map;
  }
}

class CollectionRequest {
  CollectionRequest({
    String? referenceId,
    num? amount,
    String? narration,
    String? accountNumber,
    String? currency,
    String? backUrl,
    String? redirectUrl,
  }) {
    _referenceId = referenceId;
    _amount = amount;
    _narration = narration;
    _accountNumber = accountNumber;
    _currency = currency;
    _backUrl = backUrl;
    _redirectUrl = redirectUrl;
  }

  CollectionRequest.fromJson(Map<String, dynamic> json) {
    _referenceId = json['referenceId'] as String?;
    _amount = json['amount'] as num?;
    _narration = json['narration'] as String?;
    _accountNumber = json['accountNumber'] as String?;
    _currency = json['currency'] as String?;
    _backUrl = json['backUrl'] as String?;
    _redirectUrl = json['redirectUrl'] as String?;
  }

  String? _referenceId;
  num? _amount;
  String? _narration;
  String? _accountNumber;
  String? _currency;
  String? _backUrl;
  String? _redirectUrl;

  CollectionRequest copyWith({
    String? referenceId,
    num? amount,
    String? narration,
    String? accountNumber,
    String? currency,
    String? backUrl,
    String? redirectUrl,
  }) =>
      CollectionRequest(
        referenceId: referenceId ?? _referenceId,
        amount: amount ?? _amount,
        narration: narration ?? _narration,
        accountNumber: accountNumber ?? _accountNumber,
        currency: currency ?? _currency,
        backUrl: backUrl ?? _backUrl,
        redirectUrl: redirectUrl ?? _redirectUrl,
      );

  String? get referenceId => _referenceId;

  num? get amount => _amount;

  String? get narration => _narration;

  String? get accountNumber => _accountNumber;

  String? get currency => _currency;

  String? get backUrl => _backUrl;

  String? get redirectUrl => _redirectUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referenceId'] = _referenceId;
    map['amount'] = _amount;
    map['narration'] = _narration;
    map['accountNumber'] = _accountNumber;
    map['currency'] = _currency;
    map['backUrl'] = _backUrl;
    map['redirectUrl'] = _redirectUrl;
    return map;
  }
}

class CustomerInfo {
  CustomerInfo({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? city,
    String? country,
    String? address,
    String? zip,
    String? email,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _city = city;
    _country = country;
    _address = address;
    _zip = zip;
    _email = email;
  }

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    _firstName = json['firstName'] as String?;
    _lastName = json['lastName'] as String?;
    _phoneNumber = json['phoneNumber'] as String?;
    _city = json['city'] as String?;
    _country = json['country'] as String?;
    _address = json['address'] as String?;
    _zip = json['zip'] as String?;
    _email = json['email'] as String?;
  }

  String? _firstName;
  String? _lastName;
  String? _phoneNumber;
  String? _city;
  String? _country;
  String? _address;
  String? _zip;
  String? _email;

  CustomerInfo copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? city,
    String? country,
    String? address,
    String? zip,
    String? email,
  }) =>
      CustomerInfo(
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        phoneNumber: phoneNumber ?? _phoneNumber,
        city: city ?? _city,
        country: country ?? _country,
        address: address ?? _address,
        zip: zip ?? _zip,
        email: email ?? _email,
      );

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get phoneNumber => _phoneNumber;

  String? get city => _city;

  String? get country => _country;

  String? get address => _address;

  String? get zip => _zip;

  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['phoneNumber'] = _phoneNumber;
    map['city'] = _city;
    map['country'] = _country;
    map['address'] = _address;
    map['zip'] = _zip;
    map['email'] = _email;
    return map;
  }
}
