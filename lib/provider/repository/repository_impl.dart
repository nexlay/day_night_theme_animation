import 'package:day_night_theme_animation/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:day_night_theme_animation/provider/repository/theme_repository.dart';

class ThemePreferencesImplementation extends ThemePreferences {
  //Get theme value: 1 - system, 2 - light, 3 - dark
  @override
  Future<double?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(themeStatus);
  }

  //Set theme value: 1 - system, 2 - light, 3 - dark
  @override
  Future<bool> setTheme(double themeValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setDouble(themeStatus, themeValue);
  }
}
