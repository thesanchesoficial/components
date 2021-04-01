library components;
import 'package:bot_toast/bot_toast.dart';
import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorGlobalKey = GlobalKey<NavigatorState>();

// ignore: non_constant_identifier_names
TransitionBuilder ComponentsInit({
  bool hidePrint = false,
  bool isWeb = false,
  double webWidth = 500,
}) {
  hidePrintApplication = hidePrint;
  isWebApplication = isWeb;
  webStartsWithWidth = webWidth;
  return BotToastInit();
}
