import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class Favorites extends ChangeNotifier {
  // List to store favorite items
  List<String> _items = [];
  bool _isLoading = true; // Flag to track if the data is loading
  String? _errorMessage; // Holds any error messages for UI display
  final Logger _logger = Logger(); // Logger for error logging

  // Getter for favorite items
  List<String> get items => _items;
  bool get isLoading => _isLoading; // Getter for loading state
  String? get errorMessage => _errorMessage; // Getter for error message

  // Constructor to initialize and load favorites from shared preferences
  Favorites() {
    _loadFavorites(); // Load favorites as soon as the Favorites object is created
  }

  // Loads favorite items from shared preferences asynchronously
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences
          .getInstance(); // Get shared preferences instance
      _items = prefs.getStringList('favorites') ??
          []; // Load favorites list or initialize as empty
    } catch (e) {
      // Log the error and set an error message
      _logger.e("Failed to load favorites", error: e);
      _errorMessage = "Failed to load favorites. Please try again.";
    } finally {
      _isLoading = false; // Set loading to false once the operation is complete
      notifyListeners(); // Notify listeners (UI) that the data has been loaded
    }
  }

  // Saves favorite items to shared preferences
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', _items); // Save the favorites list
    } catch (e) {
      // Log the error and set an error message
      _logger.e("Failed to save favorites", error: e);
      _errorMessage = "Failed to save favorites. Please try again.";
    }
  }

  // Adds an item to the favorites list and saves it
  void addItem(String item) {
    if (!_items.contains(item)) {
      _items.add(item); // Add item to list if not already in favorites
      _saveFavorites(); // Save updated list
      notifyListeners(); // Notify UI of the change
    }
  }

  // Removes an item from the favorites list and saves it
  void removeItem(String item) {
    _items.remove(item); // Remove item from list
    _saveFavorites(); // Save updated list
    notifyListeners(); // Notify UI of the change
  }
}
