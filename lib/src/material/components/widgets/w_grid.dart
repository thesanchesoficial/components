import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ? Ver: https://pub.dev/packages/flutter_layout_grid
/*
? Ver Slivers
https://stackoverflow.com/questions/50617231/flutter-sliverlist-sliverchildbuilderdelegate-supply-initial-index-or-allow
https://medium.com/flutter/slivers-demystified-6ff68ab0296f
https://fine2find.com/working-with-slivers-in-flutter/
*/

class OwGrid extends StatefulWidget { // * class OwGrid<T> extends StatelessWidget { // final List<T> typedList;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final double rowHeight;
  final double spacing;
  final double runSpacing;
  final int horizontalQuantity;
  final List<double> numbersInRowAccordingToWidgth;
  final bool centeredChildren;
  final int maxNumberOfRows;
  final List<int> flexColumns;
  final List<double> widthColumns;
  final List<double> heightRows;
  final BoxConstraints constraints;
  final List<List<int>> layout;
  final bool fillLastRow;
  final bool expandLastColumn;
  final Widget topWidget;
  final Widget bottomWidget;
  final Widget horizontalSeparatorWidget;
  final Widget verticalSeparatorWidget;

  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;

  final ScrollController controller;
  final int maxLength;
  final Widget loadingWidget;
  final Future<bool> Function() loadMore;
  final bool useStackLoading;
  final ScrollPhysics physics;
  final Widget tryAgainWidget;
  final bool usePagination;
  final bool loadingAndTryWidgetsAboveBottomWidget;
  final bool useTryAgainWidget;
  final double pixelsLengthBeforeCallLoadMore;
  // ? Talvez colocar um axis direction
  
  OwGrid({
    Key key,
    this.children,
    this.padding,
    this.constraints,
    this.rowHeight,
    this.spacing = 10,
    this.runSpacing = 10,
    this.horizontalQuantity,
    this.numbersInRowAccordingToWidgth,
    this.centeredChildren = false,
    this.maxNumberOfRows,
    this.flexColumns,
    this.widthColumns, // * Verificar o que fazer quando colocar um némero maior que o de numbersInRowAccordingToWidgth
    this.heightRows,
    this.layout,
    this.fillLastRow = false,
    this.expandLastColumn = true,
    this.bottomWidget,
    this.topWidget,
    this.horizontalSeparatorWidget,
    this.verticalSeparatorWidget,
  }) :this.controller = null,
      this.maxLength = null,
      this.loadingWidget = null,
      this.loadMore = null,
      this.useStackLoading = null,
      this.physics = null,
      this.tryAgainWidget = null,
      this.useTryAgainWidget = null,
      this.itemBuilder = null,
      this.itemCount = null,
      this.usePagination = false,
      this.loadingAndTryWidgetsAboveBottomWidget = null,
      this.pixelsLengthBeforeCallLoadMore = null,
      super(key: key);

  OwGrid.builder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.padding,
    this.constraints,
    this.rowHeight,
    this.spacing = 10,
    this.runSpacing = 10,
    this.horizontalQuantity,
    this.numbersInRowAccordingToWidgth,
    this.centeredChildren = false,
    this.maxNumberOfRows,
    this.flexColumns,
    this.widthColumns, // * Verificar o que fazer quando colocar um némero maior que o de numbersInRowAccordingToWidgth
    this.heightRows,
    this.layout,
    this.fillLastRow = false,
    this.expandLastColumn = true,
    this.bottomWidget,
    this.topWidget,
    this.horizontalSeparatorWidget,
    this.verticalSeparatorWidget,
  }) :this.children = null,
      this.controller = null,
      this.maxLength = null,
      this.loadingWidget = null,
      this.loadMore = null,
      this.useStackLoading = null,
      this.physics = null,
      this.tryAgainWidget = null,
      this.useTryAgainWidget = null,
      this.usePagination = false,
      this.loadingAndTryWidgetsAboveBottomWidget = null,
      this.pixelsLengthBeforeCallLoadMore = null,
      super(key: key);

  OwGrid.pagination({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.loadMore,
    this.controller,
    this.maxLength,
    this.loadingWidget,
    this.physics = const BouncingScrollPhysics(),
    this.useStackLoading = false,
    this.tryAgainWidget,
    this.useTryAgainWidget = true,
    this.padding,
    this.constraints,
    this.rowHeight,
    this.spacing = 10,
    this.runSpacing = 10,
    this.horizontalQuantity,
    this.numbersInRowAccordingToWidgth,
    this.centeredChildren = false,
    this.maxNumberOfRows,
    this.flexColumns,
    this.widthColumns, // * Verificar o que fazer quando colocar um némero maior que o de numbersInRowAccordingToWidgth
    this.heightRows,
    this.layout,
    this.fillLastRow = false,
    this.expandLastColumn = true,
    this.bottomWidget,
    this.topWidget,
    this.loadingAndTryWidgetsAboveBottomWidget = true,
    this.pixelsLengthBeforeCallLoadMore = 0,
    this.horizontalSeparatorWidget,
    this.verticalSeparatorWidget,
  }) :this.children = null,
      this.usePagination = true,
      super(key: key);

  @override
  _OwGridState createState() => _OwGridState();
}

