import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class OwPagination extends StatefulWidget { // ! Falta a tela de loading inicial (não sei como fazer isso) (acho que é um bool pra só usar o try again) (e também um scroll pra usar na web))
  final Widget child;
  final EdgeInsetsGeometry childPadding;
  final BoxConstraints constraints;
  final ScrollController controller;
  final bool callLoadMore;
  final Widget loadingWidget;
  final Future<bool> Function() loadMore;
  final Future<void> Function() onRefresh;
  final bool useStackLoading;
  final ScrollPhysics physics;
  final Widget tryAgainWidget;
  final bool usePagination;
  final bool loadingAndTryWidgetsAboveBottomWidget;
  final bool useTryAgainWidget;
  final double loadMoreOffsetFromBottom;
  final Widget topWidget;
  final Widget bottomWidget;
  final Widget sliverAppBar;
  final bool onlyUseTryAgainToLoadMore;
  // final double width;

  const OwPagination({
    Key key,
    @required this.child,
    @required this.loadMore,
    this.onRefresh,
    this.childPadding,
    this.constraints,
    this.controller,
    this.callLoadMore = true,
    this.loadingWidget,
    this.useStackLoading = false,
    this.physics = const BouncingScrollPhysics(parent: const AlwaysScrollableScrollPhysics()),
    this.tryAgainWidget,
    this.usePagination,
    this.loadingAndTryWidgetsAboveBottomWidget = true,
    this.useTryAgainWidget = true,
    this.loadMoreOffsetFromBottom = 0,
    this.topWidget,
    this.bottomWidget,
    this.sliverAppBar,
    this.onlyUseTryAgainToLoadMore = false,
    // this.width,
  }): assert(child != null),
      assert(onlyUseTryAgainToLoadMore ? useTryAgainWidget : true, "'useTryAgainWidget' needs to be true if you are using 'onlyUseTryAgainToLoadMore'"),
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
    if(widget.onlyUseTryAgainToLoadMore) {
      _showTryAgain = true;
    } else {
      _scrollController?.addListener(_callFuncion);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if(widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async {
          await widget.onRefresh();
          if(!widget.onlyUseTryAgainToLoadMore) {
            _showTryAgain = false;
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {});
            });
          }
        },
        child: _scroll(context),
      );
    } else {
      return _scroll(context);
    }
  }

  Widget _scroll(BuildContext context) {
    if(widget.sliverAppBar != null) {
      return CustomScrollView(
        controller: _scrollController,
        physics: widget.physics,
        slivers: [
          widget.sliverAppBar,
          SliverToBoxAdapter(
            child: _container(context),
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        controller: _scrollController,
        physics: widget.physics,
        child: _container(context),
      );
    }
  }

  Widget _container(BuildContext context) {
    List<Widget> _columnWidgets = [];

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
    
    return Container(
      // alignment: Alignment.topCenter,
      constraints: widget.constraints,
      // width: 50, // MediaQuery.of(context).size.width,
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
    List<Widget> _children = [
      widget.topWidget,
    ];

    if(widget.childPadding != null) {
      _children.add(Padding(
        padding: widget.childPadding,
        child: widget.child,
      ));
    } else {
      _children.add(widget.child);
    }

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
    double maxScroll = _scrollController.position.maxScrollExtent - widget.loadMoreOffsetFromBottom;
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
      if(!widget.useStackLoading && !tryAgainCall && widget.loadMoreOffsetFromBottom == 0) {
        // await Future.delayed(const Duration(milliseconds: 100));
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _scrollController.animateTo(maxScroll + 70, duration: const Duration(milliseconds: 200), curve: Curves.easeInSine);
        });
      }
      var result = await widget.loadMore();
      _showLoading = false;
      if(widget.useTryAgainWidget) {
        if(widget.onlyUseTryAgainToLoadMore) {
          _showTryAgain = true;
        } else {
          _showTryAgain = result == false;
        }
      }
    }
  }
}