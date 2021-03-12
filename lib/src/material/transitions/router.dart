import 'package:components_venver/material.dart';
import 'package:flutter/material.dart';

class OwRouter {
  const OwRouter._();

  static _goRouter(route, context) {
    Navigator.push(context, route);
  }

  static PageRouteBuilder rightToLeft(BuildContext context, Widget page) => _goRouter(RightToLeft(page: page), context);

  static PageRouteBuilder bottomStack(BuildContext context, Widget page, {bool secondPage = false}) => ScreenTransition.screenBottomSheet(context, page, secondPage: secondPage);
}