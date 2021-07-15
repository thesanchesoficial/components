import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ! Ver: https://pub.dev/packages/pull_to_refresh
/*
? Ver Slivers
https://stackoverflow.com/questions/50617231/flutter-sliverlist-sliverchildbuilderdelegate-supply-initial-index-or-allow
https://medium.com/flutter/slivers-demystified-6ff68ab0296f
https://fine2find.com/working-with-slivers-in-flutter/
*/

 // ? Na paginação, colocar uma página de erro (caso dê erro no primeiro retorno, e uma página de itens vazios (caso retorne vazio)); colocar página de loading inicial
 // ! pub.dev/packages/flutter_pagewise (Paginação com List, Grid, Sliver e SliverGrid)
 // * Ver também: https://pub.dev/packages/lazy_load_scrollview
/*
! Ver para Sliver Scrolls
CustomScrollView(
  slivers: [
    PagewiseSliverList(
      pageSize: 10, // for example,
      pageFuture: this._pageFuture, // some function that fetches the page
      itemBuilder: (context, entry, index) {
        return Column(
          children: [
            Text(entry['title']),
            ListView(
              primary: false,
              shrinkWrap: true,
              children: entry['ids'].map((id) => Text(id)).toList()
            )
          ]
        );
      }
    )
  ]
)
*/

class OwPagination extends StatefulWidget { // ! Falta a tela de loading inicial (não sei como fazer isso) (e também um scroll pra usar na web))
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
  final bool loadingAndTryWidgetsAboveBottomWidget;
  final bool useTryAgainWidget;
  final double loadMoreOffsetFromBottom;
  final Widget bottomWidget;
  final Widget sliverAppBar;
  final bool onlyUseButtonToLoadMore;
  final bool shrinkWrap;
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
    this.loadingAndTryWidgetsAboveBottomWidget = true,
    this.useTryAgainWidget = true,
    this.loadMoreOffsetFromBottom = 0,
    this.bottomWidget,
    this.sliverAppBar,
    this.onlyUseButtonToLoadMore = false,
    this.shrinkWrap = false,
    // this.width,
  }): assert(child != null),
      assert(onlyUseButtonToLoadMore ? useTryAgainWidget : true, "'useTryAgainWidget' needs to be true if you are using 'onlyUseButtonToLoadMore'"),
      assert(shrinkWrap ? controller != null : true, "If you are usig 'shrinkWrap' as true, you need to pass the 'controller'"), // ! Acho que além do controller não ser null, onRefresh não pode ser passado
      super(key: key);

  @override
  _OwPaginationState createState() => _OwPaginationState();
}

class _OwPaginationState extends State<OwPagination> {
  ScrollController _scrollController;
  bool _showLoading = false;
  bool _showTryAgain = false;
  void Function() updateState;

  @override
  void initState() { 
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    if(widget.onlyUseButtonToLoadMore) {
      _showTryAgain = true;
    } else {
      if(!_scrollController.hasListeners) {
        _scrollController?.addListener(_callFuncion);
      }
    }

    updateState = () => setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    if(widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async {
          await widget.onRefresh();
          if(!widget.onlyUseButtonToLoadMore) {
            _showTryAgain = false;
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              updateState();
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
        shrinkWrap: widget.shrinkWrap,
        slivers: [
          widget.sliverAppBar,
          SliverToBoxAdapter(
            child: _container(context),
          ),
        ],
      );
    } else {
      if(widget.shrinkWrap) {
        return _container(context);
      } else {
        return SingleChildScrollView(
          controller: _scrollController,
          physics: widget.physics,
          child: _container(context),
        );
      }
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
    List<Widget> _children = [];

    // if(widget.topWidget != null) {
    //   _children.add(widget.topWidget);
    // }

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
    if(
      !_showLoading &&
      widget.loadMore != null && 
      widget.callLoadMore
    ) {
      double maxScroll = _scrollController.position.maxScrollExtent - widget.loadMoreOffsetFromBottom;
      maxScroll = maxScroll < 0 ? 0 : maxScroll;
      
      if(
        (!_showTryAgain && _scrollController.offset >= maxScroll) || 
        (_showTryAgain && tryAgainCall)
      ) {
        _showLoading = true;
        _showTryAgain = false;
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          updateState();
        });
        if(!widget.useStackLoading && !tryAgainCall && widget.loadMoreOffsetFromBottom == 0) {
          // await Future.delayed(const Duration(milliseconds: 100));
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            _scrollController.animateTo(maxScroll + 70, duration: const Duration(milliseconds: 200), curve: Curves.easeInSine);
          });
        }
        var result = await widget.loadMore();
        _showLoading = false;
        if(widget.useTryAgainWidget) {
          if(widget.onlyUseButtonToLoadMore) {
            _showTryAgain = true;
          } else {
            _showTryAgain = result == false;
          }
        }
      }
    }
  }
}