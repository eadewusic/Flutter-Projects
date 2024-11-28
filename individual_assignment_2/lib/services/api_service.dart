import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';

class ApiService {
  static const String baseUrl = 'https://restcountries.com/v3.1';

  static Future<List<Country>> searchCountries(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/name/$query'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
