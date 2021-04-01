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
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showScrollbar = showScrollbar ?? isWebApplication;
    return _showScrollbar
      ? Scrollbar(
        controller: scrollController,
        child: _child(),
        thickness: isWebApplication
          ? scrollbarThicknessWeb
          : scrollbarThicknessMobile,
        isAlwaysShown: isWebApplication
          ? scrollbarIsAlwaysShownOnWeb
          : scrollbarIsAlwaysShownOnMobile,
        radius: Radius.circular(scrollbarRadius),
      )
      : _child();
  }

  Widget _child() {
    return returnSingleChildScrollView
      ? SingleChildScrollView(
        padding: padding,
        controller: scrollController,
        child: child,
        physics: isWebApplication
          ? scrollPhysicsWeb
          : scrollPhysicsMobile,
      )
      : Container(
        padding: padding,
        child: child,
      );
  }
}
