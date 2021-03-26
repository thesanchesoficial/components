import 'package:components_venver/i18n.dart';
import 'package:flutter/widgets.dart';

class R {
  static Translations strings = PtBr();

  static void load(Locale locale) {
    switch (locale.toString()) {
      default:
        strings = PtBr();
    }
  }
}
