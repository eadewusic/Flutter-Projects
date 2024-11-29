import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/country_model.dart';

class CountryProvider extends ChangeNotifier {
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Country> get countries =>
      _filteredCountries.isNotEmpty ? _filteredCountries : _countries;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch countries from the REST Countries API
  Future<void> fetchCountries() async {
    _isLoading = true;
    _errorMessage = '';
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
                  .map<String>((lang) => lang.toString())
                  .toList()
              : <String>[];

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
            languages: languages,
          );
        }).toList();

        // Sort countries alphabetically
        _countries.sort((a, b) => a.name.compareTo(b.name));
      } else {
        _errorMessage = 'Failed to load countries. Please try again.';
        throw Exception('Failed to load countries');
      }
    } catch (error) {
      debugPrint('Error fetching countries: $error');
      _errorMessage = 'Network error. Please check your connection.';
      _countries = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Filter countries by name
  void filterCountries(String query) {
    if (query.isEmpty) {
      _filteredCountries = [];
    } else {
      _filteredCountries = _countries
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
