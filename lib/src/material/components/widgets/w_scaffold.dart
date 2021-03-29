import 'package:flutter/material.dart';

class OwScaffold extends StatefulWidget {
  final Future<bool> Function() onWillPop;
  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget drawer;
  final Widget floatingActionButton;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final FloatingActionButtonLocation floatingActionButtonLocation;

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
  })  : super(key: key);

  
  @override
  _OwScaffoldState createState() => _OwScaffoldState();
}

class _OwScaffoldState extends State<OwScaffold> {
  @override
  Widget build(BuildContext context) {
    return widget.onWillPop != null
      ? WillPopScope(
        onWillPop: widget.onWillPop,
        child: _scaffold(),
      )
      : _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      key: widget.key,
      appBar: widget.appBar,
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}