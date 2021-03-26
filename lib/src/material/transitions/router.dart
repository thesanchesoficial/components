import 'package:components_venver/material.dart';
import 'package:flutter/material.dart';

class OwRouter {
  const OwRouter._();

  static _goRouter(router, BuildContext context, bool removeUntil) {
    if(removeUntil) {
      navigatorGlobalKey.currentState.pushAndRemoveUntil(router, (route) => false);
    } else {
      navigatorGlobalKey.currentState.push(router);
    }
  }

  static close(BuildContext context) => Navigator.pop(context);

  static PageRouteBuilder rightToLeft(BuildContext context, Widget page, {bool removeUntil = false}) => _goRouter(RightToLeft(page: page), context, removeUntil);

  static Future<dynamic> bottomStack(BuildContext context, Widget page, {bool secondPage = false}) => ScreenTransition.screenBottomSheet(context, page, secondPage: secondPage);
}