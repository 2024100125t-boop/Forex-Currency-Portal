import 'exceptions.dart';

class CurrencyRate {
  final String id;
  final String name;
  final double primaryValue;

  const CurrencyRate({
    required this.id,
    required this.name,
    required this.primaryValue,
  });

  factory CurrencyRate.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String parsedId,
        'name': String parsedName,
        'value': num numericValue,
      } =>
        CurrencyRate(
          id: parsedId,
          name: parsedName,
          primaryValue: numericValue.toDouble(),
        ),
      _ => throw ForexException('Payload failed pattern validation check!'),
    };
  }

  @override
  String toString() {
    return '$id - $name: $primaryValue';
  }
}
