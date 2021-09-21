import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ? Ver: https://pub.dev/packages/flutter_layout_grid
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
  final double loadMoreOffsetFromBottom;
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
  }): this.controller = null,
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
      this.loadMoreOffsetFromBottom = null,
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
  }): this.children = null,
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
      this.loadMoreOffsetFromBottom = null,
      super(key: key);

  OwGrid.pagination({
    Key key,
    @required this.loadMore,
    this.itemBuilder,
    this.itemCount,
    this.children,
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
    this.loadMoreOffsetFromBottom = 0,
    this.horizontalSeparatorWidget,
    this.verticalSeparatorWidget,
  }): assert(itemBuilder == null ? true : itemCount != null, "If you are using 'itemBuilder', needs the 'itemCount'"),
      assert(maxLength == null ? true : itemCount != null, "To use 'maxLength', needs the 'itemCount'"),
      assert(children == null || itemBuilder == null, "You can not use 'children' and 'itemBuilder' at the same time"),
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
    double maxScroll = _scrollController.position.maxScrollExtent - widget.loadMoreOffsetFromBottom;
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
      if(!widget.useStackLoading && !tryAgainCall && widget.loadMoreOffsetFromBottom == 0) {
        // await Future.delayed(const Duration(milliseconds: 100));
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _scrollController.animateTo(maxScroll + 70, duration: const Duration(milliseconds: 200), curve: Curves.easeInSine);
        });
      }
      var result = await widget.loadMore();
      _showLoading = false;
      if(widget.useTryAgainWidget) {
        _showTryAgain = result == false;
      }
    }
  }
}


// import 'package:flutter/material.dart';

// // ? Ver: https://pub.dev/packages/flutter_layout_grid

// @Deprecated("Use 'OwAdaptativeGrid' instead ('numbersInRowAccordingToWidgth' is now 'layout'; 'layout' is now 'styleOfEachLayout')")
// class OwGrid extends StatefulWidget {
//   final List<Widget> children;
//   /// Grid padding
//   final EdgeInsetsGeometry padding;
//   /// Grid margin
//   final EdgeInsetsGeometry margin;
//   /// Height of all rows
//   final double rowHeight;
//   /// Horizontal spacing
//   final double spacing;
//   /// Vertical spacing
//   final double runSpacing;
//   /// Default children quantity horizontally
//   final int horizontalQuantity;
//   /// Children quantity horizontally according to the withd of the screen
//   /// 
//   /// Sample: [100, 500] => Under 100, it will have 1 child horizontally. Between 100
//   /// and 500, it will have 2 children horizontally. Over 500, it will have 3 children
//   /// horizontally
//   /// 
//   /// You can also use the same number twice to skip more than 1 child by case
//   /// 
//   /// Sample: [100, 500, 500] => Under 100 (first case), it will have 1 child horizontally. 
//   /// Between 100 and 500 (second case), it will have 2 children. The third case will be 
//   /// the same of the fourth case, which means that over 500, it will have 4 children 
//   /// per row
//   final List<double> numbersInRowAccordingToWidgth;
//   /// If each child will be a Center as parent
//   final bool centeredChildren;
//   /// Maximum number of rows
//   final int maxNumberOfRows;
//   /// Which column will have its children with an Expanded as parent (horizontally)
//   /// 
//   /// Sample: [null, 1, 2] => The first column will not be Expanded. The second column 
//   /// will be Expanded (flex: 1). The third column will be Expanded (flex: 2)
//   final List<int> flexColumns;
//   /// Width of each column and your children
//   /// 
//   /// Sample: [null, 100, 200] => The first column will have the children's own width. 
//   /// The second column will have width = 100. The third column will have width = 200
//   final List<double> widthColumns;
//   /// Height of each row and your children
//   /// 
//   /// Sample: [null, 100, 200] => The first row will have the children's own height. 
//   /// The second row will have height = 100. The third row will have height = 200
//   final List<double> heightRows;
//   /// Background decoration of the Grid
//   final Decoration backgroundDecoration;
//   /// Defines the layout of each case of [numbersInRowAccordingToWidgth]. 
//   /// 
//   /// Sample: [[], null, [1], [1, null, 2]] => The first (under the first int of 
//   /// [numbersInRowAccordingToWidgth]) and the second case will be not affected. 
//   /// The third case will have on the first row only 1 child, the other rows will not be 
//   /// affected. The fourth case will have on the first row only 1 child, the second row 
//   /// will not be affected, and the third row will have 2 children
//   final List<List<int>> layout;
//   /// The last row can have space to some children and be not filled (missing 1 child 
//   /// for instance). In this case, if [fillLastRow] is true, the last child will have Expanded 
//   /// as parent
//   final bool fillLastRow;
//   /// If you use [widthColumns] in all the columns, maybe the row can not be filled. In 
//   /// this case, if [expandLastColumn] is true, the last child of the row will have Expanded 
//   /// as parent
//   final bool expandLastColumn;
//   /// The widget that will be inside the horizontal separator
//   final Widget horizontalSeparatorWidget;
//   /// The widget that will be inside the vertical separator
//   final Widget verticalSeparatorWidget;
//   /// Use Expanded as grid's parent (for use it on row for instance)
//   final bool isExpanded;
//   /// Use SingleChildScrollView as grid's parent
//   final bool useScrollView;
//   /// When [useScrollView] is true
//   final ScrollController scrollController;
//   /// When [useScrollView] is true
//   final ScrollPhysics scrollPhysics;

