/// API endpoint constants
class Endpoints {
  Endpoints._();

  // Balance
  static const String balance = '/wallet/balance';

  // Collections
  static const String collections = '/transactions/collection';
  static const String collectionStatus = '/transactions/collection/status';

  // Disbursements
  static const String disbursements = '/transactions/disbursement';
  static const String disbursementStatus = '/transactions/disbursement/status';

  // Bank disbursements
  static const String bankDisbursements = '/transactions/bank-disbursement';
}
