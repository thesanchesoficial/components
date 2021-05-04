import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

class F {
  F._();

  static bool isWeb(BuildContext context) {
    return isWebApplication
      ? MediaQuery.of(context).size.width >= webStartsWithWidth
      : false;
  }
}