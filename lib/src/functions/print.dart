import 'dart:io';

import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/foundation.dart';

class ShowPrintOn { // ! Mover para models
  final bool android;
  final bool fuchsia;
  final bool ios;
  final bool linux;
  final bool mac;
  final bool web;
  final bool windows;

  ShowPrintOn({
    this.android = false,
    this.fuchsia = false,
    this.ios = false,
    this.linux = false,
    this.mac = false,
    this.web = false,
    this.windows = false,
  });

  bool showOnThisDevice() {
    if(this.android && Platform.isAndroid) return true;
    if(this.ios && Platform.isIOS) return true;
    if(this.web && kIsWeb) return true;
    if(this.windows && Platform.isWindows) return true;
    if(this.mac && Platform.isMacOS) return true;
    if(this.linux && Platform.isLinux) return true;
    if(this.fuchsia && Platform.isFuchsia) return true;
    return false;
  }
}

void p([dynamic object, ShowPrintOn showPrintOn]) {
  // if(object is List) {
  //   pList(object, showPrintOn);
  // } else if(object is Map) {
  //   pMap(object, showPrintOn);
  // } else

  if(_isPrintEnabled(showPrintOn)) {
    final time = DateTime.now().millisecondsSinceEpoch;
    print("[$time]: $object");
  }
}

void pList([List list, ShowPrintOn showPrintOn]) {
  if(_isPrintEnabled(showPrintOn)) {
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

void pMap([Map map, ShowPrintOn showPrintOn]) {
  if(_isPrintEnabled(showPrintOn)) {
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

bool _isPrintEnabled([ShowPrintOn showPrintOn]) {
  bool showOnDevice = showPrintOn?.showOnThisDevice() ?? true;
  return !kReleaseMode && !hidePrintApplication && showOnDevice;
}