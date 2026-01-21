class DisbursementRequest {
  DisbursementRequest({
      String? referenceId, 
      num? amount, 
      String? narration, 
      String? accountNumber, 
      String? currency,}){
    _referenceId = referenceId;
    _amount = amount;
    _narration = narration;
    _accountNumber = accountNumber;
    _currency = currency;
}

  DisbursementRequest.fromJson(dynamic json) {
    _referenceId = json['referenceId'] as String?;
    _amount = json['amount'] as num?;
    _narration = json['narration'] as String?;
    _accountNumber = json['accountNumber'] as String?;
    _currency = json['currency'] as String?;
  }
  String? _referenceId;
  num? _amount;
  String? _narration;
  String? _accountNumber;
  String? _currency;
DisbursementRequest copyWith({  String? referenceId,
  num? amount,
  String? narration,
  String? accountNumber,
  String? currency,
}) => DisbursementRequest(  referenceId: referenceId ?? _referenceId,
  amount: amount ?? _amount,
  narration: narration ?? _narration,
  accountNumber: accountNumber ?? _accountNumber,
  currency: currency ?? _currency,
);
  String? get referenceId => _referenceId;
  num? get amount => _amount;
  String? get narration => _narration;
  String? get accountNumber => _accountNumber;
  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referenceId'] = _referenceId;
    map['amount'] = _amount;
    map['narration'] = _narration;
    map['accountNumber'] = _accountNumber;
    map['currency'] = _currency;
    return map;
  }

}