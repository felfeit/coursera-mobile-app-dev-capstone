import 'dart:convert';

import 'package:coursera_mobile_app_dev_capstone/features/auth/domain/model/country_model.dart';
import 'package:http/http.dart' as http;

class CountryService {
  static const String _baseUrl = 'https://flagcdn.com/en/codes.json';

  /// Fetch all countries, sorted alphabetically.
  Future<List<CountryModel>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode != 200) {
        throw Exception('Failed to load countries (${response.statusCode})');
      }

      final Map<String, dynamic> jsonMap =
          jsonDecode(response.body) as Map<String, dynamic>;

      final countries = jsonMap.entries
          .map((entry) {
            final code = entry.key.toUpperCase();
            final name = entry.value.toString();
            return CountryModel(
              name: name,
              code: code,
              flagUrl: 'https://flagcdn.com/w40/${entry.key}.png',
            );
          })
          .where((c) => c.name.isNotEmpty)
          .toList();

      countries.sort((a, b) => a.name.compareTo(b.name));
      return countries;
    } catch (e) {
      throw Exception('Error fetching countries: $e');
    }
  }
}
