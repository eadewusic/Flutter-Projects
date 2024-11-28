import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/country_model.dart';

class CountryProvider extends ChangeNotifier {
  List<Country> _countries = [];
  bool _isLoading = false;

  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;

  // Fetch countries from the REST Countries API
  Future<void> fetchCountries() async {
    _isLoading = true;
    notifyListeners();

    const url = 'https://restcountries.com/v3.1/all';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        _countries = data.map<Country>((countryData) {
          // Extract languages and ensure List<String>
          final languages = (countryData['languages'] != null &&
                  countryData['languages'] is Map)
              ? (countryData['languages'] as Map)
                  .values
                  .map<String>(
                      (lang) => lang.toString()) // Ensure the type is String
                  .toList()
              : <String>[]; // Default to an empty List<String>

          return Country(
            name: countryData['name']['common'] ?? 'Unknown',
            capital: (countryData['capital'] != null &&
                    countryData['capital'] is List &&
                    countryData['capital'].isNotEmpty)
                ? countryData['capital'][0]
                : 'No Capital',
            region: countryData['region'] ?? 'Unknown',
            population: countryData['population'] ?? 0,
            flag: countryData['flags']['png'] ?? '',
            languages: languages, // Pass the properly typed List<String>
          );
        }).toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (error) {
      debugPrint('Error fetching countries: $error');
      _countries = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
