import 'package:day_night_theme_animation/const.dart';
import 'package:day_night_theme_animation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

SMINumber? _stateInput;

late double _sliderValue;

void _onRiveInit(Artboard artboard) async {
  final controller = StateMachineController.fromArtboard(artboard, 'theme');
  artboard.addController(controller!);
  _stateInput = controller.findInput<double>('value') as SMINumber;
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    //Provider
    final theme = Provider.of<ThemeProvider>(context);

    //Set theme value when the app opened again
    _stateInput?.value = theme.getThemePreferences;
    _sliderValue = theme.getThemePreferences;


    var brightness = MediaQuery.of(context).platformBrightness;
   //Check if setting auto theme mode
    if(theme.getThemePreferences == systemMode && brightness == Brightness.light){
      _stateInput?.value = systemLightMode;
    } else if(theme.getThemePreferences == systemMode && brightness == Brightness.dark) {
      _stateInput?.value = systemDarkMode;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 40.0,
              children: [
                const Text(
                  themeDesc,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                  child: const RiveAnimation.asset(
                    'assets/app_theme.riv',
                    onInit: _onRiveInit,
                    fit: BoxFit.contain,
                  ),
                ),
                Wrap(
                  children:[
                Slider.adaptive(
                  max: 2,
                  min: 0,
                  label: list.elementAt(
                    _sliderValue.toInt(),
                  ),
                  value: _sliderValue,
                  onChanged: (double value) {
                    setState(
                      () {
                        //0 - system, 1- light, 2 - dark
                        theme.setThemePreference = value;

                        //Check if setting auto theme mode
                        if(theme.getThemePreferences == systemMode && brightness == Brightness.light){
                          _stateInput?.value = systemLightMode;
                        } else if(theme.getThemePreferences == systemMode && brightness == Brightness.dark) {
                          _stateInput?.value = systemDarkMode;
                        } else {
                          _stateInput?.value = value;
                        }

                        //play animation
                          _onRiveInit((_stateInput?.controller.artboard)!);
                        }
                    );
                  },
                  divisions: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                List<Widget>.generate(
                  list.length,
                  (index) => Text(
                    list.elementAt(index),
                  ),
                ).toList(),
                ),
                    ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
