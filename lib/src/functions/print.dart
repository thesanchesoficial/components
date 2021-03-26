import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/foundation.dart';

void p([dynamic string]) {
  if (!kReleaseMode && !hidePrintApplication) {
    final ms = DateTime.now().millisecondsSinceEpoch;
    print("[$ms]: $string");
  }
}