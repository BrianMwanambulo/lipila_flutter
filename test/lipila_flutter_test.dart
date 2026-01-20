import 'package:flutter_test/flutter_test.dart';
import 'package:lipila_flutter/lipila_flutter.dart';

void main() {
  group('Validators', () {
    group('Phone Number Validation', () {
      test('validates correct Zambian phone numbers', () {
        expect(Validators.isValidZambianPhone('+260977123456'), true);
        expect(Validators.isValidZambianPhone('260977123456'), true);
        expect(Validators.isValidZambianPhone('0977123456'), true);
        expect(Validators.isValidZambianPhone('977123456'), true);
      });

      test('rejects invalid phone numbers', () {
        expect(Validators.isValidZambianPhone('123456'), false);
        expect(Validators.isValidZambianPhone('0123456789'), false);
        expect(Validators.isValidZambianPhone('+447123456789'), false);
        expect(Validators.isValidZambianPhone('0812345678'), false);
      });

      test('normalizes phone numbers correctly', () {
        expect(
          Validators.normalizeZambianPhone('+260977123456'),
          '260977123456',
        );
        expect(Validators.normalizeZambianPhone('0977123456'), '260977123456');
        expect(Validators.normalizeZambianPhone('977123456'), '260977123456');
      });
    });

    group('Amount Validation', () {
      test('accepts positive amounts', () {
        expect(() => Validators.validateAmount(100.0), returnsNormally);
        expect(() => Validators.validateAmount(0.01), returnsNormally);
      });

      test('rejects zero and negative amounts', () {
        expect(
          () => Validators.validateAmount(0),
          throwsA(isA<ValidationException>()),
        );
        expect(
          () => Validators.validateAmount(-10),
          throwsA(isA<ValidationException>()),
        );
      });
    });

    group('Currency Validation', () {
      test('accepts valid currencies', () {
        expect(() => Validators.validateCurrency('ZMW'), returnsNormally);
        expect(() => Validators.validateCurrency('USD'), returnsNormally);
        expect(() => Validators.validateCurrency('zmw'), returnsNormally);
      });

      test('rejects invalid currencies', () {
        expect(
          () => Validators.validateCurrency('XXX'),
          throwsA(isA<ValidationException>()),
        );
      });
    });

    group('Email Validation', () {
      test('validates correct email addresses', () {
        expect(Validators.isValidEmail('test@example.com'), true);
        expect(Validators.isValidEmail('user.name@domain.co.zm'), true);
      });

      test('rejects invalid email addresses', () {
        expect(Validators.isValidEmail('invalid'), false);
        expect(Validators.isValidEmail('test@'), false);
        expect(Validators.isValidEmail('@domain.com'), false);
      });
    });

    group('API Key Validation', () {
      test('accepts valid API keys', () {
        expect(
          () => Validators.validateApiKey('Lsk_test_key_123'),
          returnsNormally,
        );
        expect(
          () => Validators.validateApiKey('Lpk_prod_key_456'),
          returnsNormally,
        );
      });

      test('rejects invalid API keys', () {
        expect(
          () => Validators.validateApiKey('invalid_key'),
          throwsA(isA<ValidationException>()),
        );
        expect(
          () => Validators.validateApiKey(''),
          throwsA(isA<ValidationException>()),
        );
      });
    });
  });

  group('Models', () {
    group('BalanceResponse', () {
      test('parses JSON correctly', () {
        final json = {
          'availableBalance': 1000.50,
          'bookedBalance': 900.25,
          'currency': 'ZMW',
        };

        final balance = BalanceResponse.fromJson(json);

        expect(balance.availableBalance, 1000.50);
        expect(balance.bookedBalance, 900.25);
        expect(balance.currency, 'ZMW');
      });

      test('converts to JSON correctly', () {
        const balance = BalanceResponse(
          availableBalance: 1000.50,
          bookedBalance: 900.25,
          currency: 'ZMW',
        );

        final json = balance.toJson();

        expect(json['availableBalance'], 1000.50);
        expect(json['bookedBalance'], 900.25);
        expect(json['currency'], 'ZMW');
      });
    });

    group('TransactionStatus', () {
      test('parses JSON correctly', () {
        final json = {
          'referenceId': 'TEST-123',
          'status': 'Successful',
          'amount': 100.0,
          'accountNumber': '260977123456',
          'paymentType': 'Mobile',
          'message': 'Payment successful',
        };

        final status = TransactionStatus.fromJson(json);

        expect(status.referenceId, 'TEST-123');
        expect(status.status, TransactionStatusEnum.successful);
        expect(status.amount, 100.0);
        expect(status.isSuccessful, true);
        expect(status.isPending, false);
        expect(status.isFailed, false);
      });
    });

    group('CallbackPayload', () {
      test('parses JSON correctly', () {
        final json = {
          'referenceId': 'TEST-123',
          'currency': 'ZMW',
          'amount': 100.0,
          'accountNumber': '260977123456',
          'status': 'Successful',
          'paymentType': 'Mobile',
          'type': 'collection',
          'ipAddress': '192.168.1.1',
          'identifier': 'TXN-123',
          'message': 'Payment successful',
        };

        final callback = CallbackPayload.fromJson(json);

        expect(callback.referenceId, 'TEST-123');
        expect(callback.isSuccessful, true);
        expect(callback.isCollection, true);
        expect(callback.isDisbursement, false);
      });
    });
  });

  group('Configuration', () {
    test('creates sandbox client correctly', () {
      final client = LipilaClient.sandbox('Lsk_test_key');

      expect(client.config.environment, Environment.sandbox);
      expect(
        client.config.baseUrl,
        'https://api.lipila.dev',
      );
    });

    test('creates production client correctly', () {
      final client = LipilaClient.production('Lpk_prod_key');

      expect(client.config.environment, Environment.production);
      expect(
        client.config.baseUrl,
        'https://api.lipila.io',
      );
    });
  });
}