class _OwGridState extends State<OwGrid> {
  List<Widget> _children;
  bool _showLoading = false;
  bool _showTryAgain = false;
  ScrollController _scrollController;

  @override
  void initState() { 
    super.initState();
    // assert((flexColumns != null && flexColumns.length >= numbersInRowAccordingToWidgth.length) || flexColumns == null);
    _scrollController = widget.controller ?? ScrollController();
    _scrollController?.addListener(_callFuncion);
  }

  @override
  Widget build(BuildContext context) {
    _children = _defineChildren(context);

    if(!widget.usePagination) {
      return _container(context);
    } else {
      return SingleChildScrollView(
        controller: _scrollController,
        physics: widget.physics,
        child: _container(context),
      );
    }
  }

  Widget _container(BuildContext context) {
    List<Widget> _columnWidgets;
    if(widget.useStackLoading != null) {
      if(widget.useStackLoading) {
        _columnWidgets = widget.loadingAndTryWidgetsAboveBottomWidget == true
          ? [
            widget.topWidget ?? const SizedBox(),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _gridView(context),
                _loadingWidget(),
              ],
            ),
            _tryAgainWidget(),
            widget.bottomWidget ?? const SizedBox(),
          ]
          : [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _gridView(context, true),
                _loadingWidget(),
              ],
            ),
            _tryAgainWidget(),
          ];
      } else {
        _columnWidgets = widget.loadingAndTryWidgetsAboveBottomWidget == true
          ? [
            widget.topWidget ?? const SizedBox(),
            _gridView(context),
            _loadingWidget(),
            _tryAgainWidget(),
            widget.bottomWidget ?? const SizedBox(),
          ]
          : [
            widget.topWidget ?? const SizedBox(),
            _gridView(context),
            widget.bottomWidget ?? const SizedBox(),
            _loadingWidget(),
            _tryAgainWidget(),
          ];
      }
    }

    return Container(
      alignment: Alignment.topLeft,
      padding: widget.padding,
      constraints: widget.constraints,
      width: MediaQuery.of(context).size.width,
      child: !widget.usePagination
        ? _gridView(context)
        : Column(
          children: _columnWidgets,
        ),
    );
  }

  Widget _gridView(BuildContext context, [bool addTopAndBottomWidget = false]) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      key: widget.key,
      // children: _columnChildren(context), // * Para voltar pro antigo, é só decomentar essa linha e as funções comentadas abaixo
      children: _columnWidgets(context, addTopAndBottomWidget),
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

  List<Widget> _defineChildren(BuildContext context) {
    return widget.children ?? List.generate(
      widget.maxLength == null || widget.itemCount < widget.maxLength 
        ? widget.itemCount 
        : widget.maxLength, 
      (index) => widget.itemBuilder(context, index),
    ).toList();
  }

  List<Widget> _columnWidgets(BuildContext context, [bool addTopAndBottomWidget = false]) {
    double _totalWidth = MediaQuery.of(context).size.width; // LayoutBuilder
    int _case = 0;
    if(widget.numbersInRowAccordingToWidgth != null) {
      int i = 0;
      for(; i < widget.numbersInRowAccordingToWidgth.length; i++) {
        if(_totalWidth <= widget.numbersInRowAccordingToWidgth[i]) {
          break;
        }
      }
      _case = i;
    }
    // print("_case: $_case");

    List<int> _alignment;
    if(widget.layout != null && widget.layout.length > _case) {
      _alignment = widget.layout[_case];
    }

    List<Widget> _rowWidgets(int index, int rowIndex) {
      int _quantityInRow;
      if(_alignment != null && _alignment.length > rowIndex) {
        _quantityInRow = _alignment[rowIndex];
      }
      _quantityInRow = _quantityInRow ?? widget.horizontalQuantity ?? _case + 1;
      if(widget.fillLastRow && _quantityInRow > _children.length - index) {
        _quantityInRow = _children.length - index;
      }

      double _rowHeight;
      if(widget.heightRows != null && widget.heightRows.length > rowIndex) {
        _rowHeight = widget.heightRows[rowIndex];
      }
      _rowHeight = _rowHeight ?? widget.rowHeight;

      bool _hasFlex = false;
      if(_quantityInRow > 1) {
        for(int i = 0; i < _quantityInRow; i++) {
          int childIndex = index + i;
          if(_children.length > childIndex) {
            if(widget.widthColumns == null || widget.widthColumns.length <= i || widget.widthColumns[i] == null) {
              _hasFlex = true;
            }
          }
        }
      }

      List<Widget> _widgetsInRow = [];
      int column = 0;
      for(int i = index; column < _quantityInRow; i++) {
        if(widget.fillLastRow && i >= _children.length) {
          break;
        }

        Widget child;
        if(i >= _children.length) {
          child = null;
        } else {
          child = _children[i];
        }

        if(_widgetsInRow.isNotEmpty) {
          _widgetsInRow.add(
            SizedBox(
              width: widget.spacing,
              height: _rowHeight, // + widget.runSpacing to use a divider (needs Stack)
              child: widget.horizontalSeparatorWidget,
            ),
          );
        }

        double _widthChild;
        if(
          _hasFlex || 
          (!_hasFlex && column + 1 < _quantityInRow) || 
          (!widget.expandLastColumn && column + 1 == _quantityInRow)
        ) {
          if(widget.widthColumns != null && widget.widthColumns.length > column && widget.widthColumns[column] != null) {
            _widthChild = widget.widthColumns[column];
          }
        }

        int _flex;
        if(_widthChild == null) {
          if(widget.flexColumns != null && widget.flexColumns.length > column) {
            _flex = widget.flexColumns[column];
          }
          _flex = _flex ?? 1;
        }

        if(_flex != null) {
          child = Expanded(
            flex: _flex,
            child: Container(
              height: _rowHeight,
              child: child,
            ),
          );
        } else {
          child = Container(
            width: _widthChild,
            height: _rowHeight,
            child: child,
          );
        }

        _widgetsInRow.add(child);
        column++;
      }

      return _widgetsInRow;
    }

    List<Widget> _columnChildren = [];

    int _rowIndex = 0;
    for(int i = 0; i < _children.length && (widget.maxNumberOfRows == null || _rowIndex < widget.maxNumberOfRows);) {
      if(_columnChildren.isNotEmpty) {
        _columnChildren.add(
          SizedBox(
            height: widget.runSpacing,
            child: widget.verticalSeparatorWidget,
          ),
        );
      }
      
      if(_columnChildren.isEmpty && addTopAndBottomWidget && widget.topWidget != null) {
        _columnChildren.add(widget.topWidget);
      }

      List<Widget> _rowChildren = _rowWidgets(i, _rowIndex);
      _columnChildren.add(
        Row(children: _rowChildren),
      );

      i += (_rowChildren.length / 2).ceil();
      _rowIndex++;
    }

    if(addTopAndBottomWidget && widget.bottomWidget != null) {
      _columnChildren.add(widget.bottomWidget);
    }

    return _columnChildren;
  }

  void _callFuncion([bool tryAgainCall = false]) async {
    double maxScroll = _scrollController.position.maxScrollExtent - widget.pixelsLengthBeforeCallLoadMore;
    maxScroll = maxScroll < 0 ? 0 : maxScroll;
    if(
      widget.loadMore != null && 
      ((!_showTryAgain && _scrollController.offset >= maxScroll) || (_showTryAgain && tryAgainCall)) &&
      (widget.maxLength == null || widget.itemCount < widget.maxLength) &&
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
