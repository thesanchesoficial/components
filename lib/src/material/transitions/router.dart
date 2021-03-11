import 'package:components_venver/material.dart';
import 'package:flutter/material.dart';

class MNRouter {
  const MNRouter._();

  static goRouter(route, context) {
    Navigator.push(context, route);
  }

  static PageRouteBuilder rightToLeft(Widget page, BuildContext context) => goRouter(RightToLeft(page: page), context);
}