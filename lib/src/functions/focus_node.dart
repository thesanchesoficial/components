import 'dart:async';

import 'package:flutter/material.dart';

class FN {
  FN._();
  
  // It returns a list of initialized FocusNode instance
  static List<FocusNode> initialilzeFocusNodeList(int quantity) {
    List<FocusNode> returned = [];
    for(int i = 0; i < quantity; i++) {
      returned.add(FocusNode());
    }
    return returned;
  }

  // It calls dispose() for each focusNode from listFn
  static void disposeFocusNodeList(List<FocusNode> listFn) {
    listFn?.forEach((element) {
      element?.dispose();
    });
  }

  // Request next focus
  static nextFn(BuildContext context, FocusNode nextFn) {
    Timer(const Duration(milliseconds: 1), () {
      FocusScope.of(context).requestFocus(nextFn);
    });
  }

  // Unfocus
  static unfocusFn(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// It uses a FocusNode list and an index to get the FocusNode instance
  static FocusNode getFnByList(List<FocusNode> focusNodeList, int focusNodeIndex) {
    if(
      focusNodeIndex != null &&
      focusNodeList != null && 
      focusNodeList.length > focusNodeIndex
    ) {
      return focusNodeList[focusNodeIndex];
    }
    return null;
  }

  /// It uses a FocusNode list and an index to get the next FocusNode instance 
  /// (index + 1)
  static FocusNode getNextFnByList(List<FocusNode> focusNodeList, int focusNodeIndex) {
    return getFnByList(focusNodeList, focusNodeIndex + 1);
  }
}