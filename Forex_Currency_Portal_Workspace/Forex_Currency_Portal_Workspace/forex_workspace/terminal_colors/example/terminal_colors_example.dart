import 'package:terminal_colors/terminal_colors.dart';

void main() {
  print('FOREX CURRENCY PORTAL'.styleHeader);
  print('Conversion successful!'.styleSuccess);
  print('Warning!'.styleWarning);
  print('Invalid currency!'.styleError);
  print('Hello'.color(TerminalColor.cyan));
}
