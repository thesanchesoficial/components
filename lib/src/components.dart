library components;
// ignore: non_constant_identifier_names
import 'package:bot_toast/bot_toast.dart';
import 'package:components_venver/settings/settings.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
TransitionBuilder ComponentsInit() {
  navigatorKey = GlobalKey<NavigatorState>();
  return BotToastInit();
}
