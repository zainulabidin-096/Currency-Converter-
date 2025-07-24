import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _apiKey = 'Enter your API here';
  static const String _baseUrl = 'https://v6.exchangerate-api.com/v6';

  static Future<double> getExchangeRate({
    required String from,
    required String to,
  }) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$_apiKey/pair/$from/$to'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['conversion_rate'] ?? 0.0;
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
