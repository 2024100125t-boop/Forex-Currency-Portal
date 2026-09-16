import 'package:forex_api/forex_api.dart';
import 'package:terminal_colors/terminal_colors.dart';

import 'command_base.dart';

class CommandRunner {
  final ForexApiClient client;
  final Map<String, CliCommand> _commands;

  CommandRunner(this.client, List<CliCommand> commands)
    : _commands = {for (final command in commands) command.name: command};

  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      print('No command provided.'.styleWarning);
      print('Use "help" to see available commands.');
      return;
    }

    final commandName = arguments.first;
    final command = _commands[commandName];

    if (command == null) {
      print('Unknown command: $commandName'.styleError);
      print('Use "help" to see available commands.');
      return;
    }

    final commandArguments = arguments.skip(1).toList();

    await command.execute(client, commandArguments);
  }
}
