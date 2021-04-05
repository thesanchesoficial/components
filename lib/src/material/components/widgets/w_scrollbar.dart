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
     Color scrollColor;
  final double scrollColorOpacity;
  Color backgroundScrollColor;

  OwScrollbar({
    Key key,
    this.showScrollbar,
    this.scrollController,
    this.scrollbarThicknessWeb = 15,
    this.scrollbarThicknessMobile = 8,
    this.scrollbarIsAlwaysShownOnWeb = true,
    this.scrollbarIsAlwaysShownOnMobile = false,
    this.scrollbarRadius = 5,
    this.useSingleChildScrollView = true,
    this.scrollPhysicsMobile = const BouncingScrollPhysics(),
    this.scrollPhysicsWeb, // = const BouncingScrollPhysics(),
    this.padding,
    this.child,
    this.scrollColor,
    this.scrollColorOpacity = 1,
    this.backgroundScrollColor,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    backgroundScrollColor = backgroundScrollColor ?? Theme.of(context).cardColor.withOpacity(.3);
    scrollColor = scrollColor ?? Theme.of(context).secondaryHeaderColor;
    bool _showAsWeb = isWebApplication ? F.isWeb(context) : false; // isWebApplication; // F.isWeb(context); // * Once, or using width
      // Se for deixar assim, alterar direto na função F.isWeb(context);
    bool _showScrollbar = showScrollbar ?? _showAsWeb;
    return _showScrollbar
      ? Padding(
        padding: const EdgeInsets.only(right: 2),
        child: RawScrollbar(
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
        ),
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
              width: scrollbarThicknessWeb + 2, 
              color: backgroundScrollColor,
            ),
          ),
        );
      }
    }
    return null;
  }
}
