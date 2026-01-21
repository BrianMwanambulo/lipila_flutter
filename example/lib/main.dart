import 'package:flutter/material.dart';
import 'package:lipila_flutter/lipila_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lipila Flutter SDK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LipilaDemo(),
    );
  }
}

class LipilaDemo extends StatefulWidget {
  const LipilaDemo({super.key});

  @override
  State<LipilaDemo> createState() => _LipilaDemoState();
}

class _LipilaDemoState extends State<LipilaDemo> {
  late LipilaClient _client;
  String _output = 'Ready to test Lipila SDK...';
  bool _isLoading = false;

  // Controllers
  final _apiKeyController = TextEditingController(text: 'lsk_your_sandbox_key');
  final _amountController = TextEditingController(text: '100');
  final _phoneController = TextEditingController(text: '260977123456');
  final _referenceController = TextEditingController();
  final _callbackUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initClient();
  }

  void _initClient({String? webhookUrl}) {
    _client = LipilaClient.sandbox(
      _apiKeyController.text,
      enableLogging: true,
      callbackUrl:webhookUrl,

      logLevel: LogLevel.debug,
    );
  }

  Future<void> _checkBalance() async {
    setState(() {
      _isLoading = true;
      _output = 'Checking balance...';
    });

    try {
      final balance = await _client.balance.getBalance();
      setState(() {
        _output =
            '''
✅ Balance Retrieved Successfully!

Available Balance: ${balance.data?.balance} ZMW
''';
      });
    } on AuthException catch (e) {
      setState(() {
        _output = '❌ Authentication Error:\n${e.message}';
      });
    } on NetworkException catch (e) {
      setState(() {
        _output = '❌ Network Error:\n${e.message}';
      });
    } catch (e) {
      setState(() {
        _output = '❌ Error:\n$e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createCollection() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final phone = _phoneController.text;
    final reference = _referenceController.text.isEmpty
        ? 'TEST-${DateTime.now().millisecondsSinceEpoch}'
        : _referenceController.text;

    setState(() {
      _isLoading = true;
      _output = 'Creating collection...';
    });

    try {
      final collection = await _client.collections.createCollection(
        referenceId: reference,
        amount: amount,
        narration: 'Test collection from Flutter SDK',
        accountNumber: phone,
        email: "email@example.com",
        currency: 'ZMW',
      );

      setState(() {
        _output =
            '''
✅ Collection Created!

Reference ID: ${collection.referenceId}
Identifier: ${collection.identifier}
Status: ${collection.status}
Payment Type: ${collection.paymentType}
Created: ${collection.createdAt}
''';
      });
    } on ValidationException catch (e) {
      setState(() {
        _output =
            '''
❌ Validation Error:
${e.message}

Field Errors:
${e.errors.entries.map((e) => '${e.key}: ${e.value}').join('\n')}
''';
      });
    } on ApiException catch (e) {
      setState(() {
        _output = '❌ API Error (${e.statusCode}):\n${e.message}';
      });
    } catch (e) {
      setState(() {
        _output = '❌ Error:\n$e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createDisbursement() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final phone = _phoneController.text;
    final reference = _referenceController.text.isEmpty
        ? 'PAYOUT-${DateTime.now().millisecondsSinceEpoch}'
        : _referenceController.text;

    setState(() {
      _isLoading = true;
      _output = 'Creating disbursement...';
    });

    try {
      final disbursement = await _client.disbursements.createMobileDisbursement(
        referenceId: reference,
        amount: amount,
        accountNumber: phone,
        currency: 'ZMW',
        narration: 'Test disbursement from Flutter SDK',
      );

      setState(() {
        _output =
            '''
✅ Disbursement Created!

Reference ID: ${disbursement.referenceId}
Identifier: ${disbursement.identifier}
Status: ${disbursement.status}
Payment Type: ${disbursement.paymentType}
Created: ${disbursement.createdAt}
''';
      });
    } catch (e) {
      setState(() {
        _output = '❌ Error:\n$e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _checkStatus() async {
    final reference = _referenceController.text;
    if (reference.isEmpty) {
      setState(() {
        _output = '❌ Please enter a reference ID';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _output = 'Checking status...';
    });

    try {
      TransactionStatus status;
      if (reference.startsWith('PAYOUT')) {
        status = await _client.status.checkDisbursementStatus(reference);
      } else {
        status = await _client.status.checkCollectionStatus(reference);
      }

      setState(() {
        _output =
            '''
✅ Status Retrieved!

Reference ID: ${status.referenceId}
Status: ${status.status}
Amount: ${status.amount} ${status.currency ?? 'ZMW'}
Account: ${status.accountNumber}
Payment Type: ${status.paymentType}
${status.message != null ? 'Message: ${status.message}' : ''}
''';
      });
    } catch (e) {
      setState(() {
        _output = '❌ Error:\n$e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lipila SDK Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // API Key Input
            TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'API Key',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
              ),
              onChanged: (_) => _initClient(),
            ),
            const SizedBox(height: 16),

            // Callback URL Input
            TextField(
              controller: _callbackUrlController,
              onChanged: (_) => _initClient(
                webhookUrl:  _callbackUrlController.text.isEmpty ? null : _callbackUrlController.text,
              ),
              decoration: const InputDecoration(
                labelText: 'Callback URL (optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 16),

            // Amount Input
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Phone Input
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Reference ID Input
            TextField(
              controller: _referenceController,
              decoration: const InputDecoration(
                labelText: 'Reference ID (optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.tag),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _checkBalance,
                  icon: const Icon(Icons.account_balance_wallet),
                  label: const Text('Check Balance'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _createCollection,
                  icon: const Icon(Icons.arrow_downward),
                  label: const Text('Create Collection'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _createDisbursement,
                  icon: const Icon(Icons.arrow_upward),
                  label: const Text('Create Disbursement'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _checkStatus,
                  icon: const Icon(Icons.info),
                  label: const Text('Check Status'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Output Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              constraints: const BoxConstraints(minHeight: 200),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SelectableText(
                      _output,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
            ),

            const SizedBox(height: 24),

            // Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test Credentials',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Success: 0977000001\n'
                      '• Failure: 0977000002\n'
                      '• Pending: 0977000003',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _amountController.dispose();
    _phoneController.dispose();
    _referenceController.dispose();
    _client.close();
    super.dispose();
  }
}
