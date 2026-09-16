import 'package:terminal_colors/terminal_colors.dart';
import 'package:test/test.dart';

void main() {
  test('cyan color works', () {
    expect('Hello'.color(TerminalColor.cyan), '\x1B[36mHello\x1B[0m');
  });

  test('success style works', () {
    expect('Success'.styleSuccess, '\x1B[32mSuccess\x1B[0m');
  });

  test('warning style works', () {
    expect('Warning'.styleWarning, '\x1B[33mWarning\x1B[0m');
  });

  test('error style works', () {
    expect('Error'.styleError, '\x1B[31mError\x1B[0m');
  });
}
