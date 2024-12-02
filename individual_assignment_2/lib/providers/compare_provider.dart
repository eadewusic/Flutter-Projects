import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/country_model.dart';

/// A provider class to manage the state for country comparison and history.
class CompareProvider extends ChangeNotifier {
  // List to store countries selected for comparison (maximum 2).
  final List<Country> _compareList = [];

  // List to store the history of comparisons made (each entry is a pair of countries).
  final List<List<Country>> _historyList = [];

  // Holds the error message if any invalid actions occur (e.g., exceeding 2 countries in comparison).
  String _errorMessage = '';

  // Getter to access the current list of countries selected for comparison.
  List<Country> get compareList => _compareList;

  // Getter to access the history of comparisons.
  List<List<Country>> get historyList => _historyList;

  // Getter to retrieve the current error message.
  String get errorMessage => _errorMessage;

  /// Adds or removes a country from the comparison list.
  /// If the list already contains the country, it removes it.
  /// If the list has fewer than 2 countries, it adds the new country.
  /// Sets an error message if attempting to add more than 2 countries.
  void toggleCompare(Country country) {
    if (_compareList.contains(country)) {
      _compareList
          .remove(country); // Remove if the country is already selected.
      _errorMessage = ''; // Reset error message.
    } else if (_compareList.length < 2) {
      _compareList.add(country); // Add the country if there's space.
      _errorMessage = ''; // Reset error message.
    } else {
      _errorMessage =
          'You can only compare 2 countries at a time!'; // Set error if list is full.
    }
    notifyListeners(); // Notify listeners about the change.
  }

  /// Adds the current comparison (if it contains exactly 2 countries) to the history list.
  void addComparisonToHistory() {
    if (_compareList.length == 2) {
      _historyList
          .add(List.from(_compareList)); // Save a copy of the comparison list.
    }
    notifyListeners(); // Notify listeners about the updated history.
  }

  /// Clears the comparison list and resets the error message.
  void clearCompareList() {
    _compareList.clear(); // Clear all selected countries.
    _errorMessage = ''; // Reset error message.
    notifyListeners(); // Notify listeners about the cleared list.
  }

  /// Checks if a specific country is already in the comparison list.
  bool isInCompareList(Country country) {
    return _compareList
        .contains(country); // Return true if the country is in the list.
  }
}
