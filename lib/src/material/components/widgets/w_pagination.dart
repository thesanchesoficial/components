import 'package:flutter/material.dart';

class OwPagination extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final BoxConstraints constraints;
  final ScrollController controller;
  final bool callLoadMore;
  final Widget loadingWidget;
  final Future<bool> Function() loadMore;
  final bool useStackLoading;
  final ScrollPhysics physics;
  final Widget tryAgainWidget;
  final bool usePagination;
  final bool loadingAndTryWidgetsAboveBottomWidget;
  final bool useTryAgainWidget;
  final double pixelsLengthBeforeCallLoadMore;
  final Widget bottomWidget;

  const OwPagination({
    Key key,
    @required this.children,
    this.padding,
    this.constraints,
    this.controller,
    this.callLoadMore = true,
    this.loadingWidget,
    this.loadMore,
    this.useStackLoading,
    this.physics,
    this.tryAgainWidget,
    this.usePagination,
    this.loadingAndTryWidgetsAboveBottomWidget = true,
    this.useTryAgainWidget,
    this.pixelsLengthBeforeCallLoadMore,
    this.bottomWidget,
  }): assert(children != null),
      super(key: key);

  @override
  _OwPaginationState createState() => _OwPaginationState();
}

class _OwPaginationState extends State<OwPagination> {
  ScrollController _scrollController;
  bool _showLoading = false;
  bool _showTryAgain = false;

  @override
  void initState() { 
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController?.addListener(_callFuncion);
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: widget.physics,
      child: _container(context),
    );
  }

  Widget _container(BuildContext context) {
    List<Widget> _columnWidgets;

    if(widget.useStackLoading != null) {
      if(widget.useStackLoading) {
        _columnWidgets = widget.loadingAndTryWidgetsAboveBottomWidget == true
          ? [
            Stack(
              alignment: Alignment.bottomCenter,
              children: _defineChildren(context, addBottomWidget: false, addTryAgainWidget: false),
            ),
            _tryAgainWidget(),
            widget.bottomWidget ?? const SizedBox(),
          ]
          : [
            Stack(
              alignment: Alignment.bottomCenter,
              children: _defineChildren(context, addTryAgainWidget: false),
            ),
            _tryAgainWidget(),
          ];
      } else {
        _columnWidgets = _defineChildren(context);
      }
    }
    
    return Container(
      alignment: Alignment.topLeft,
      padding: widget.padding,
      constraints: widget.constraints,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: _columnWidgets,
      ),
    );
  }

  Widget _loadingWidget() {
    return _showLoading
      ? widget.loadingWidget ?? Padding(
        padding: const EdgeInsets.all(8),
        child: const CircularProgressIndicator(),
      )
      : const SizedBox();
  }

  Widget _tryAgainWidget() {
    return _showTryAgain
      ? GestureDetector(
        child: widget.tryAgainWidget ?? Padding(
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.refresh_outlined, size: 32),
        ),
        onTap: () {
          _callFuncion(true);
        },
      )
      : const SizedBox();
  }

  List<Widget> _defineChildren(
    BuildContext context, 
    {bool addBottomWidget = true, 
    bool addTryAgainWidget = true,
  }) {
    List<Widget> _children = widget.children;
    if(widget.loadingAndTryWidgetsAboveBottomWidget) {
      _children.add(_loadingWidget());
      if(addTryAgainWidget) {
        _children.add(_tryAgainWidget());
      }
    }

    if(widget.bottomWidget != null && addBottomWidget) {
      _children.add(widget.bottomWidget);
    }

    if(!widget.loadingAndTryWidgetsAboveBottomWidget) {
      _children.add(_loadingWidget());
      if(addTryAgainWidget) {
        _children.add(_tryAgainWidget());
      }
    }

    return _children;
  }

  void _callFuncion([bool tryAgainCall = false]) async {
    double maxScroll = _scrollController.position.maxScrollExtent - widget.pixelsLengthBeforeCallLoadMore;
    maxScroll = maxScroll < 0 ? 0 : maxScroll;
    if(
      widget.loadMore != null && 
      ((!_showTryAgain && _scrollController.offset >= maxScroll) || (_showTryAgain && tryAgainCall)) &&
      widget.callLoadMore &&
      !_showLoading
    ) {
      _showLoading = true;
      _showTryAgain = false;
      setState(() {});
      if(!widget.useStackLoading && !tryAgainCall && widget.pixelsLengthBeforeCallLoadMore == 0) {
        // await Future.delayed(const Duration(milliseconds: 100));
        _scrollController.animateTo(maxScroll + 70, duration: const Duration(milliseconds: 200), curve: Curves.easeInSine);
      }
      var result = await widget.loadMore();
      _showLoading = false;
      if(widget.useTryAgainWidget) {
        _showTryAgain = result == false;
      }
    }
  }
}