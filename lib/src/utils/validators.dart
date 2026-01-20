import 'package:lipila_flutter/src/exceptions/lipila_exception.dart';

/// Validators for Lipila SDK
class Validators {
  Validators._();

  /// Validate a Zambian phone number
  /// Accepts formats: +260977123456, 260977123456, 0977123456, 977123456
  static bool isValidZambianPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Match Zambian phone patterns
    final patterns = [
      RegExp(r'^\+260[97][0-9]{8}$'), // +260977123456
      RegExp(r'^260[97][0-9]{8}$'), // 260977123456
      RegExp(r'^0[97][0-9]{8}$'), // 0977123456
      RegExp(r'^[97][0-9]{8}$'), // 977123456
    ];

    return patterns.any((pattern) => pattern.hasMatch(cleaned));
  }

  /// Normalize Zambian phone number to format: 260977123456
  static String normalizeZambianPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');

    if (cleaned.startsWith('260')) {
      return cleaned;
    } else if (cleaned.startsWith('0')) {
      return '260${cleaned.substring(1)}';
    } else if (cleaned.length == 9) {
      return '260$cleaned';
    }

    return cleaned;
  }

  /// Validate amount (must be positive)
  static void validateAmount(double amount) {
    if (amount <= 0) {
      throw const ValidationException(
        'Amount must be greater than 0',
        {'amount': 'Must be positive'},
      );
    }
  }

  /// Validate currency code
  static void validateCurrency(String currency) {
    const validCurrencies = ['ZMW', 'USD'];
    if (!validCurrencies.contains(currency.toUpperCase())) {
      throw ValidationException(
        'Invalid currency code',
        {'currency': 'Must be one of: ${validCurrencies.join(", ")}'},
      );
    }
  }

  /// Validate reference ID
  static void validateReferenceId(String referenceId) {
    if (referenceId.isEmpty) {
      throw const ValidationException(
        'Reference ID cannot be empty',
        {'referenceId': 'Required field'},
      );
    }

    if (referenceId.length > 100) {
      throw const ValidationException(
        'Reference ID too long',
        {'referenceId': 'Maximum 100 characters'},
      );
    }
  }

  /// Validate account number
  static void validateAccountNumber(String accountNumber) {
    if (accountNumber.isEmpty) {
      throw const ValidationException(
        'Account number cannot be empty',
        {'accountNumber': 'Required field'},
      );
    }
  }

  /// Validate API key format
  static void validateApiKey(String apiKey) {
    if (apiKey.isEmpty) {
      throw const ValidationException(
        'API key cannot be empty',
        {'apiKey': 'Required field'},
      );
    }

    // Lipila API keys typically start with Lsk_ or Lpk_
    if (!apiKey.startsWith('Lsk_') && !apiKey.startsWith('Lpk_')) {
      throw const ValidationException(
        'Invalid API key format',
        {'apiKey': 'Must start with Lsk_ or Lpk_'},
      );
    }
  }

  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate SWIFT code
  static void validateSwiftCode(String swiftCode) {
    if (swiftCode.isEmpty) {
      throw const ValidationException(
        'SWIFT code cannot be empty',
        {'swiftCode': 'Required field'},
      );
    }

    // SWIFT codes are 8 or 11 characters
    if (swiftCode.length != 8 && swiftCode.length != 11) {
      throw const ValidationException(
        'Invalid SWIFT code length',
        {'swiftCode': 'Must be 8 or 11 characters'},
      );
    }
  }
}
