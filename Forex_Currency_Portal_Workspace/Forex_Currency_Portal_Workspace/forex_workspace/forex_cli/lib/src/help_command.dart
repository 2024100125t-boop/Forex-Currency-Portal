import 'package:forex_api/forex_api.dart';
import 'package:terminal_colors/terminal_colors.dart';

import 'command_base.dart';

class HelpCommand extends CliCommand {
  final List<CliCommand> commands;

  HelpCommand(this.commands)
    : super('help', 'Displays available Forex commands.');

  @override
  Future<void> execute(ForexApiClient client, List<String> arguments) async {
    final buffer = StringBuffer()
      ..writeln('=== FOREX CURRENCY PORTAL ==='.styleHeader)
      ..writeln()
      ..writeln('Available Commands:'.styleSuccess);

    for (final command in commands) {
      buffer.writeln(
        '  ${command.name.padRight(10)} '
        '${command.description}',
      );
    }

    buffer
      ..writeln()
      ..writeln('Examples:')
      ..writeln('  query USD PHP')
      ..writeln('  history USD PHP'.styleWarning);

    print(buffer.toString());
  }
}
