import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/foundation.dart';

void p([dynamic string]) {
  if (_isPrintEnabled()) {
    final ms = DateTime.now().millisecondsSinceEpoch;
    print("[$ms]: $string");
  }
}

void pList([List list]) {
  if (_isPrintEnabled()) {
    if (list != null) {
      p("List - length: ${list.length} - type: ${list.runtimeType}");
      for (int i = 0; i < list.length; i++)
        print("[$i]: ${list[i]}");
    } else {
      p("List = null");
    }
  } 
}

bool _isPrintEnabled() {
  return !kReleaseMode && !hidePrintApplication;
}