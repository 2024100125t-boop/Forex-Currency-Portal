import 'package:forex_api/forex_api.dart';

import 'command_base.dart';

class CommandRunner {
  final ForexApiClient client;
  final List<CliCommand> commands;

  CommandRunner(this.client, this.commands);

  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      final help = commands.firstWhere((command) => command.name == 'help');

      await help.execute(client, []);
      return;
    }

    final commandName = arguments.first;
    final commandArguments = arguments.sublist(1);

    final command = commands.where((command) => command.name == commandName);

    if (command.isEmpty) {
      print('Unknown command: $commandName');
      return;
    }

    await command.first.execute(client, commandArguments);
  }
}
