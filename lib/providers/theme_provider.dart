import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// add the seed color to our theme provider 
// update main.dart to use the theme provider seed color
// add a function here as well to set the seed color

class ThemeProvider extends ChangeNotifier {

  bool darkMode = false;

  Color seedColor = const Color.fromARGB(255, 84, 164, 85);

  void setSeedColor(Color color){
    seedColor = color;
    notifyListeners();
  }

  void loadDarkModePrefs() async {
    final prefs = SharedPreferencesAsync();
    bool? mode = await prefs.getBool("darkMode");
    if (mode != null){
      setDarkMode(mode);
    }
    
    }

  void setDarkMode(bool mode) async {
    darkMode = mode;
    notifyListeners();
    final prefs = SharedPreferencesAsync();
    await prefs.setBool("darkMode", mode);
  }
}