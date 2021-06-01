import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

class F {
  F._();

  static bool isWeb(BuildContext context) {
    return isWebApplication
      ? MediaQuery.of(context).size.width >= webStartsWithWidth
      : false;
  }

  static List<dynamic> concatenateList(List<dynamic> list1, List<dynamic> list2) {
    try {
      list1.forEach((element1) {
        for(var element2 in list2) {
          if(element1.id == element2.id) {
            list1[list1.indexOf(element1)] = element2;
            break;
          }
        }
      });
      list2.forEach((element2) {
        if(!list1.contains(element2)) {
          list1.add(element2);
        }
      });
      return list1 ?? [];
    } catch (e) {
      return [];
    }
  }
}
