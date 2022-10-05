import 'package:day_night_theme_animation/const.dart';
import 'package:day_night_theme_animation/provider/theme_provider.dart';
import 'package:day_night_theme_animation/screen/theme_screen.dart';
import 'package:day_night_theme_animation/theme/theme_style_dark.dart';
import 'package:day_night_theme_animation/theme/theme_style_light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    _getUserTheme();
  }

  //Get user theme from local storage
  void _getUserTheme() async {
    themeProvider.setThemePreference =
        (await themeProvider.themePreferencesImplementation.getTheme())!;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => themeProvider,
      child: const LightDarkThemeApp(),
    );
  }
}

class LightDarkThemeApp extends StatelessWidget {
  const LightDarkThemeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppLightTheme.lightTheme,
      darkTheme: AppDarkTheme.darkTheme,
      themeMode: theme.getThemePreferences == systemMode
          ? ThemeMode.system
          : theme.getThemePreferences == lightMode
          ? ThemeMode.light
          : theme.getThemePreferences == darkMode
          ? ThemeMode.dark
          : ThemeMode.system,
      home: const ThemeScreen(),
    );
  }
}

