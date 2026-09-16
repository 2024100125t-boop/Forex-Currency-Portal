import 'package:http/http.dart' as http;
import 'package:forex_api/forex_api.dart';
import 'package:forex_cli/forex_cli.dart';

Future<void> main(List<String> arguments) async {
  final httpClient = http.Client();
  final apiClient = ForexApiClient(httpClient);

  final queryCommand = QueryCommand();

  final commands = <CliCommand>[
    queryCommand,
    HelpCommand([queryCommand]),
  ];

  final runner = CommandRunner(apiClient, commands);

  try {
    await runner.run(arguments);
  } finally {
    apiClient.close();
  }
}
