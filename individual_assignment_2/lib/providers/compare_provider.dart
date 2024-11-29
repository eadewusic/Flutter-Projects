import 'package:flutter/foundation.dart';
import '../models/country_model.dart';

class CompareProvider extends ChangeNotifier {
  final List<Country> _compareList = [];

  List<Country> get compareList => _compareList;

  void toggleCompare(Country country) {
    if (_compareList.contains(country)) {
      _compareList.remove(country);
    } else if (_compareList.length < 2) {
      _compareList.add(country);
    }
    notifyListeners();
  }

  bool isInCompareList(Country country) {
    return _compareList.contains(country);
  }

  void clearCompareList() {
    _compareList.clear();
    notifyListeners();
  }

  void resetComparison() {}
}
