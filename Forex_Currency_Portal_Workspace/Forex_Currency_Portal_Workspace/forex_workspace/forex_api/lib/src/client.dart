import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'exceptions.dart';

class ForexApiClient {
  final http.Client _client;
  final Logger _logger = Logger('ForexApiClient');

  static const String _authority = 'open.er-api.com';
  static const String _historicalAuthority = 'api.frankfurter.app';

  ForexApiClient(this._client);

  Future<double> fetchRate(String baseCurrency, String targetCurrency) async {
    final base = baseCurrency.toUpperCase();
    final target = targetCurrency.toUpperCase();

    _logger.info('Initiating connection for rate query: $base -> $target');

    final uri = Uri.https(_authority, '/v6/latest/$base');

    try {
      final response = await _client
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        _logger.warning(
          'API responded with error status: ${response.statusCode}',
        );

        throw ForexException(
          'Remote server rejected transaction '
          '(HTTP ${response.statusCode}).',
        );
      }

      final decoded = json.decode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw ForexException('Unexpected JSON response payload structure.');
      }

      final rates = decoded['rates'];

      if (rates is! Map<String, dynamic>) {
        throw ForexException('Unexpected rates payload structure.');
      }

      final rate = rates[target];

      if (rate is! num) {
        throw ForexException('Exchange rate for $target was not found.');
      }

      _logger.info('Successfully retrieved rate: $base -> $target = $rate');

      return rate.toDouble();
    } on http.ClientException catch (e) {
      _logger.severe('Network socket transaction failed.', e);

      throw ForexException('Network communication failure occurred.', e);
    } on ForexException {
      rethrow;
    } catch (e, stackTrace) {
      _logger.severe(
        'An unexpected processing failure was intercepted.',
        e,
        stackTrace,
      );

      rethrow;
    } finally {
      _logger.fine('Completed rate request: $base -> $target');
    }
  }

  Future<Map<String, double>> fetchHistoricalRates(
    String baseCurrency,
    String targetCurrency,
    String startDate,
    String endDate,
  ) async {
    final base = baseCurrency.toUpperCase();
    final target = targetCurrency.toUpperCase();

    _logger.info('Fetching historical rates: $base -> $target');

    final uri = Uri.https(_historicalAuthority, '/$startDate..$endDate', {
      'from': base,
      'to': target,
    });

    try {
      final response = await _client
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        _logger.warning(
          'Historical API returned status: ${response.statusCode}',
        );

        throw ForexException(
          'Historical server rejected transaction '
          '(HTTP ${response.statusCode}).',
        );
      }

      final decoded = json.decode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw ForexException('Unexpected historical JSON structure.');
      }

      final rates = decoded['rates'];

      if (rates is! Map<String, dynamic>) {
        throw ForexException('Historical rates payload is invalid.');
      }

      final result = <String, double>{};

      for (final entry in rates.entries) {
        final value = entry.value;

        if (value is Map<String, dynamic>) {
          final rate = value[target];

          if (rate is num) {
            result[entry.key] = rate.toDouble();
          }
        }
      }

      if (result.isEmpty) {
        throw ForexException('No historical rates found for $base -> $target.');
      }

      _logger.info('Historical rates successfully retrieved.');

      return result;
    } on http.ClientException catch (e) {
      _logger.severe('Historical network transaction failed.', e);

      throw ForexException(
        'Historical network communication failure occurred.',
        e,
      );
    } on ForexException {
      rethrow;
    } catch (e, stackTrace) {
      _logger.severe(
        'Unexpected historical processing failure.',
        e,
        stackTrace,
      );

      rethrow;
    } finally {
      _logger.fine('Completed historical rate request.');
    }
  }

  void close() {
    _client.close();
  }
}
