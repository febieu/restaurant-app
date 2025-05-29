import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String? _error;

  ThemeMode get themeMode => _themeMode;
  String? get error => _error;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme(bool isDark) async {
    try{
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', isDark);
      _error = null;
    } catch (e) {
      _error = "Failed to change the theme: $e";
      notifyListeners();
    }

  }

  void _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDarkMode') ?? false;
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = "Failed to load a theme: $e";
      notifyListeners();
    }
  }
}