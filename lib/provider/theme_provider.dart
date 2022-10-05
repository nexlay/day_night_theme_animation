import 'package:day_night_theme_animation/provider/repository/repository_impl.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreferencesImplementation themePreferencesImplementation = ThemePreferencesImplementation();
  double _theme = 0;

  double get getThemePreferences => _theme;

  set setThemePreference(double value){
    _theme = value;
    themePreferencesImplementation.setTheme(_theme);
    notifyListeners();
  }
}