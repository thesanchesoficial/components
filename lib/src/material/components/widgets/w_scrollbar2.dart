import 'package:components_venver/src/functions/f.dart';
import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OwScrollbar2 extends StatelessWidget {
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

  OwScrollbar2({
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
    this.scrollPhysicsWeb,
    this.padding,
    this.child,
    this.scrollColor,
    this.scrollColorOpacity = 1,
    this.backgroundScrollColor,
  })  : super(key: key);

  bool _showAsWeb;
  Color _backgroundScrollColor;
  Color _scrollColor;

  @override
  Widget build(BuildContext context) {
    _showAsWeb = F.isWeb(context);
    _backgroundScrollColor = backgroundScrollColor ?? Theme.of(context).cardColor.withOpacity(.3);
    _scrollColor = scrollColor ?? Theme.of(context).primaryTextTheme.bodyText1.color.withOpacity(.65);

    return _hasBackgroundScroll()
      ? Column(
        children: [
          Expanded(
            child: _backgroundContainer(context),
          ),
        ],
      )
      : showScrollbar ?? _showAsWeb
        ? _rawScrollbar(context)
        : _page(context);
    // return showScrollbar ?? _showAsWeb
    //   ? _backgroundScroll() != null
    //     ? Container(
    //       BoxDecoration(
    //         border: Border(
    //           right: BorderSide(
    //             width: scrollbarThicknessMobile + 1, 
    //             color: _backgroundScrollColor,
    //           ),
    //         ),
    //       ),
    //       child: _rawScrollbar(context),
    //     )
    //     : _rawScrollbar(context)
    //   : _page(context);
  }

  Widget _backgroundContainer(BuildContext context) {
    double width = 2;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: width,
            color: _backgroundScrollColor,
          ),
        ),
      ),
      child: showScrollbar ?? _showAsWeb
        ? _rawScrollbar(context)
        : _page(context),
    );
  }

  Widget _rawScrollbar(BuildContext context) {
    return RawScrollbar(
      thumbColor: _scrollColor.withOpacity(scrollColorOpacity),
      controller: scrollController,
      child: _page(context),
      thickness: _showAsWeb
        ? scrollbarThicknessWeb
        : scrollbarThicknessMobile,
      isAlwaysShown: _showAsWeb
        ? scrollbarIsAlwaysShownOnWeb
        : scrollbarIsAlwaysShownOnMobile,
      radius: Radius.circular(scrollbarRadius),
    );
  }

  Widget _page(BuildContext context) {
    return Container(
      decoration: _hasBackgroundScroll()
        ? _backgroundScrollDecoration()
        : null,
      // child: useSingleChildScrollView
      //   ? _singleChildScrollView(context)
      //   : child,
      child: _singleChildScrollView(context),
    );
  }

  Widget _singleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      controller: scrollController,
      child: child,
      physics: _showAsWeb
        ? scrollPhysicsWeb
        : scrollPhysicsMobile,
    );
  }

  BoxDecoration _backgroundScrollDecoration() {
    if(_backgroundScrollColor != null) {
      double width;
      if(!_showAsWeb && scrollbarIsAlwaysShownOnMobile) {
        width = scrollbarThicknessMobile;
      } else if(_showAsWeb && scrollbarIsAlwaysShownOnWeb) {
        width = scrollbarThicknessWeb;
      }
      
      if(width != null) {
        return BoxDecoration(
          border: Border(
            right: BorderSide(
              width: width + 2, 
              color: _backgroundScrollColor,
            ),
          ),
        );
      }
    }
    return null;
  }

  bool _hasBackgroundScroll() {
    if(_backgroundScrollColor != null && (showScrollbar ?? _showAsWeb)) {
      if(!_showAsWeb && scrollbarIsAlwaysShownOnMobile) {
        return true;
      } else if(_showAsWeb && scrollbarIsAlwaysShownOnWeb) {
        return true;
      }
    }
    return false;
  }
}