# Lipila Flutter SDK

[![pub package](https://img.shields.io/pub/v/lipila_flutter.svg)](https://pub.dev/packages/lipila_flutter)

Official Flutter SDK for Lipila payment gateway. Accept payments and make disbursements in Zambia with ease.

## Features

✅ **Collections** - Accept mobile money and card payments  
✅ **Disbursements** - Send money to mobile money and bank accounts  
✅ **Balance Check** - View your wallet balance  
✅ **Transaction Status** - Track payment status  
✅ **Type-Safe** - Full Dart type safety with comprehensive error handling  
✅ **Well Documented** - Clear API documentation and examples  
✅ **Tested** - Production-ready with comprehensive tests  

## Supported Payment Methods

- 📱 **Mobile Money**: MTN, Airtel, Zamtel
- 💳 **Cards**: Visa, Mastercard
- 🏦 **Bank Transfers**: Direct bank disbursements

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  lipila_flutter: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Getting Started

### 1. Get Your API Key

1. Sign up at [Lipila Dashboard](https://dashboard.lipila.io)
2. Get your API key from the dashboard
3. Use sandbox key (`Lsk_`) for testing
4. Use production key (`Lpk_`) for live transactions

### 2. Initialize the Client

```dart
import 'package:lipila_flutter/lipila_flutter.dart';

// For testing (sandbox)
final client = LipilaClient.sandbox('Lsk_your_sandbox_key');

// For production
final client = LipilaClient.production('Lpk_your_production_key');
```

## Usage Examples

### Check Wallet Balance

```dart
try {
  final balance = await client.balance.getBalance();
  print('Available: ${balance.availableBalance} ${balance.currency}');
  print('Booked: ${balance.bookedBalance} ${balance.currency}');
} on AuthException catch (e) {
  print('Authentication failed: ${e.message}');
} on NetworkException catch (e) {
  print('Network error: ${e.message}');
}
```

### Accept Mobile Money Payment

```dart
try {
  final collection = await client.collections.createCollection(
    referenceId: 'ORDER-${DateTime.now().millisecondsSinceEpoch}',
    amount: 100.00,
    accountNumber: '260977123456', // Customer's phone number
    currency: 'ZMW',
    callbackUrl: 'https://myapp.com/webhook',
  );
  
  print('Collection initiated: ${collection.identifier}');
  print('Status: ${collection.status}');
  
  // Poll for status or wait for webhook callback
  await Future.delayed(const Duration(seconds: 5));
  
  final status = await client.status.checkCollectionStatus(
    collection.referenceId,
  );
  
  if (status.isSuccessful) {
    print('Payment received!');
  } else if (status.isPending) {
    print('Payment is pending...');
  } else {
    print('Payment failed: ${status.message}');
  }
} on ValidationException catch (e) {
  print('Validation error: ${e.message}');
  print('Errors: ${e.errors}');
} on ApiException catch (e) {
  print('API error: ${e.message}');
}
```

### Accept Card Payment

```dart
try {
  final collection = await client.collections.createCardCollection(
    collectionRequest: CollectionRequest(
      referenceId: 'CARD-${DateTime.now().millisecondsSinceEpoch}',
      amount: 150.00,
      currency: 'ZMW',
      narration: 'Card Payment Test',
    ),
    customerInfo: CustomerInfo(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      phoneNumber: '0977123456',
      country: 'ZM',
      city: 'Lusaka',
    ),
  );

  print('Redirect URL: ${collection.cardRedirectionUrl}');
  // Redirect user to: collection.cardRedirectionUrl
} catch (e) {
  print('Error: $e');
}
```

### Send Money (Mobile Money Disbursement)

```dart
try {
  final disbursement = await client.disbursements.createMobileDisbursement(
    referenceId: 'PAYOUT-${DateTime.now().millisecondsSinceEpoch}',
    amount: 500.00,
    accountNumber: '260977123456',
    currency: 'ZMW',
    narration: 'Salary payment for January 2026',
    callbackUrl: 'https://myapp.com/webhook/disbursement',
  );
  
  print('Disbursement initiated: ${disbursement.identifier}');
  
  // Check status
  final status = await client.status.checkDisbursementStatus(
    disbursement.referenceId,
  );
  
  print('Status: ${status.status}');
} catch (e) {
  print('Error: $e');
}
```

### Send Bank Disbursement

```dart
try {
  final disbursement = await client.disbursements.createBankDisbursement(
    referenceId: 'PAYOUT-${DateTime.now().millisecondsSinceEpoch}',
    amount: 500.00,
    currency: 'ZMW',
    accountNumber: '1234567890',
    swiftCode: 'ZNCOZMLU', // Bank SWIFT code
    firstName: 'Jane',
    lastName: 'Doe',
    accountHolderName: 'Jane Doe',
    phoneNumber: '260977000000',
    narration: 'Salary Payment',
  );

  print('Disbursement initiated: ${disbursement.referenceId}');
  print('Status: ${disbursement.status}');
} catch (e) {
  print('Error: $e');
}
```

### Handle Webhooks

```dart
import 'package:lipila_flutter/lipila_flutter.dart';

// In your webhook endpoint handler
void handleWebhook(Map<String, dynamic> webhookData) {
  try {
    final callback = CallbackPayload.fromJson(webhookData);
    
    print('Transaction: ${callback.referenceId}');
    print('Status: ${callback.status}');
    print('Amount: ${callback.amount} ${callback.currency}');
    
    if (callback.isSuccessful) {
      if (callback.isCollection) {
        // Handle successful collection
        print('Payment received from ${callback.accountNumber}');
      } else if (callback.isDisbursement) {
        // Handle successful disbursement
        print('Payment sent to ${callback.accountNumber}');
      }
    } else if (callback.isFailed) {
      // Handle failed transaction
      print('Transaction failed: ${callback.message}');
    }
  } catch (e) {
    print('Error parsing webhook: $e');
  }
}
```

## Advanced Configuration

```dart
final client = LipilaClient(
  config: LipilaConfig(
    apiKey: 'your-api-key',
    environment: Environment.sandbox,
    timeout: const Duration(seconds: 45),
    enableLogging: true,
    logLevel: LogLevel.debug,
  ),
);
```

## Error Handling

The SDK provides specific exception types for different error scenarios:

```dart
try {
  // Your Lipila operation
} on AuthException catch (e) {
  // Invalid API key or authentication failed
  print('Auth error: ${e.message}');
} on ValidationException catch (e) {
  // Invalid parameters
  print('Validation error: ${e.message}');
  print('Field errors: ${e.errors}');
} on NetworkException catch (e) {
  // Network connectivity issues
  print('Network error: ${e.message}');
} on TimeoutException catch (e) {
  // Request timed out
  print('Timeout: ${e.message}');
} on ApiException catch (e) {
  // Other API errors
  print('API error: ${e.message} (${e.statusCode})');
} on LipilaException catch (e) {
  // Catch-all for any Lipila errors
  print('Lipila error: ${e.message}');
}
```

## Utilities

### Phone Number Validation

```dart
import 'package:lipila_flutter/lipila_flutter.dart';

// Validate Zambian phone number
if (Validators.isValidZambianPhone('0977123456')) {
  print('Valid phone number');
}

// Normalize phone number to format: 260977123456
final normalized = Validators.normalizeZambianPhone('0977123456');
print(normalized); // 260977123456
```

### Amount Validation

```dart
Validators.validateAmount(100.0); // OK
Validators.validateAmount(-10.0); // Throws ValidationException
```

## Testing

For testing, use the sandbox environment:

```dart
// Use sandbox API key
final client = LipilaClient.sandbox('Lsk_test_key');

// Enable detailed logging
final client = LipilaClient.sandbox(
  'Lsk_test_key',
  enableLogging: true,
  logLevel: LogLevel.debug,
);
```

**Test Phone Numbers** (Sandbox):
- Success: `0977000001`
- Failure: `0977000002`
- Pending: `0977000003`

## Best Practices

### 1. **Never Hardcode API Keys**

```dart
// ❌ Don't do this
const apiKey = 'Lsk_your_key';

// ✅ Load from environment or secure storage
final apiKey = await SecureStorage.getApiKey();
```

### 2. **Use Reference IDs Wisely**

```dart
// Use unique, trackable reference IDs
final referenceId = 'ORDER-${orderId}-${DateTime.now().millisecondsSinceEpoch}';
```

### 3. **Handle Webhooks Properly**

- Validate webhook signatures (if provided by Lipila)
- Process webhooks asynchronously
- Implement idempotency to handle duplicate webhooks
- Store transaction status updates

### 4. **Implement Retry Logic**

```dart
Future<CollectionResponse> createCollectionWithRetry({
  required String referenceId,
  required double amount,
  required String accountNumber,
  required String currency,
  int maxRetries = 3,
}) async {
  for (var i = 0; i < maxRetries; i++) {
    try {
      return await client.collections.createCollection(
        referenceId: referenceId,
        amount: amount,
        accountNumber: accountNumber,
        currency: currency,
      );
    } on NetworkException {
      if (i == maxRetries - 1) rethrow;
      await Future.delayed(Duration(seconds: 2 * (i + 1)));
    }
  }
  throw Exception('Failed after $maxRetries retries');
}
```

### 5. **Close Client When Done**

```dart
// In your app's dispose method
@override
void dispose() {
  client.close();
  super.dispose();
}
```

## Platform Support

| Platform | Support |
|----------|---------|
| Android  | ✅      |
| iOS      | ✅      |
| Web      | ✅      |
| macOS    | ✅      |
| Windows  | ✅      |
| Linux    | ✅      |

## API Reference

Full API documentation is available at [pub.dev/documentation/lipila_flutter](https://pub.dev/documentation/lipila_flutter/latest/)

## Support

- 📧 Email: support@lipila.io
- 📖 Documentation: https://docs.lipila.io
- 💬 Issues: [GitHub Issues](https://github.com/yourusername/lipila-flutter/issues)

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

---

Made with ❤️ for the Zambian fintech ecosystem


