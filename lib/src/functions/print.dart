import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/foundation.dart';

void p([dynamic string]) {
  if(_isPrintEnabled()) {
    final time = DateTime.now().millisecondsSinceEpoch;
    print("[$time]: $string");
  }
}

void pList([List list]) {
  if(_isPrintEnabled()) {
    if(list != null) {
      p("${list.runtimeType} (length: ${list.length})");
      for(int i = 0; i < list.length; i++) {
        print("[$i]: ${list[i]}");
      }
    } else {
      p("List = null");
    }
  }
}

void pMap([Map map]) {
  if(_isPrintEnabled()) {
    if(map != null) {
      p("${map.runtimeType} (length: ${map.length})");
      map?.forEach((key, value) {
        print("$key: $value");
      });
    } else {
      p("Map = null");
    }
  }
}

bool _isPrintEnabled() {
  return !kReleaseMode && !hidePrintApplication;
}