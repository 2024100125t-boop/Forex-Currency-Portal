class ForexException implements Exception {
  final String message;
  final Object? cause;

  ForexException(this.message, [this.cause]);

  @override
  String toString() {
    return 'ForexException: $message';
  }
}
