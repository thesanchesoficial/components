// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:page_view_indicators/page_view_indicators.dart';

// // https://pub.dev/packages/page_view_indicators & https://pub.dev/packages/loop_page_view/example (see also https://pub.dev/packages/expandable_page_view)
// class OwPageView extends StatelessWidget {
//   final bool loop;
//   final double height;
//   final bool pageSnapping; // Allows to scroll to the center of the widget
//   final PageController controller;
//   final List<Widget> children;
//   final ScrollPhysics physics;
//   final bool reverse;

//   // const OwPageView({
//   OwPageView({
//     Key key,
//     this.loop,
//     this.height = 300,
//     this.pageSnapping = true,
//     this.controller,
//     @required this.children,
//     this.reverse = false,
//     this.physics = const BouncingScrollPhysics(),
//   }) : super(key: key);

//   final _currentPageNotifier = ValueNotifier<int>(0);

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> _children = _centeredWidgets();
//     return Container(
//       height: height,
//       child: Column(
//         children: [
//           PageView.builder(
//             key: key,
//             reverse: reverse,
//             controller: controller,
//             physics: physics,
//             dragStartBehavior: DragStartBehavior.down,
//             pageSnapping: pageSnapping,
//             allowImplicitScrolling: true,
//             itemCount: _children.length,
//             itemBuilder: (context, index) {
//               return Center(
//                 child: _children[index],
//               );
//             },
//             onPageChanged: (int index) {
//               _currentPageNotifier.value = index;
//             },
//           ),
//           // CirclePageIndicator(
//           //   size: 16.0,
//           //   selectedSize: 18.0,
//           //   itemCount: children.length,
//           //   currentPageNotifier: _currentPageNotifier,
//           // ),

//           // PageView.builder(
//           //   key: key,
//           //   itemBuilder: (context, index) {
//           //     bool active = index == currentPage;
//           //     return _children[index];
//           //   },
//           //   itemCount: _children.length,
//           //   reverse: reverse,
//           //   controller: controller,
//           //   children: _children,
//           //   physics: physics,
//           //   dragStartBehavior: DragStartBehavior.down,
//           //   pageSnapping: pageSnapping,
//           //   allowImplicitScrolling: true,
//           // ),
//         ],
//       ),
//     );
//   }

//   List<Widget> _centeredWidgets() {
//     List<Widget> _children = [];
//     children?.forEach((element) {
//       _children.add(Center(child: element));
//     });
//     return _children;
//   }


//   // Widget frontPage({image, title, isActive}) {
//   //   double paddingTop = isActive ? 100 : 150;
//   //   double blur = isActive ? 30 : 0;
//   //   double offset = isActive ? 20 : 0;
//   //   return AnimatedPadding(
//   //     duration: Duration(milliseconds: 400),
//   //     padding: EdgeInsets.only(top: paddingTop, right: 30),
//   //     child: Column(
//   //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //       children: <Widget>[
//   //         Expanded(
//   //           flex: 2,
//   //           child: AnimatedContainer(
//   //             duration: Duration(milliseconds: 400),
//   //             decoration: BoxDecoration(
//   //               image: DecorationImage(
//   //                   image: AssetImage(image), fit: BoxFit.cover),
//   //               borderRadius: BorderRadius.circular(30),
//   //               boxShadow: [
//   //                 BoxShadow(
//   //                   color: Colors.black87,
//   //                   blurRadius: blur,
//   //                   offset: Offset(offset, offset),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //         Expanded(
//   //           flex: 1,
//   //           child: Padding(
//   //             padding: EdgeInsets.only(top: 30),
//   //             child: Column(
//   //               children: <Widget>[
//   //                 FadeAnimation(
//   //                   delay: 1.5,
//   //                   child: Text(
//   //                     title,
//   //                     style: TextStyle(
//   //                       color: Colors.white,
//   //                       fontSize: 25,
//   //                       fontWeight: FontWeight.bold,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 FadeAnimation(
//   //                   delay: 2,
//   //                   child: Text(
//   //                     "Action + Adventure",
//   //                     style: TextStyle(
//   //                       color: Colors.white,
//   //                       fontSize: 16,
//   //                       fontWeight: FontWeight.w400,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 FadeAnimation(
//   //                   delay: 2.5,
//   //                   child: Text(
//   //                     "4.0",
//   //                     style: TextStyle(
//   //                       color: Colors.white,
//   //                       fontSize: 20,
//   //                       fontWeight: FontWeight.w500,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 10),
//   //                 FadeAnimation(
//   //                   delay: 3,
//   //                   child: Row(
//   //                     mainAxisAlignment: MainAxisAlignment.center,
//   //                     children: <Widget>[
//   //                       Icon(
//   //                         Icons.star,
//   //                         color: Colors.white,
//   //                         size: 20,
//   //                       ),
//   //                       Icon(
//   //                         Icons.star,
//   //                         color: Colors.white,
//   //                         size: 20,
//   //                       ),
//   //                       Icon(
//   //                         Icons.star,
//   //                         color: Colors.white,
//   //                         size: 20,
//   //                       ),
//   //                       Icon(
//   //                         Icons.star_border,
//   //                         color: Colors.white,
//   //                         size: 20,
//   //                       ),
//   //                       Icon(
//   //                         Icons.star_border,
//   //                         color: Colors.white,
//   //                         size: 20,
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 )
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

