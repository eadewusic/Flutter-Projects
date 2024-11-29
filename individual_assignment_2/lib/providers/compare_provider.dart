import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CompareProvider extends ChangeNotifier {
  final List<Country> _compareList = [];
  String _errorMessage = '';

  List<Country> get compareList => _compareList;
  String get errorMessage => _errorMessage;

  void toggleCompare(Country country) {
    // If the country is already in the compare list, remove it
    if (_compareList.contains(country)) {
      _compareList.remove(country);
      _errorMessage = ''; // Clear any error when removing
    }
    // If the country is not in the compare list, add it
    else if (_compareList.length < 2) {
      _compareList.add(country);
      _errorMessage = ''; // Clear any error when adding a country
    }
    // If more than 2 countries are selected, set an error message
    else {
      _errorMessage = 'You can only compare 2 countries at a time!';
    }

    notifyListeners();
  }

  bool isInCompareList(Country country) {
    return _compareList.contains(country);
  }

  void clearCompareList() {
    _compareList.clear();
    _errorMessage = ''; // Clear error when the list is cleared
    notifyListeners();
  }

  void resetComparison() {}
}
