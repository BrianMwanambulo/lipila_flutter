import 'package:lipila_flutter/lipila_flutter.dart';

class MobileMoneyCollectionRequest {
  MobileMoneyCollectionRequest({
    String? referenceId,
    num? amount,
    String? narration,
    String? accountNumber,
    String? currency,
    String? email,
  }) {
    Validators.validateAmount(amount ?? 0);
    Validators.validateAccountNumber(accountNumber??'');
    Validators.validateCurrency(currency??'');
    Validators.validateReferenceId(referenceId??'');

    _referenceId = referenceId;
    _amount = amount;
    _narration = narration;
    _accountNumber = accountNumber;
    _currency = currency;
    _email = email;
  }

  MobileMoneyCollectionRequest.fromJson(Map<String, dynamic> json) {
    _referenceId = json['referenceId'] as String?;
    _amount = json['amount'] as num?;
    _narration = json['narration'] as String?;
    _accountNumber = json['accountNumber'] as String?;
    _currency = json['currency'] as String?;
    _email = json['email'] as String?;
  }

  String? _referenceId;
  num? _amount;
  String? _narration;
  String? _accountNumber;
  String? _currency;
  String? _email;

  MobileMoneyCollectionRequest copyWith({
    String? referenceId,
    num? amount,
    String? narration,
    String? accountNumber,
    String? currency,
    String? email,
  }) =>
      MobileMoneyCollectionRequest(
        referenceId: referenceId ?? _referenceId,
        amount: amount ?? _amount,
        narration: narration ?? _narration,
        accountNumber: accountNumber ?? _accountNumber,
        currency: currency ?? _currency,
        email: email ?? _email,
      );

  String? get referenceId => _referenceId;

  num? get amount => _amount;

  String? get narration => _narration;

  String? get accountNumber => _accountNumber;

  String? get currency => _currency;

  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referenceId'] = _referenceId;
    map['amount'] = _amount;
    map['narration'] = _narration;
    map['accountNumber'] = _accountNumber;
    map['currency'] = _currency;
    map['email'] = _email;
    return map;
  }
}
