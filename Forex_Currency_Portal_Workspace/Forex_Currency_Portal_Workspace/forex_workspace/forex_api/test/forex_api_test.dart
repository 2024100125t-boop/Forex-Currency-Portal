import 'package:test/test.dart';
import 'package:forex_api/forex_api.dart';

void main() {
  group('Model Deserialisation Suite', () {
    test('Successful parsing of structural attributes', () {
      final mockJson = {
        'id': 'ID-1001',
        'name': 'Test Currency',
        'value': 99.5,
      };

      final item = CurrencyRate.fromJson(mockJson);

      expect(item.id, equals('ID-1001'));
      expect(item.name, equals('Test Currency'));
      expect(item.primaryValue, equals(99.5));
    });

    test('Trigger custom exception on broken mapping keys', () {
      final malformedJson = {
        'id': 'ID-1002',
        // Missing name and value
      };

      expect(
        () => CurrencyRate.fromJson(malformedJson),
        throwsA(isA<ForexException>()),
      );
    });
  });
}
