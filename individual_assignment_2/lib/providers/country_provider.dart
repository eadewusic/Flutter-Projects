import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/country_model.dart';

class CountryProvider extends ChangeNotifier {
  // List to store all fetched countries
  List<Country> _countries = [];

  // List to store countries filtered by the search query
  List<Country> _filteredCountries = [];

  // Flag to indicate if data is being fetched
  bool _isLoading = false;

  // Message to store any error that occurs during data fetching
  String _errorMessage = '';

  // Getter to return the filtered countries if any; otherwise, return all countries
  List<Country> get countries =>
      _filteredCountries.isNotEmpty ? _filteredCountries : _countries;

  // Getter to check if data is currently being fetched
  bool get isLoading => _isLoading;

  // Getter to retrieve the error message
  String get errorMessage => _errorMessage;

  // Fetch the list of countries from the REST Countries API
  Future<void> fetchCountries() async {
    _isLoading = true; // Set loading state to true before fetching
    _errorMessage = ''; // Clear previous error message
    notifyListeners(); // Notify listeners about state changes

    const url =
        'https://restcountries.com/v3.1/all'; // API endpoint to fetch all countries
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Map API response to a list of Country objects
        _countries = data.map<Country>((countryData) {
          // Extract languages; ensure it's a list of strings
          final languages = (countryData['languages'] != null &&
                  countryData['languages'] is Map)
              ? (countryData['languages'] as Map)
                  .values
                  .map<String>((lang) => lang.toString())
                  .toList()
              : <String>[];

          // Create a Country object with default values for missing data
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

        // Sort the countries alphabetically by name
        _countries.sort((a, b) => a.name.compareTo(b.name));
      } else {
        // Handle non-200 HTTP responses
        _errorMessage = 'Failed to load countries. Please try again.';
        throw Exception('Failed to load countries');
      }
    } catch (error) {
      // Handle errors like network issues
      debugPrint('Error fetching countries: $error');
      _errorMessage = 'Network error. Please check your connection.';
      _countries = []; // Clear the country list in case of an error
    } finally {
      _isLoading = false; // Set loading state to false after completion
      notifyListeners(); // Notify listeners about state changes
    }
  }

  // Filter the country list based on a search query
  void filterCountries(String query) {
    if (query.isEmpty) {
      _filteredCountries = []; // Reset filtered list if query is empty
    } else {
      // Filter countries whose names contain the search query
      _filteredCountries = _countries
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners about changes in the filtered list
  }
}
