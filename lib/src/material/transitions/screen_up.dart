import 'package:flutter/material.dart';

class ScreenTransition {
  ScreenTransition._();

  static screenBottomSheet(
    BuildContext context, 
    Widget page, 
    {bool secondPage: false, 
    bool isPageResponsive = false,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      elevation: secondPage ? 0 : null,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height - 20,
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              secondPage ? Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                ),
              ) : SizedBox(),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 5
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    child: page
                  )
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}