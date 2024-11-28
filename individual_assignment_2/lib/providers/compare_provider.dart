import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CompareProvider with ChangeNotifier {
  final List<Country> _compareList = [];

  List<Country> get compareList => _compareList;

  void addCountry(Country country) {
    if (_compareList.length < 2) {
      _compareList.add(country);
      notifyListeners();
    }
  }

  void removeCountry(Country country) {
    _compareList.remove(country);
    notifyListeners();
  }

  void resetComparison() {
    _compareList.clear();
    notifyListeners();
  }

  void toggleCompare(country) {}

  isInCompareList(country) {}
}
