import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

class F {
  F._();

  static bool isWeb(BuildContext context) {
    return isWebApplication
      ? MediaQuery.of(context).size.width >= webStartsWithWidth
      : false;
  }

  // It returns a list of initialized FocusNode instance
  static List<FocusNode> initialilzeFocusNodeList(int quantity) {
    List<FocusNode> returned = [];
    for(int i = 0; i < quantity; i++) {
      returned.add(FocusNode());
    }
    return returned;
  }
}