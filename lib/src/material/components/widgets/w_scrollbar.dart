import 'package:components_venver/src/functions/f.dart';
import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

class OwScrollbar extends StatelessWidget {
  final bool showScrollbar;
  final ScrollController scrollController;
  final double scrollbarThicknessWeb;
  final double scrollbarThicknessMobile;
  final bool scrollbarIsAlwaysShownOnWeb;
  final bool scrollbarIsAlwaysShownOnMobile;
  final double scrollbarRadius;
  final bool returnSingleChildScrollView;
  final ScrollPhysics scrollPhysicsMobile;
  final ScrollPhysics scrollPhysicsWeb;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final bool scrollbarBackground;
  final Color scrollColor;
  final double scrollColorOpacity;

  const OwScrollbar({
    Key key,
    this.showScrollbar,
    this.scrollController,
    this.scrollbarThicknessWeb,
    this.scrollbarThicknessMobile,
    this.scrollbarIsAlwaysShownOnWeb = true,
    this.scrollbarIsAlwaysShownOnMobile = false,
    this.scrollbarRadius = 5,
    this.returnSingleChildScrollView = true,
    this.scrollPhysicsMobile = const BouncingScrollPhysics(),
    this.scrollPhysicsWeb = const BouncingScrollPhysics(),
    this.padding,
    this.child,
    this.scrollbarBackground = false, // ! Terminar
    this.scrollColor = Colors.grey,
    this.scrollColorOpacity = 0.4,

  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showScrollbar = showScrollbar ?? F.isWeb(context);
    return _showScrollbar
      ? RawScrollbar(
        thumbColor: scrollColor.withOpacity(scrollColorOpacity),
        controller: scrollController,
        child: _child(context),
        // child: scrollbarBackground
        //   ? F.isWeb(context) && scrollbarIsAlwaysShownOnWeb
        //     ? 
        //   : null,
        thickness: F.isWeb(context)
          ? scrollbarThicknessWeb
          : scrollbarThicknessMobile,
        isAlwaysShown: F.isWeb(context)
          ? scrollbarIsAlwaysShownOnWeb
          : scrollbarIsAlwaysShownOnMobile,
        radius: Radius.circular(scrollbarRadius),
      )
      : _child(context);
  }

  Widget _child(BuildContext context) {
    return returnSingleChildScrollView
      ? SingleChildScrollView(
        padding: padding,
        controller: scrollController,
        child: child,
        physics: F.isWeb(context)
          ? scrollPhysicsWeb
          : scrollPhysicsMobile,
      )
      : Container(
        padding: padding,
        child: child,
      );
  }

  Widget _backgroundScroll() {
    return Container(
      width: 10,
      color: Colors.yellow,
    );
  }
}
