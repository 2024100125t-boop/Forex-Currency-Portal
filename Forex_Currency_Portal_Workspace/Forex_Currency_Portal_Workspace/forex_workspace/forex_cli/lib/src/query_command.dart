import 'package:forex_api/forex_api.dart';
import 'package:terminal_colors/terminal_colors.dart';

import 'command_base.dart';

class QueryCommand extends CliCommand {
  QueryCommand()
    : super('query', 'Fetches the exchange rate for two currencies.');

  @override
  Future<void> execute(ForexApiClient client, List<String> arguments) async {
    if (arguments.length < 2) {
      print('Usage: query USD PHP'.styleError);
      return;
    }

    final base = arguments[0].toUpperCase();
    final target = arguments[1].toUpperCase();

    try {
      final rate = await client.fetchRate(base, target);

      final buffer = StringBuffer()
        ..writeln('--- FOREX RATE REPORT ---'.styleHeader)
        ..writeln('Base Currency:   $base')
        ..writeln('Target Currency: $target')
        ..writeln('Exchange Rate:   $rate'.styleSuccess)
        ..writeln('-------------------------'.styleHeader);

      print(buffer.toString());
    } on ForexException catch (e) {
      print('Operation Failed: ${e.message}'.styleError);
    }
  }
}
