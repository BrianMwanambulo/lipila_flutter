# Troubleshooting "Failed Host Lookup" Error

## Problem
You're getting a "failed host lookup" error when using the SDK, but the API works fine in Postman.

## Common Causes

### 1. Wrong Base URL
The SDK might be using incorrect base URLs. The current configuration is:
- Sandbox: `https://api.lipila.dev`
- Production: `https://api.lipila.io`

**Check your Postman configuration** to see what base URL you're actually using.

### 2. Network/DNS Issues

#### Quick Tests

Add this code to test connectivity:

```dart
import 'package:lipila_flutter/lipila_flutter.dart';

void main() async {
  // Test 1: Check what URL you're using
  final client = LipilaClient.sandbox('Lsk_your_key');
  LipilaDebug.printEnvironmentInfo(
    client.config.baseUrl,
    client.config.apiKey,
  );

  // Test 2: Test connection to the base URL
  final isReachable = await LipilaDebug.testConnection(
    'https://api.lipila.io', // or whatever URL works in Postman
  );
  
  print('Can reach API: $isReachable');

  // Test 3: Test with your API key
  await LipilaDebug.testApiKey(
    'https://api.lipila.io', // Use URL from Postman
    'Lsk_your_api_key',
    '/wallet/balance',
  );
}
```

## Solutions

### Solution 1: Use Custom Base URL

If the base URLs in the SDK don't match what works in Postman, create a custom configuration:

```dart
// Create custom environment
enum CustomEnvironment {
  custom('https://your-actual-api-url.com'); // Replace with URL from Postman
  
  const CustomEnvironment(this.baseUrl);
  final String baseUrl;
}

// Use custom config
final client = LipilaClient(
  config: LipilaConfig(
    apiKey: 'Lsk_your_key',
    environment: Environment.sandbox, // Doesn't matter
    timeout: Duration(seconds: 30),
    enableLogging: true,
    logLevel: LogLevel.debug,
  ),
);

// Override the base URL - this is a workaround until we fix the URLs
```

### Solution 2: Check API Key Format

Make sure your API key is in the correct format:
- Sandbox keys: `Lsk_...`
- Production keys: `Lpk_...`

The validation was just fixed - it now correctly checks for uppercase `Lsk_` or `Lpk_`.

### Solution 3: Enable Logging

Enable detailed logging to see exactly what's happening:

```dart
final client = LipilaClient.sandbox(
  'Lsk_your_key',
  enableLogging: true,
  logLevel: LogLevel.debug,
);

try {
  final balance = await client.balance.getBalance();
  print('Success: $balance');
} catch (e) {
  print('Error details: $e');
}
```

### Solution 4: Platform Configuration (Android/macOS)

If you see "Failed host lookup" errors on Android or macOS, you may need to add network permissions.

**Android**  
Add the internet permission to your `android/app/src/main/AndroidManifest.xml` file, right above the `<application>` tag:

```xml
<manifest ...>
    <!-- Add this permission -->
    <uses-permission android:name="android.permission.INTERNET"/>

    <application ...>
        ...
    </application>
</manifest>
```

**macOS**  
Add network entitlements to your `macos/Runner/*.entitlements` files (both Debug and Release):

```xml
<dict>
    ...
    <!-- Add these keys -->
    <key>com.apple.security.network.client</key>
    <true/>
</dict>
```

## What Base URL Should You Use?

**IMPORTANT**: Please check your Postman requests and tell me:
1. What base URL works in Postman?
2. What endpoints are you hitting?

Common possibilities:
- `https://api.lipila.io`
- `https://lipila.io/api`
- `https://sandbox.lipila.io`
- `https://api-sandbox.lipila.io`

## Temporary Workaround

Until we confirm the correct URLs, you can bypass the SDK's environment and directly configure:

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

// Direct HTTP call using the URL from Postman
final response = await http.get(
  Uri.parse('YOUR_POSTMAN_URL/wallet/balance'),
  headers: {
    'Authorization': 'Bearer Lsk_your_key',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
);

print('Status: ${response.statusCode}');
print('Body: ${response.body}');
```

## Next Steps

1. **Check Postman** - What's the exact URL that works?
2. **Run debug tests** - Use the `LipilaDebug` utilities above
3. **Report back** - Share the working URL so we can update the SDK

## Contact

If you can share:
- The working base URL from Postman
- Your exact error message
- The endpoint you're trying to hit

We can fix this immediately!
