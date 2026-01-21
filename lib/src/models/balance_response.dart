class BalanceResponse {
  BalanceResponse({
      bool? success, 
      String? message, 
      Data? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  BalanceResponse.fromJson(Map<String,dynamic> json) {
    _success = json['success'] as bool?;
    _message = json['message'] as String?;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  String? _message;
  Data? _data;
BalanceResponse copyWith({  bool? success,
  String? message,
  Data? data,
}) => BalanceResponse(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get success => _success;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      num? balance,}){
    _balance = balance;
}

  Data.fromJson(dynamic json) {
    _balance = json['balance'] as num?;
  }
  num? _balance;
Data copyWith({  num? balance,
}) => Data(  balance: balance ?? _balance,
);
  num? get balance => _balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = _balance;
    return map;
  }

}