import 'package:flutter/foundation.dart';

void p([dynamic string, bool hidePrint = false]) {
  if (kReleaseMode && !hidePrint) {
    final ms = DateTime.now().millisecondsSinceEpoch;
    print("[$ms]: $string");
  }
}