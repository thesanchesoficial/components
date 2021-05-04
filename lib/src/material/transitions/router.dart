import 'package:components_venver/material.dart';
import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

class OwRouter {
  const OwRouter._();

  static _goRouter(router, BuildContext context, bool removeUntil, {bool isPageResponsive = false}) {
    if(isPageResponsive) {
      if(removeUntil) {
        navigatorGlobalKey.currentState.pushAndRemoveUntil(router, (route) => false);
      } else {
        navigatorGlobalKey.currentState.push(router);
      }
    } else {
      openLink(context, router);
    }
  }

  static dynamic close(BuildContext context, [dynamic returned]) => Navigator.pop(context, returned);

  static PageRouteBuilder rightToLeft(BuildContext context, Widget page, {bool removeUntil = false, bool isPageResponsive = false}) => _goRouter(RightToLeft(page: page), context, removeUntil, isPageResponsive: isPageResponsive);

  static Future<dynamic> bottomStack(BuildContext context, Widget page, {bool secondPage = false, bool isPageResponsive = false}) => ScreenTransition.screenBottomSheet(context, page, secondPage: secondPage, isPageResponsive: isPageResponsive);
  
}



openModal(BuildContext context, Widget widget) async {
  if(MediaQuery.of(context).size.width > webStartsWithWidth) {
    return await showDialog(
      context: context,
      builder: (context) {
        return Container(
          width: 450,
          child: ModalWeb(widget),
        );
      }
    );
  } else {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => widget
    );
  }
}

openLink(BuildContext context, Widget widget) async {
  if(MediaQuery.of(context).size.width > webStartsWithWidth) {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            constraints: BoxConstraints(
              minWidth: 470
            ),
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width * 0.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget,
            ),
          ),
        );
      }
    );
  } else {
    return await Navigator.push(context, RightToLeft(page: widget));
    // return await OwRouter.rightToLeft(context, widget);
  }
}

class ModalWeb extends StatelessWidget {
  final Widget child;

  const ModalWeb(this.child);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(0),
        width: 450,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
          ],
        ),
      ),
    );
  }
}

