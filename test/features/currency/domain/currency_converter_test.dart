import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/features/currency/domain/services/currency_converter.dart';

void main() {
  group('CurrencyConverter.toEgp', () {
    test('normalizes the selected currency rate through the EGP rate', () {
      expect(
        CurrencyConverter.toEgp(amount: 100, selectedRate: 0.0206, egpRate: 1),
        closeTo(2.06, 0.0001),
      );
    });

    test('matches every rate returned by the currencies API', () {
      const rates = <String, double>{
        'USD': 0.0206,
        'EUR': 0.019,
        'SAR': 0.0773,
        'AED': 0.0757,
        'GBP': 0.0162,
        'KWD': 0.0063,
        'QAR': 0.075,
        'EGP': 1,
      };
      const expected = <String, double>{
        'USD': 2.06,
        'EUR': 1.9,
        'SAR': 7.73,
        'AED': 7.57,
        'GBP': 1.62,
        'KWD': 0.63,
        'QAR': 7.5,
        'EGP': 100,
      };

      for (final entry in rates.entries) {
        expect(
          CurrencyConverter.toEgp(
            amount: 100,
            selectedRate: entry.value,
            egpRate: rates['EGP']!,
          ),
          closeTo(expected[entry.key]!, 0.0001),
          reason: entry.key,
        );
      }
    });

    test('rejects zero and invalid rates', () {
      expect(
        CurrencyConverter.toEgp(amount: 100, selectedRate: 0, egpRate: 1),
        isNull,
      );
      expect(
        CurrencyConverter.toEgp(amount: 100, selectedRate: 1, egpRate: 0),
        isNull,
      );
      expect(
        CurrencyConverter.toEgp(
          amount: 100,
          selectedRate: double.nan,
          egpRate: 1,
        ),
        isNull,
      );
    });
  });
}
