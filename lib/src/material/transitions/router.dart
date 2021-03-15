import 'package:components_venver/material.dart';
import 'package:components_venver/settings/settings.dart';
import 'package:flutter/material.dart';

class OwRouter {
  const OwRouter._();

  static _goRouter(router, context, removeUntil) {
    Settings().navigatorKey.currentState.push(router);
    // if(removeUntil) {
    //   Navigator.pushAndRemoveUntil(context, router, (route) => false);
    // } else {
    //   Navigator.push(context, router);
    // }
  }

  static close(BuildContext context) => Navigator.pop(context);

  static PageRouteBuilder rightToLeft(BuildContext context, Widget page, {bool removeUntil = false}) => _goRouter(RightToLeft(page: page), context, removeUntil);

  static PageRouteBuilder bottomStack(BuildContext context, Widget page, {bool secondPage = false}) => ScreenTransition.screenBottomSheet(context, page, secondPage: secondPage);
}