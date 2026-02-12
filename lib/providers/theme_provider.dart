import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  bool darkMode = false;

  void loadDarkModePrefs() async {
    final prefs = SharedPreferencesAsync();
    bool? mode = await prefs.getBool("darkMode");
    setDarkMode(mode!);
    }

  void setDarkMode(bool mode) async {
    darkMode = mode;
    notifyListeners();
    final prefs = SharedPreferencesAsync();
    await prefs.setBool("darkMode", mode);
  }
}