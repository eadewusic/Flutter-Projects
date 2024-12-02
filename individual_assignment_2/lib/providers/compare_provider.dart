import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CompareProvider extends ChangeNotifier {
  final List<Country> _compareList = [];
  final List<List<Country>> _historyList = [];
  String _errorMessage = '';

  List<Country> get compareList => _compareList;
  List<List<Country>> get historyList => _historyList;
  String get errorMessage => _errorMessage;

  void toggleCompare(Country country) {
    if (_compareList.contains(country)) {
      _compareList.remove(country);
      _errorMessage = '';
    } else if (_compareList.length < 2) {
      _compareList.add(country);
      _errorMessage = '';
    } else {
      _errorMessage = 'You can only compare 2 countries at a time!';
    }
    notifyListeners();
  }

  void addComparisonToHistory() {
    if (_compareList.length == 2) {
      _historyList.add(List.from(_compareList));
    }
    notifyListeners();
  }

  void clearCompareList() {
    _compareList.clear();
    _errorMessage = '';
    notifyListeners();
  }

  bool isInCompareList(Country country) {
    return _compareList.contains(country);
  }
}
