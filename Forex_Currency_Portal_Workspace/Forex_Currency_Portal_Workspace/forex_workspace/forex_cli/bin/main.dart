import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:forex_api/forex_api.dart';
import 'package:forex_cli/forex_cli.dart';
import 'package:terminal_colors/terminal_colors.dart';

Future<void> main() async {
  configureSystemTelemetry();

  final httpClient = http.Client();
  final apiClient = ForexApiClient(httpClient);

  final queryCommand = QueryCommand();

  final commands = <CliCommand>[
    queryCommand,
    HelpCommand([queryCommand]),
  ];

  print('Welcome to the FOREX Currency Portal!'.styleHeader);

  try {
    while (true) {
      stdout.write('\nforex > ');

      final input = stdin.readLineSync();

      if (input == null || input.trim().toLowerCase() == 'exit') {
        print('Exiting platform...'.styleWarning);
        break;
      }

      final trimmed = input.trim();

      if (trimmed.isEmpty) {
        continue;
      }

      final parts = trimmed.split(RegExp(r'\s+'));
      final commandName = parts.first.toLowerCase();
      final arguments = parts.sublist(1);

      final matchingCommands = commands.where(
        (command) => command.name == commandName,
      );

      if (matchingCommands.isNotEmpty) {
        await matchingCommands.first.execute(apiClient, arguments);
      } else {
        print(
          'Unknown command. Type "help" for available commands.'.styleError,
        );
      }
    }
  } finally {
    apiClient.close();

    print('System network socket disconnected successfully.'.styleSuccess);
  }
}
