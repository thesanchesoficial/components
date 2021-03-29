import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OwPageView extends StatelessWidget {
  final bool loop;
  final double height;
  final bool pageSnapping; // Allows to scroll to the center of the widget
  final PageController controller;
  final List<Widget> children;
  final ScrollPhysics physics;
  final bool reverse;

  const OwPageView({
    Key key,
    this.loop,
    this.height,
    this.pageSnapping = true,
    this.controller,
    @required this.children,
    this.reverse = false,
    this.physics = const BouncingScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = _centeredWidgets();
    return Container(
      height: height,
      child: Stack(
        children: [
          PageView(
            key: key,
            reverse: reverse,
            controller: controller,
            children: _children,
            physics: physics,
            dragStartBehavior: DragStartBehavior.down,
            pageSnapping: pageSnapping,
            allowImplicitScrolling: true,
          ),
          // PageView.builder(
          //   key: key,
          //   itemBuilder: (context, index) {
          //     bool active = index == currentPage;
          //     return _children[index];
          //   },
          //   itemCount: _children.length,
          //   reverse: reverse,
          //   controller: controller,
          //   children: _children,
          //   physics: physics,
          //   dragStartBehavior: DragStartBehavior.down,
          //   pageSnapping: pageSnapping,
          //   allowImplicitScrolling: true,
          // ),
        ],
      ),
    );
  }

  List<Widget> _centeredWidgets() {
    List<Widget> _children = [];
    children?.forEach((element) {
      _children.add(Center(child: element));
    });
    return _children;
  }


  // Widget frontPage({image, title, isActive}) {
  //   double paddingTop = isActive ? 100 : 150;
  //   double blur = isActive ? 30 : 0;
  //   double offset = isActive ? 20 : 0;
  //   return AnimatedPadding(
  //     duration: Duration(milliseconds: 400),
  //     padding: EdgeInsets.only(top: paddingTop, right: 30),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         Expanded(
  //           flex: 2,
  //           child: AnimatedContainer(
  //             duration: Duration(milliseconds: 400),
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                   image: AssetImage(image), fit: BoxFit.cover),
  //               borderRadius: BorderRadius.circular(30),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black87,
  //                   blurRadius: blur,
  //                   offset: Offset(offset, offset),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Padding(
  //             padding: EdgeInsets.only(top: 30),
  //             child: Column(
  //               children: <Widget>[
  //                 FadeAnimation(
  //                   delay: 1.5,
  //                   child: Text(
  //                     title,
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 25,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 FadeAnimation(
  //                   delay: 2,
  //                   child: Text(
  //                     "Action + Adventure",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 FadeAnimation(
  //                   delay: 2.5,
  //                   child: Text(
  //                     "4.0",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 10),
  //                 FadeAnimation(
  //                   delay: 3,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Icon(
  //                         Icons.star,
  //                         color: Colors.white,
  //                         size: 20,
  //                       ),
  //                       Icon(
  //                         Icons.star,
  //                         color: Colors.white,
  //                         size: 20,
  //                       ),
  //                       Icon(
  //                         Icons.star,
  //                         color: Colors.white,
  //                         size: 20,
  //                       ),
  //                       Icon(
  //                         Icons.star_border,
  //                         color: Colors.white,
  //                         size: 20,
  //                       ),
  //                       Icon(
  //                         Icons.star_border,
  //                         color: Colors.white,
  //                         size: 20,
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