enum PageIndicator {
  none,
  top,
  bottom,
  stackTop,
  stackBottom,
}

enum IndicatorDotTouch {
  none,
  goToPage,
  goToOnlyCheckedPage,
}

// ! Deixar passar um filho pro pageIndicator (como por exemplo, exibir as miniaturas das imagens)
// ! Criar um Builder
// ! Colocar opção pra desabilitar rolagem (quando dá zoom em uma imagem e arrasta pro lado (no zoom), vai pra próxima imagem)
// ! Adicionar (tela inicial venver): 

// Maybe add this too: https://pub.dev/packages/expandable_page_view
class OwPageView extends StatefulWidget {
  final double height;
  final bool pageSnapping; // It scrolls automatically to the center of the widget
  final PageController controller;
  final List<Widget> children;
  final ScrollPhysics physics;
  final bool reverse;
  final PageIndicator pageIndicator;
  final EdgeInsetsGeometry padding;
  final double indicatorWidgetSpacing;
  final Gradient stackGradient;
  final bool centeredChildren;

  final LoopPageController loopController;
  final bool loop;

  /// Define the action while touch the step dot (if not 'none', needs a controller)
  final IndicatorDotTouch stepPageDotTouch;
  final bool stepPageIndicator;
  final double dotSize;
  final double selectedDotSize;
  final Color dotBorderColor;
  final double dotBorderWidth;
  final double dotSpacing;
  final Color selectedDotBorderColor;
  final Color selectedDotColor;
  final Color dotColor;
  final ValueChanged<int> onDotIndicatorSelected;
  final Widget previousStep;
  final Widget selectedStep;
  final Widget nextStep;

  const OwPageView({
    Key key,
    @required this.children,
    @required this.height,
    this.loop = false,
    this.pageSnapping = true,
    this.controller,
    this.loopController,
    this.reverse = false,
    this.physics = const BouncingScrollPhysics(),
    this.pageIndicator = PageIndicator.stackBottom,
    this.padding,
    this.dotSize = 16,
    this.selectedDotSize = 18,
    this.dotBorderColor,
    this.dotBorderWidth = 0,
    this.dotSpacing = 8,
    this.selectedDotBorderColor,
    this.selectedDotColor,
    this.dotColor,
    this.indicatorWidgetSpacing = 10,
    this.stackGradient,
    this.centeredChildren = true,
    this.stepPageDotTouch = IndicatorDotTouch.goToOnlyCheckedPage,
    this.stepPageIndicator = false,
    this.previousStep,
    this.selectedStep,
    this.nextStep,
    this.onDotIndicatorSelected,
  })  : assert(!loop || !stepPageIndicator),
        super(key: key);

  @override
  _OwPageViewState createState() => _OwPageViewState();
}

