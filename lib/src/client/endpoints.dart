/// API endpoint constants
class Endpoints {
  Endpoints._();

  // Balance
  static const String balance = '/merchants/balance';

  // Collections
  static const String cardCollections = '/collections/card';
  static const String mobileMoneyCollections = '/collections/mobile-money';
  static const String collectionStatus = '/collections/check-status';

  // Disbursements
  static const String mobileMoneyDisbursements = '/disbursements/mobile-money';
  static const String disbursementStatus = '/disbursements/check-status';

  // Bank disbursements
  static const String bankDisbursements = '/disbursements/bank';
}
