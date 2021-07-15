import 'package:flutter/material.dart';

class AppTheme {
  static final Color error = Colors.red;
  static final Color verdeVenver = Color(0xff12aa4b);

  static final MaterialColor myGreen = const MaterialColor(
    0xff12aa4b,
    const {
      50 : const Color(0xFF36443B),
      100 : const Color(0xFF4BE285),
      200 : const Color(0xFF49DB81),
      300 : const Color(0xFF31D16E),
      400 : const Color(0xFF1BBD59),
      500 : const Color(0xff12aa4b),
      600 : const Color(0xFF14A049),
      700 : const Color(0xFF0C9942),
      800 : const Color(0xFF0A8B3C),
      900 : const Color(0xFF078638)
    }
  );

  static final SliderThemeData sliderTheme = SliderThemeData(
    activeTrackColor: verdeVenver,
    inactiveTrackColor: verdeVenver.withOpacity(0.2),
    trackShape: RoundedRectSliderTrackShape(),
    trackHeight: 4,
    overlayShape: RoundSliderOverlayShape(overlayRadius: 28),
    tickMarkShape: RoundSliderTickMarkShape(),
    overlayColor: verdeVenver.withOpacity(0.2),
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
    thumbColor: verdeVenver,
    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
    valueIndicatorTextStyle: TextStyle(color: Colors.white),
    activeTickMarkColor: Colors.black,
    disabledActiveTickMarkColor: Colors.black,
    inactiveTickMarkColor: Colors.black.withOpacity(0.2),
    valueIndicatorColor: verdeVenver,
  );

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: myGreen,
    toggleableActiveColor: verdeVenver,
    unselectedWidgetColor: verdeVenver,
    backgroundColor: Color(0xffffffff),
    bottomAppBarColor: Color(0xffffffff),
    splashColor: Color(0xfffafafa),
    scaffoldBackgroundColor: Color(0xffffffff),
    primaryColor: Color(0xfffdfdfd),
    brightness: Brightness.light,
    buttonColor: Color(0xfff2f2f2),
    secondaryHeaderColor: Colors.grey[200],
    cardColor: Colors.grey[300],
    accentColor: verdeVenver, 
    primaryColorBrightness: Brightness.light,
    sliderTheme: sliderTheme,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Color(0xffffffff),
      backgroundColor: verdeVenver,
      elevation: 0.0,
      actionsIconTheme: IconThemeData(
        color: verdeVenver,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: myGreen,
    toggleableActiveColor: verdeVenver,
    unselectedWidgetColor: verdeVenver,
    backgroundColor: Color(0xff1b1b1b),
    bottomAppBarColor: Color(0xff1b1b1b),
    scaffoldBackgroundColor: Color(0xff1b1b1b),
    primaryColor: Color(0xff1b1b1b),
    splashColor: Color(0xff222222),
    brightness: Brightness.dark,
    accentColor: verdeVenver,
    buttonColor: Color(0xff1b1b1b),
    secondaryHeaderColor: Colors.grey[900],
    cardColor: Colors.grey[800],
    primaryColorBrightness: Brightness.dark,
    sliderTheme: sliderTheme,
    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(color: Color(0xffd1d1d1)),
      headline6: TextStyle(color: Color(0xffd1d1d1)),
    ),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        caption: TextStyle(color: verdeVenver,),
        headline1: TextStyle(color: verdeVenver,),
        headline2: TextStyle(color: verdeVenver,),
      ),
      brightness: Brightness.dark,
      color: Color(0xff1b1b1b),
      elevation: 0.0,
      actionsIconTheme: IconThemeData(
        color: verdeVenver,
      ),
    ),
  );
}