class _OwPageViewState extends State<OwPageView> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      padding: widget.padding,
      height: widget.height,
      child: _containerChild(),
    );
  }

  Widget _containerChild() {  
    if(widget.pageIndicator == PageIndicator.none) {
      return _pageView();
    } else if(
      widget.pageIndicator == PageIndicator.stackBottom ||
      widget.pageIndicator == PageIndicator.stackTop
    ) {
      return Stack(
        children: [
          _pageView(),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.stackGradient,
              ),
            ),
          ),
          Align(
            alignment: widget.pageIndicator == PageIndicator.stackBottom
              ? Alignment.bottomCenter
              : Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.indicatorWidgetSpacing,
              ),
              child: _pageIndicator(),
            ),
          ),
        ],
      );
    } else {
      Widget _spaceBetween = SizedBox(height: widget.indicatorWidgetSpacing);
      // List<Widget> _columnChildren = [
      //   Expanded(child: _pageView()),
      //   _spaceBetween,
      //   _pageIndicator(),
      // ];
      return Column(
        children: widget.pageIndicator == PageIndicator.top
          ? [
            _pageIndicator(),
            _spaceBetween,
            Expanded(child: _pageView()),
          ]
          : [
            Expanded(child: _pageView()),
            _spaceBetween,
            _pageIndicator(),
          ],
      );
    }
  }

  Widget _pageView() {
    List<Widget> _children = widget.centeredChildren
      ? _centeredWidgets()
      : widget.children;
    
    return Container(
      child: widget.loop
        ? LoopPageView.builder(
          reverse: widget.reverse,
          controller: widget.loopController,
          physics: widget.physics,
          dragStartBehavior: DragStartBehavior.down,
          pageSnapping: widget.pageSnapping,
          allowImplicitScrolling: true,
          itemCount: _children.length,
          itemBuilder: (context, index) {
            return _children[index];
          },
          onPageChanged: (index) {
            _currentPageNotifier.value = index;
          },
        )
        : PageView.builder(
          controller: widget.controller,
          reverse: widget.reverse,
          physics: widget.physics,
          dragStartBehavior: DragStartBehavior.down,
          pageSnapping: widget.pageSnapping,
          allowImplicitScrolling: true,
          itemCount: _children.length,
          itemBuilder: (context, index) {
            return _children[index];
          },
          onPageChanged: (index) {
            _currentPageNotifier.value = index;
          },
        ),
    );
  }

  Widget _pageIndicator() {
    Duration _jumpDuration = Duration(milliseconds: 500);
    Curve _jumpCurve = Curves.easeInOut;

    return widget.stepPageIndicator
      ? StepPageIndicator(
        itemCount: widget.children.length,
        currentPageNotifier: _currentPageNotifier,
        size: widget.dotSize,
        stepColor: widget.dotColor,
        previousStep: null,
        selectedStep: null,
        nextStep: null,
        stepSpacing: widget.dotSpacing,
        onPageSelected: (index) {
          if(widget.onDotIndicatorSelected != null) {
            widget.onDotIndicatorSelected(index);
          }
          
          if(widget.stepPageDotTouch != IndicatorDotTouch.none) {
            bool _goToPage = false;
            if(widget.stepPageDotTouch == IndicatorDotTouch.goToOnlyCheckedPage) {
              _goToPage = true;
            } else if(_currentPageNotifier.value > index) {
              _goToPage = true;
            }

            if(_goToPage) {
              widget.controller?.animateToPage(
                index,
                duration: _jumpDuration,
                curve: _jumpCurve,
              );
              widget.loopController?.animateToPage(
                index,
                duration: _jumpDuration,
                curve: _jumpCurve,
              );
            }
          }
        },
      )
      : CirclePageIndicator(
        itemCount: widget.children.length,
        currentPageNotifier: _currentPageNotifier,
        size: widget.dotSize,
        selectedSize: widget.selectedDotSize,
        borderColor: widget.dotBorderColor,
        borderWidth: widget.dotBorderWidth,
        dotSpacing: widget.dotSpacing,
        dotColor: widget.dotColor,
        selectedBorderColor: widget.selectedDotBorderColor,
        selectedDotColor: widget.selectedDotColor,
        onPageSelected: (index) {
          if(widget.onDotIndicatorSelected != null) {
            widget.onDotIndicatorSelected(index);
          }
          
          if(
            widget.stepPageDotTouch == IndicatorDotTouch.goToOnlyCheckedPage ||
            widget.stepPageDotTouch == IndicatorDotTouch.goToPage
          ) {
            widget.controller?.animateToPage(
              index,
              duration: _jumpDuration,
              curve: _jumpCurve,
            );
            widget.loopController?.animateToPage(
              index,
              duration: _jumpDuration,
              curve: _jumpCurve,
            );
          }
        },
      );
  }

  List<Widget> _centeredWidgets() {
    List<Widget> _children = [];
    widget.children?.forEach((element) {
      _children.add(Center(child: element));
    });
    return _children;
  }
}