//   final Widget Function(BuildContext context, int index) itemBuilder;
//   final int itemCount;
//   final int maxLength;
  
//   OwGrid({
//     Key key,
//     this.children,
//     this.padding,
//     this.margin,
//     this.backgroundDecoration,
//     this.rowHeight,
//     this.spacing = 0,
//     this.runSpacing = 0,
//     this.horizontalQuantity,
//     this.numbersInRowAccordingToWidgth,
//     this.centeredChildren = false,
//     this.maxNumberOfRows,
//     this.flexColumns,
//     this.widthColumns, // * Verificar o que fazer quando colocar um número maior que o de numbersInRowAccordingToWidgth
//     this.heightRows,
//     this.layout,
//     this.fillLastRow = false,
//     this.expandLastColumn = true,
//     this.horizontalSeparatorWidget,
//     this.verticalSeparatorWidget,
//     this.isExpanded = false,
//     this.useScrollView = false,
//     this.scrollController,
//     this.scrollPhysics = const BouncingScrollPhysics(),
//   }): assert(!isExpanded || !useScrollView),
//       this.maxLength = null,
//       this.itemBuilder = null,
//       this.itemCount = null,
//       super(key: key);

//   OwGrid.builder({
//     Key key,
//     @required this.itemBuilder,
//     @required this.itemCount,
//     this.padding,
//     this.margin,
//     this.backgroundDecoration,
//     this.rowHeight,
//     this.spacing = 0,
//     this.runSpacing = 0,
//     this.horizontalQuantity,
//     this.numbersInRowAccordingToWidgth,
//     this.centeredChildren = false,
//     this.maxNumberOfRows,
//     this.flexColumns,
//     this.widthColumns, // * Verificar o que fazer quando colocar um número maior que o de numbersInRowAccordingToWidgth
//     this.heightRows,
//     this.layout,
//     this.fillLastRow = false,
//     this.expandLastColumn = true,
//     this.horizontalSeparatorWidget,
//     this.verticalSeparatorWidget,
//     this.maxLength,
//     this.isExpanded = false,
//     this.useScrollView = false,
//     this.scrollController,
//     this.scrollPhysics = const BouncingScrollPhysics(),
//   }): assert(!isExpanded || !useScrollView),
//       this.children = null,
//       super(key: key);

//   @override
//   _OwGridState createState() => _OwGridState();
// }

// // ignore: deprecated_member_use_from_same_package
// class _OwGridState extends State<OwGrid> {
//   List<Widget> _children;
//   BoxConstraints _constraint;

//   @override
//   void initState() {
//     super.initState();
//     _children = _defineChildren(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.isExpanded
//       ? Expanded(child: _container(context))
//       : widget.useScrollView
//         ? SingleChildScrollView(
//           controller: widget.scrollController,
//           physics: widget.scrollPhysics,
//           child: _container(context),
//         )
//         : _container(context);
//   }

//   Widget _container(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraint) {
//       _constraint = constraint;
//       return Container(
//         margin: widget.margin,
//         padding: widget.padding,
//         decoration: widget.backgroundDecoration,
//         child: _gridView(context),
//       );
//     });
//   }

//   Widget _gridView(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: _columnWidgets(context),
//     );
//   }

//   List<Widget> _defineChildren(BuildContext context) {
//     return widget.children ?? List.generate(
//       widget.maxLength == null || widget.itemCount < widget.maxLength 
//         ? widget.itemCount 
//         : widget.maxLength, 
//       (index) => widget.itemBuilder(context, index),
//     ).toList();
//   }

//   List<Widget> _columnWidgets(BuildContext context) {
//     // double _totalWidth = MediaQuery.of(context).size.width; // LayoutBuilder
//     double _totalWidth = _constraint.minWidth;
//     // double _totalWidth = _gridSize.width;
//     // double _totalWidth = widget.controller.size.width;
//     int _case = 0;
//     if(widget.numbersInRowAccordingToWidgth != null) {
//       int i = 0;
//       for(; i < widget.numbersInRowAccordingToWidgth.length; i++) {
//         if(_totalWidth <= widget.numbersInRowAccordingToWidgth[i]) {
//           break;
//         }
//       }
//       _case = i;
//     }
//     // print("_case: $_case");

