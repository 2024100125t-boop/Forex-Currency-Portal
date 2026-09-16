import 'package:forex_api/forex_api.dart';

abstract class CliCommand {
  final String name;
  final String description;

  CliCommand(this.name, this.description);

  Future<void> execute(ForexApiClient client, List<String> arguments);
}
