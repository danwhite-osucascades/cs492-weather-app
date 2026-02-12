import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  bool darkMode = true;

  void setDarkMode(bool mode){
    darkMode = mode;
    notifyListeners();
  }
}