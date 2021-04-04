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
  final bool useSingleChildScrollView;
  final ScrollPhysics scrollPhysicsMobile;
  final ScrollPhysics scrollPhysicsWeb;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Color scrollColor;
  final double scrollColorOpacity;
  final Color backgroundScrollColor;

  const OwScrollbar({
    Key key,
    this.showScrollbar,
    this.scrollController,
    this.scrollbarThicknessWeb,
    this.scrollbarThicknessMobile,
    this.scrollbarIsAlwaysShownOnWeb = true,
    this.scrollbarIsAlwaysShownOnMobile = false,
    this.scrollbarRadius = 5,
    this.useSingleChildScrollView = true,
    this.scrollPhysicsMobile = const BouncingScrollPhysics(),
    this.scrollPhysicsWeb, // = const BouncingScrollPhysics(),
    this.padding,
    this.child,
    this.scrollColor = Colors.grey,
    this.scrollColorOpacity = 1,
    this.backgroundScrollColor,

  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showAsWeb = isWebApplication ? F.isWeb(context) : false; // isWebApplication; // F.isWeb(context); // * Once, or using width
      // Se for deixar assim, alterar direto na função F.isWeb(context);
    bool _showScrollbar = showScrollbar ?? _showAsWeb;
    return _showScrollbar
      ? RawScrollbar(
        thumbColor: scrollColor.withOpacity(scrollColorOpacity),
        controller: scrollController,
        child: _page(context, _showAsWeb),
        thickness: _showAsWeb
          ? scrollbarThicknessWeb
          : scrollbarThicknessMobile,
        isAlwaysShown: _showAsWeb
          ? scrollbarIsAlwaysShownOnWeb
          : scrollbarIsAlwaysShownOnMobile,
        radius: Radius.circular(scrollbarRadius),
      )
      : _page(context, _showAsWeb);
  }

  Widget _page(BuildContext context, bool showAsWeb) {
    return Container(
      padding: padding,
      decoration: _backgroundScroll(showAsWeb),
      child: useSingleChildScrollView
        ? _singleChildScrollView(context, showAsWeb)
        : child,
    );
  }

  Widget _singleChildScrollView(BuildContext context, bool showAsWeb) {
    return SingleChildScrollView(
      padding: padding,
      controller: scrollController,
      child: child,
      physics: showAsWeb
        ? scrollPhysicsWeb
        : scrollPhysicsMobile,
    );
  }

  BoxDecoration _backgroundScroll(bool showAsWeb) {
    if(backgroundScrollColor != null) {
      if(!showAsWeb && scrollbarIsAlwaysShownOnMobile) {
        return BoxDecoration(
          border: Border(
            right: BorderSide(
              width: scrollbarThicknessMobile + 1, 
              color: backgroundScrollColor,
            ),
          ),
        );
      } else if(showAsWeb && scrollbarIsAlwaysShownOnWeb) {
        return BoxDecoration(
          border: Border(
            right: BorderSide(
              width: scrollbarThicknessWeb + 1, 
              color: backgroundScrollColor,
            ),
          ),
        );
      }
    }
    return null;
  }
}
