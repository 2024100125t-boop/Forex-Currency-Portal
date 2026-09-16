import 'package:forex_api/forex_api.dart';
import 'package:terminal_colors/terminal_colors.dart';

import 'command_base.dart';

class QueryCommand extends CliCommand {
  QueryCommand()
    : super('query', 'Fetches the exchange rate for two currencies.');

  @override
  Future<void> execute(ForexApiClient client, List<String> arguments) async {
    if (arguments.length < 2) {
      print(
        'Execution Error: Please provide base and target currencies.'
            .styleError,
      );
      print('Example: query USD PHP'.styleWarning);
      return;
    }

    final baseCurrency = arguments[0];
    final targetCurrency = arguments[1];

    try {
      final result = await client.fetchRate(baseCurrency, targetCurrency);

      final buffer = StringBuffer()
        ..writeln('--- FOREX RATE REPORT ---'.styleHeader)
        ..writeln('Base Currency:   ${baseCurrency.toUpperCase()}')
        ..writeln('Target Currency: ${targetCurrency.toUpperCase()}')
        ..writeln('Exchange Rate:   $result'.styleSuccess)
        ..writeln('-------------------------'.styleHeader);

      print(buffer.toString());
    } on ForexException catch (e) {
      print('Operation Failed: ${e.message}'.styleError);
    }
  }
}
