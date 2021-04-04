import 'package:components_venver/material.dart';
import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/material.dart';

class OwScaffold extends StatelessWidget {
  final Future<bool> Function() onWillPop;
  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget drawer;
  final Widget floatingActionButton;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final FloatingActionButtonLocation floatingActionButtonLocation;
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

  const OwScaffold({
    Key key, 
    this.onWillPop,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.drawer,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.showScrollbar,
    this.scrollController,
    this.scrollbarThicknessWeb = 20,
    this.scrollbarThicknessMobile = 10,
    this.scrollbarRadius = 5,
    this.scrollbarIsAlwaysShownOnWeb = true,
    this.scrollbarIsAlwaysShownOnMobile = false,
    this.returnSingleChildScrollView = true,
    this.scrollPhysicsMobile = const BouncingScrollPhysics(),
    this.scrollPhysicsWeb = const BouncingScrollPhysics(),
    this.padding,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showScrollbar = showScrollbar ?? isWebApplication;
    return onWillPop != null
      ? WillPopScope(
        key: onWillPop != null
          ? key
          : null,
        onWillPop: onWillPop,
        child: _scaffold(_showScrollbar),
      )
      : _scaffold(_showScrollbar);
  }

  Widget _scaffold(bool _showScrollbar) {
    return Scaffold(
      key: onWillPop != null
        ? key
        : null,
      appBar: appBar,
      body: _showScrollbar
        ? _scrollbar()
        : _body(),
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }

  Widget _scrollbar() {
    return OwScrollbar(
      scrollController: scrollController,
      child: _body(),
      scrollbarThicknessMobile: scrollbarThicknessMobile,
      scrollbarThicknessWeb: scrollbarThicknessWeb,
      scrollbarIsAlwaysShownOnMobile: scrollbarIsAlwaysShownOnMobile,
      scrollbarIsAlwaysShownOnWeb: scrollbarIsAlwaysShownOnWeb,
      scrollbarRadius: scrollbarRadius,
    );
  }

  Widget _body() {
    return returnSingleChildScrollView
      ? SingleChildScrollView(
        padding: padding,
        controller: scrollController,
        child: body,
        physics: isWebApplication
          ? scrollPhysicsWeb
          : scrollPhysicsMobile,
      )
      : Container(
        padding: padding,
        child: body,
      );
  }
}




// class OwScaffold extends StatefulWidget {
//   final Future<bool> Function() onWillPop;
//   final PreferredSizeWidget appBar;
//   final Widget body;
//   final Widget bottomNavigationBar;
//   final Widget drawer;
//   final Widget floatingActionButton;
//   final FloatingActionButtonAnimator floatingActionButtonAnimator;
//   final FloatingActionButtonLocation floatingActionButtonLocation;
//   final bool showScrollbar;
//   final ScrollController scrollController;
//   final double scrollbarThicknessWeb;
//   final double scrollbarThicknessMobile;
//   final bool scrollbarIsAlwaysShownOnWeb;
//   final bool scrollbarIsAlwaysShownOnMobile;
//   final double scrollbarRadius;
//   final bool returnSingleChildScrollView;
//   final ScrollPhysics scrollPhysicsMobile;
//   final bool sameScrollPhysicsOnWeb;
//   final EdgeInsetsGeometry padding;

//   const OwScaffold({
//     Key key, 
//     this.onWillPop,
//     this.appBar,
//     this.body,
//     this.bottomNavigationBar,
//     this.drawer,
//     this.floatingActionButton,
//     this.floatingActionButtonAnimator,
//     this.floatingActionButtonLocation,
//     this.showScrollbar,
//     this.scrollController,
//     this.scrollbarThicknessWeb = 20,
//     this.scrollbarThicknessMobile = 10,
//     this.scrollbarRadius = 5,
//     this.scrollbarIsAlwaysShownOnWeb = true,
//     this.scrollbarIsAlwaysShownOnMobile = false,
//     this.returnSingleChildScrollView = true,
//     this.scrollPhysicsMobile = const BouncingScrollPhysics(),
//     this.sameScrollPhysicsOnWeb = true,
//     this.padding,
//   })  : super(key: key);

  
//   @override
//   _OwScaffoldState createState() => _OwScaffoldState();
// }

// class _OwScaffoldState extends State<OwScaffold> {
//   bool _showScrollbar;

//   @override
//   Widget build(BuildContext context) {
//     _showScrollbar = widget.showScrollbar ?? isWebApplication;
//     return widget.onWillPop != null
//       ? WillPopScope(
//         key: widget.onWillPop != null
//           ? widget.key
//           : null,
//         onWillPop: widget.onWillPop,
//         child: _scaffold(),
//       )
//       : _scaffold();
//   }

//   Widget _scaffold() {
//     return Scaffold(
//       key: widget.onWillPop != null
//         ? widget.key
//         : null,
//       appBar: widget.appBar,
//       body: _showScrollbar
//         ? _scrollbar()
//         : _body(),
//       bottomNavigationBar: widget.bottomNavigationBar,
//       drawer: widget.drawer,
//       floatingActionButton: widget.floatingActionButton,
//       floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
//       floatingActionButtonLocation: widget.floatingActionButtonLocation,
//     );
//   }

//   Widget _scrollbar() {
//     return Scrollbar(
//       controller: widget.scrollController,
//       child: _body(),
//       thickness: isWebApplication
//         ? widget.scrollbarThicknessWeb
//         : widget.scrollbarThicknessMobile,
//       isAlwaysShown: isWebApplication
//         ? widget.scrollbarIsAlwaysShownOnWeb
//         : widget.scrollbarIsAlwaysShownOnMobile,
//       radius: Radius.circular(widget.scrollbarRadius),
//     );
//   }

//   Widget _body() {
//     return widget.returnSingleChildScrollView
//       ? SingleChildScrollView(
//         padding: widget.padding,
//         controller: widget.scrollController,
//         child: widget.body,
//         physics: isWebApplication
//           ? widget.sameScrollPhysicsOnWeb
//             ? widget.scrollPhysicsMobile
//             : null
//           : widget.scrollPhysicsMobile,
//       )
//       : Container(
//         padding: widget.padding,
//         child: widget.body,
//       );
//   }
// }
