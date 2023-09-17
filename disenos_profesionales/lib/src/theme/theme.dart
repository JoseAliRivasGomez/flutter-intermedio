import 'package:flutter/material.dart';


class ThemeChanger with ChangeNotifier {

  bool _darkTheme   = false;
  bool _customTheme = false;

  late ThemeData _currentTheme;

  bool get darkTheme   => _darkTheme;
  bool get customTheme => _customTheme;
  ThemeData get currentTheme => _currentTheme;


  ThemeChanger( int theme ) {

    switch( theme ) {

      case 1: // light
        _darkTheme   = false;
        _customTheme = false;
        _currentTheme = ThemeData.light().copyWith(
          primaryColor: Colors.blue
        );
      break;

      case 2: // Dark
        _darkTheme   = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark().copyWith(
          primaryColor: Colors.blue
        );
      break;

      case 3: // Dark
        _darkTheme   = false;
        _customTheme = true;
      break;

      default:
        _darkTheme = false;
        _darkTheme = false;
        _currentTheme = ThemeData.light();
    }
  }



  set darkTheme( bool value ) {
    _customTheme = false;
    _darkTheme = value;

    if ( value ) {
      _currentTheme = ThemeData.dark().copyWith(
          primaryColor: Colors.blue
      );
    } else {
      _currentTheme = ThemeData.light().copyWith(
          primaryColor: Colors.blue
      );
    }

    notifyListeners();
  }

  set customTheme( bool value ) {
    _customTheme = value;
    _darkTheme = false;

    if ( value ) {
      _currentTheme = ThemeData.dark().copyWith(
          primaryColor: const Color(0xff48A0EB),
          primaryColorLight: Colors.white,
          scaffoldBackgroundColor: const Color(0xff16202B),
          textTheme: const TextTheme(
            bodyLarge: TextStyle( color: Colors.white )
          ),
          // textTheme.body1.color
      );
    } else {
      _currentTheme = ThemeData.light();
    }

    notifyListeners();
  }

}