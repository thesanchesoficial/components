library components;
// ignore: non_constant_identifier_names
import 'package:bot_toast/bot_toast.dart';
import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorGlobalKey = GlobalKey<NavigatorState>();

// ignore: non_constant_identifier_names
TransitionBuilder ComponentsInit({
  hidePrint = false,
  isWeb = false,
}) {
  hidePrintApplication = hidePrint;
  isWebApplication = isWeb;
  return BotToastInit();
}
