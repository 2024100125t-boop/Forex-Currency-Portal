import 'package:forex_api/forex_api.dart';
import 'package:terminal_colors/terminal_colors.dart';

import 'command_base.dart';

class HistoryCommand extends CliCommand {
  HistoryCommand()
    : super('history', 'Displays historical exchange rate changes.');

  @override
  Future<void> execute(ForexApiClient client, List<String> arguments) async {
    if (arguments.length < 2) {
      print('Usage: history USD PHP'.styleError);
      return;
    }

    final base = arguments[0].toUpperCase();
    final target = arguments[1].toUpperCase();

    final today = DateTime.now();
    final previous = today.subtract(const Duration(days: 7));

    final startDate = _formatDate(previous);
    final endDate = _formatDate(today);

    try {
      final rates = await client.fetchHistoricalRates(
        base,
        target,
        startDate,
        endDate,
      );

      final buffer = StringBuffer()
        ..writeln('=== HISTORICAL FOREX RATE TABLE ==='.styleHeader)
        ..writeln('Base Currency:   $base')
        ..writeln('Target Currency: $target')
        ..writeln('Period:          $startDate to $endDate')
        ..writeln()
        ..writeln('${'Date'.padRight(15)}Rate'.styleSuccess)
        ..writeln('---------------------------');

      for (final entry in rates.entries) {
        buffer.writeln('${entry.key.padRight(15)}${entry.value}');
      }

      buffer.writeln('---------------------------');

      print(buffer.toString());
    } on ForexException catch (e) {
      print('Operation Failed: ${e.message}'.styleError);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
