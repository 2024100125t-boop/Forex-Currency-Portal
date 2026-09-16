import 'package:forex_cli/forex_cli.dart';
import 'package:test/test.dart';

void main() {
  group('CLI Commands', () {
    test('HelpCommand has correct name', () {
      final command = HelpCommand([]);

      expect(command.name, 'help');
    });

    test('HelpCommand has a description', () {
      final command = HelpCommand([]);

      expect(command.description, isNotEmpty);
    });

    test('QueryCommand has correct name', () {
      final command = QueryCommand();

      expect(command.name, 'query');
    });

    test('QueryCommand has a description', () {
      final command = QueryCommand();

      expect(command.description, isNotEmpty);
    });
  });
}
