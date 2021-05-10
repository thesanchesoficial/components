import 'package:flutter/material.dart';

import '../widgets/w_progress_bar.dart';
import '../widgets/w_scrollbar.dart';

class OwBoxHorizontalScroll extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  final double spacing;
  final ScrollPhysics physics;
  final ScrollController controller;
  // final double height;
  // final bool progressBar;
  // final double progressBarHeight;
  // final double progressBarDistance;
  final double scrollBarThickness;
  final bool useScrollbar;
  final bool scrollbarAlwaysShown;
  final double scrollbarRadius;

  const OwBoxHorizontalScroll({
    Key key,
    this.controller,
    this.children,
    this.padding,
    this.spacing = 10,
    this.physics = const BouncingScrollPhysics(),
    // this.height,
    // this.progressBar = false,
    // this.progressBarHeight = 10,
    // this.progressBarDistance = 10,
    this.scrollBarThickness = 10,
    this.useScrollbar = false,
    this.scrollbarAlwaysShown = true,
    this.scrollbarRadius = 5,
  }): // assert(progressBar ? controller != null : true, "Needs a 'controller' to have a progress bar."),
      super(key: key);

  @override
  _OwBoxHorizontalScrollState createState() => _OwBoxHorizontalScrollState();
}

class _OwBoxHorizontalScrollState extends State<OwBoxHorizontalScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: widget.useScrollbar
        ? Scrollbar(
          controller: widget.controller,
          isAlwaysShown: widget.scrollbarAlwaysShown,
          thickness: widget.scrollBarThickness,
          radius: Radius.circular(widget.scrollbarRadius),
          child: Padding(
            padding: EdgeInsets.only(bottom: widget.scrollBarThickness + 2),
            child: _horizontalScroll(),
          ),
        )
        : _horizontalScroll(),
    );
  }

  Widget _horizontalScroll() {
    return SingleChildScrollView(
      controller: widget.controller,
      scrollDirection: Axis.horizontal,
      physics: widget.physics,
      child: Row(
        children: _children(),
      ),
    );
  }

  Widget _progressBar(BuildContext context, ScrollController controller) {
    double _horizontalPadding = widget.padding?.horizontal ?? 0;
    double _totalWidth = MediaQuery.of(context).size.width - _horizontalPadding;
    
    double _progression = widget.controller.hasClients ? controller.offset / _totalWidth : 0;
    // double _progress = _totalWidth * (_progression);
    double _progress = 0;

    double _fillPercent = 0;

    widget.controller.addListener(() {
      print("setState: ${widget.controller.offset}");
      
      // _progress = _totalWidth * (widget.controller.offset / _totalWidth);
      _fillPercent = widget.controller.offset / widget.controller.position.maxScrollExtent;
      // _progress = widget.controller.offset;
      // _fillPercent = _progress / _totalWidth;
      if(_fillPercent < 0) {
        _fillPercent = 0;
      } else if (_fillPercent > 1) {
        _fillPercent = 1;
      }
      // setState(() {});
      print("_progress: $_progress");
      print("_fillPercent: $_fillPercent");
    });
    
    return Padding(
      // padding: EdgeInsets.only(top: widget.progressBarDistance),
      // child: ClipRRect(
      //   child: Container(
      //     height: widget.progressBarHeight,
      //     width: MediaQuery.of(context).size.width,
      //     color: Colors.redAccent,
      //     child: Align(
      //       alignment: Alignment.centerLeft,
      //       child: Container(
      //         height: widget.progressBarHeight,
      //         width: _progress,
      //         color: Colors.blue,
      //       ),
      //     ),
      //   ),
      // ),
      child: OwProgressBar(
        animated: false,
        fillPercent: _fillPercent,
      ),
    );
  }

  List<Widget> _children() {
    List<Widget> result = [];
    widget.children?.forEach((element) {
      if(result.isNotEmpty && widget.spacing != null) {
        result.add(SizedBox(
          width: widget.spacing,
        ));
      }
      result.add(element);
    });
    return result;
  }
}
