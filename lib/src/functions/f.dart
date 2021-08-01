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
      return list1;
    } catch (e) {
      return [];
    }
  }

  // Testar
  void nonNullAssert(List<dynamic> objects, [String constructor]) {
    assert(objects != null);
    objects.forEach((element) {
      String assertMessage = "${element.runtimeType} != null is not true";
      if(constructor != null) assertMessage += " (called by $constructor)";
      assert(element != null, assertMessage);
    });
  }

  /*
  void func(Function f, Duration d, {TempFunction tempFunction, int times, bool awaitFunction = true}) async {
    if(times == null || times > 0) {
      
      await Future.delayed(d);
      if(awaitFunction) {
        await f();
      } else {
        f();
      }
      if(times == null) {
        func(f, d);
      } else {
        func(f, d, times: times - 1, awaitFunction: awaitFunction);
      }
    }
  }

class TempFunction {
  int times;
  bool awaitFunction;
  void Function() dispose;
  
  TempFunction({
    this.times,
    this.awaitFunction,
  });
}
  */
}
