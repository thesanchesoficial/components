library components;
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class OwNavigation {
  GlobalKey<NavigatorState> start() {
    return navigatorKey = GlobalKey<NavigatorState>();
  }
}

class Settings {
}