//     List<int> _alignment;
//     if(widget.layout != null && widget.layout.length > _case) {
//       _alignment = widget.layout[_case];
//     }

//     List<Widget> _rowWidgets(int index, int rowIndex) {
//       int _quantityInRow;
//       if(_alignment != null && _alignment.length > rowIndex) {
//         _quantityInRow = _alignment[rowIndex];
//       }
//       _quantityInRow = _quantityInRow ?? widget.horizontalQuantity ?? _case + 1;
//       if(widget.fillLastRow && _quantityInRow > _children.length - index) {
//         _quantityInRow = _children.length - index;
//       }

//       double _rowHeight;
//       if(widget.heightRows != null && widget.heightRows.length > rowIndex) {
//         _rowHeight = widget.heightRows[rowIndex];
//       }
//       _rowHeight = _rowHeight ?? widget.rowHeight;

//       bool _hasFlex = false;
//       if(_quantityInRow > 1) {
//         for(int i = 0; i < _quantityInRow; i++) {
//           int childIndex = index + i;
//           if(_children.length > childIndex) {
//             if(widget.widthColumns == null || widget.widthColumns.length <= i || widget.widthColumns[i] == null) {
//               _hasFlex = true;
//             }
//           }
//         }
//       }

//       List<Widget> _widgetsInRow = [];
//       int column = 0;
//       for(int i = index; column < _quantityInRow; i++) {
//         if(widget.fillLastRow && i >= _children.length) {
//           break;
//         }

//         Widget child;
//         if(i >= _children.length) {
//           child = null;
//         } else {
//           child = _children[i];
//         }

//         if(_widgetsInRow.isNotEmpty) {
//           _widgetsInRow.add(
//             SizedBox(
//               width: widget.spacing,
//               height: _rowHeight, // + widget.runSpacing to use a divider (needs Stack)
//               child: widget.horizontalSeparatorWidget,
//             ),
//           );
//         }

//         double _widthChild;
//         if(
//           _hasFlex || 
//           (!_hasFlex && column + 1 < _quantityInRow) || 
//           (!widget.expandLastColumn && column + 1 == _quantityInRow)
//         ) {
//           if(widget.widthColumns != null && widget.widthColumns.length > column && widget.widthColumns[column] != null) {
//             _widthChild = widget.widthColumns[column];
//           }
//         }

//         int _flex;
//         if(_widthChild == null) {
//           if(widget.flexColumns != null && widget.flexColumns.length > column) {
//             _flex = widget.flexColumns[column];
//           }
//           _flex = _flex ?? 1;
//         }

//         if(_flex != null) {
//           child = Expanded(
//             flex: _flex,
//             child: Container(
//               height: _rowHeight,
//               child: child,
//             ),
//           );
//         } else {
//           child = Container(
//             width: _widthChild,
//             height: _rowHeight,
//             child: child,
//           );
//         }

//         _widgetsInRow.add(child);
//         column++;
//       }

//       return _widgetsInRow;
//     }

//     List<Widget> _columnChildren = [];

//     int _rowIndex = 0;
//     for(int i = 0; i < _children.length && (widget.maxNumberOfRows == null || _rowIndex < widget.maxNumberOfRows);) {
//       if(_columnChildren.isNotEmpty) {
//         _columnChildren.add(
//           SizedBox(
//             height: widget.runSpacing,
//             child: widget.verticalSeparatorWidget,
//           ),
//         );
//       }

//       List<Widget> _rowChildren = _rowWidgets(i, _rowIndex);
//       _columnChildren.add(
//         Row(children: _rowChildren),
//       );

//       i += (_rowChildren.length / 2).ceil();
//       _rowIndex++;
//     }

//     return _columnChildren;
//   }

//   // void _calculateGridSize() {
//   //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//   //     final RenderBox render = _gridKey.currentContext.findRenderObject();
//   //     _gridSize = render.size;
//   //     print("_gridSize: $_gridSize");
//   //     // setState(() {});
//   //   });
//   // }
// }


// // class OwGridController extends StatefulWidget {
// //   final GridController controller;
// //   const OwGridController({
// //     Key key,
// //     this.controller,
// //   }) : super(key: key);

// //   @override
// //   _OwGridControllerState createState() => _OwGridControllerState();
// // }

// // class _OwGridControllerState extends State<OwGridController> {
// //   GlobalKey _gridKey = GlobalKey();

// //   @override
// //   Widget build(BuildContext context) {
// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //       final RenderBox render = _gridKey.currentContext.findRenderObject();
// //       widget.controller.size = render.size;
// //     });
// //     return Container(
// //       key: _gridKey,
// //       height: 0,
// //     );
// //   }
// // }

// // class GridController {
// //   Size size;
// // }