import 'package:components_venver/material.dart';
import 'package:flutter/material.dart';

class OwRouter {
  const OwRouter._();

  static _goRouter(route, context) {
    Navigator.push(context, route);
  }

  static PageRouteBuilder rightToLeft(BuildContext context, Widget page) => _goRouter(RightToLeft(page: page), context);
}