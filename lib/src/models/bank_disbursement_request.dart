class BankDisbursementRequest {
  BankDisbursementRequest({
      String? referenceId, 
      num? amount, 
      String? narration, 
      String? accountNumber, 
      String? currency, 
      String? swiftCode, 
      String? firstName, 
      String? lastName, 
      String? phoneNumber, 
      String? accountHolderName,}){
    _referenceId = referenceId;
    _amount = amount;
    _narration = narration;
    _accountNumber = accountNumber;
    _currency = currency;
    _swiftCode = swiftCode;
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _accountHolderName = accountHolderName;
}

  BankDisbursementRequest.fromJson(dynamic json) {
    _referenceId = json['referenceId'] as String?;
    _amount = json['amount'] as num?;
    _narration = json['narration'] as String?;
    _accountNumber = json['accountNumber'] as String?;
    _currency = json['currency'] as String?;
    _swiftCode = json['swiftCode'] as String?;
    _firstName = json['firstName'] as String?;
    _lastName = json['lastName'] as String?;
    _phoneNumber = json['phoneNumber'] as String?;
    _accountHolderName = json['accountHolderName'] as String?;
  }
  String? _referenceId;
  num? _amount;
  String? _narration;
  String? _accountNumber;
  String? _currency;
  String? _swiftCode;
  String? _firstName;
  String? _lastName;
  String? _phoneNumber;
  String? _accountHolderName;
BankDisbursementRequest copyWith({  String? referenceId,
  num? amount,
  String? narration,
  String? accountNumber,
  String? currency,
  String? swiftCode,
  String? firstName,
  String? lastName,
  String? phoneNumber,
  String? accountHolderName,
}) => BankDisbursementRequest(  referenceId: referenceId ?? _referenceId,
  amount: amount ?? _amount,
  narration: narration ?? _narration,
  accountNumber: accountNumber ?? _accountNumber,
  currency: currency ?? _currency,
  swiftCode: swiftCode ?? _swiftCode,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  phoneNumber: phoneNumber ?? _phoneNumber,
  accountHolderName: accountHolderName ?? _accountHolderName,
);
  String? get referenceId => _referenceId;
  num? get amount => _amount;
  String? get narration => _narration;
  String? get accountNumber => _accountNumber;
  String? get currency => _currency;
  String? get swiftCode => _swiftCode;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get phoneNumber => _phoneNumber;
  String? get accountHolderName => _accountHolderName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referenceId'] = _referenceId;
    map['amount'] = _amount;
    map['narration'] = _narration;
    map['accountNumber'] = _accountNumber;
    map['currency'] = _currency;
    map['swiftCode'] = _swiftCode;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['phoneNumber'] = _phoneNumber;
    map['accountHolderName'] = _accountHolderName;
    return map;
  }

}