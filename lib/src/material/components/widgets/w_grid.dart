import 'package:flutter/material.dart';

class OwGrid extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final double rowHeight;
  final double spacing;
  final double runSpacing;
  final int horizontalQuantity;
  final List<double> numbersInRowAccordingToWidgth;
  final AlignmentGeometry alignment;
  final bool centeredChildren;
  final int maxNumberOfRows;
  final List<int> flexColumns;
  final List<double> widthColumns;
  final List<double> heightRows;
  final BoxConstraints constraints;
  final List<List<int>> layout;
  final bool fillLastRow;
  final bool expandLastColumn;

  const OwGrid({
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
    this.alignment = Alignment.topLeft,
    this.maxNumberOfRows,
    this.flexColumns,
    this.widthColumns, // * Verificar o que fazer quando colocar um némero maior que o de numbersInRowAccordingToWidgth
    this.heightRows,
    this.layout,
    this.fillLastRow = false,
    this.expandLastColumn = true,
  }) :  
  // assert((flexColumns != null && flexColumns.length >= numbersInRowAccordingToWidgth.length) || flexColumns == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      constraints: constraints,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        key: key,
        // children: _columnChildren(context), // * Pra voltar pro antigo, é só decomentar essa linha e as funções comentadas abaixo
        children: _columnWidgets(context),
      ),
    );
  }

  List<Widget> _columnWidgets(BuildContext context) {
    double _totalWidth = MediaQuery.of(context).size.width; // LayoutBuilder
    int _case = 0;
    if(numbersInRowAccordingToWidgth != null) {
      int i = 0;
      for(; i < numbersInRowAccordingToWidgth.length; i++) {
        if(_totalWidth <= numbersInRowAccordingToWidgth[i]) {
          break;
        }
      }
      _case = i;
    }
    // print("_case: $_case");

    List<int> _alignment;
    if(layout != null && layout.length > _case) {
      _alignment = layout[_case];
    }
    
    List<Widget> _rowWidgets(int index, int rowIndex) {
      int _quantityInRow;
      if(_alignment != null && _alignment.length > rowIndex) {
        _quantityInRow = _alignment[rowIndex];
      }
      _quantityInRow = _quantityInRow ?? horizontalQuantity ?? _case + 1;
      if(fillLastRow && _quantityInRow > children.length - index) {
        _quantityInRow = children.length - index;
      }

      double _rowHeight;
      if(heightRows != null && heightRows.length > rowIndex) {
        _rowHeight = heightRows[rowIndex];
      }
      _rowHeight = _rowHeight ?? rowHeight;

      bool _hasFlex = false;
      if(_quantityInRow > 1) {
        for(int i = 0; i < _quantityInRow; i++) {
          int childIndex = index + i;
          if(children.length > childIndex) {
            if(widthColumns == null || widthColumns.length <= i || widthColumns[i] == null) {
              _hasFlex = true;
            }
          }
        }
      }

      List<Widget> _widgetsInRow = [];
      int column = 0;
      for(int i = index; column < _quantityInRow; i++) {
        if(fillLastRow && i >= children.length) {
          break;
        }

        Widget child;
        if(i >= children.length) {
          child = null;
        } else {
          child = children[i];
        }

        if(_widgetsInRow.isNotEmpty) {
          _widgetsInRow.add(
            SizedBox(width: spacing),
          );
        }

        double _widthChild;
        if(
          _hasFlex || 
          (!_hasFlex && column + 1 < _quantityInRow) || 
          (!expandLastColumn && column + 1 == _quantityInRow)
        ) {
          if(widthColumns != null && widthColumns.length > column && widthColumns[column] != null) {
            _widthChild = widthColumns[column];
          }
        }

        int _flex;
        if(_widthChild == null) {
          if(flexColumns != null && flexColumns.length > column) {
            _flex = flexColumns[column];
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
    for(int i = 0; i < children.length && (maxNumberOfRows == null || _rowIndex < maxNumberOfRows);) {
      if(_columnChildren.isNotEmpty) {
        _columnChildren.add(
          SizedBox(height: runSpacing),
        );
      }

      List<Widget> _rowChildren = _rowWidgets(i, _rowIndex);
      _columnChildren.add(
        Row(children: _rowChildren),
      );

      i += (_rowChildren.length / 2).ceil();
      _rowIndex++;
    }

    return _columnChildren;
  }



  // List<Widget> _columnChildren(BuildContext context) {
  //   double _widthScreen = MediaQuery.of(context).size.width;
  //   List<Widget> columnChildren = [];
  //   int rowQuantity = maxNumberOfRows ?? children.length;
  //   if(heightRows != null && heightRows.length < rowQuantity) {
  //     for(int i = heightRows.length; i < rowQuantity; i++) {
  //       heightRows.add(null);
  //     }
  //   }

  //   int _horizontalQuantity;
  //   if(numbersInRowAccordingToWidgth == null) {
  //     _horizontalQuantity = horizontalQuantity;
  //   } else {
  //     int i = 0;
  //     for(; i < numbersInRowAccordingToWidgth.length; i++) {
  //       if(_widthScreen <= numbersInRowAccordingToWidgth[i]) {
  //         break;
  //       }
  //     }
  //     // if(children != null && i >= children.length) {
  //     //   i = children.length - 1;
  //     // }
  //     _horizontalQuantity = i + 1;
  //   }

  //   int row = 0;
  //   for(int i = 0; i < children.length; i++) {
  //     row++;

  //     double _rowHeight = rowHeight;
  //     if(heightRows != null) {
  //       _rowHeight = heightRows[row - 1] ?? _rowHeight;
  //     }

  //     List<Widget> rowChildren = _rowChildren(context, i, _rowHeight, _horizontalQuantity);
  //     i += _horizontalQuantity - 1;

  //     columnChildren.add(
  //       Row(
  //         children: rowChildren,
  //       ),
  //     );
  //     if(runSpacing != null && i < children.length) {
  //       columnChildren.add(
  //         SizedBox(height: runSpacing),
  //       );
  //     }
  //   }
  //   return columnChildren;
  // }

  // List<Widget> _rowChildren(BuildContext context, int fromIndex, double height, int _horizontalQuantity) {
  //   List<Widget> rowChildren = [];

  //   if(widthColumns != null && widthColumns.length < _horizontalQuantity) {
  //     for(int i = widthColumns.length; i < _horizontalQuantity; i++) {
  //       widthColumns.add(null);
  //     }
  //   }
  //   if(flexColumns != null && flexColumns.length < _horizontalQuantity) {
  //     for(int i = flexColumns.length; i < _horizontalQuantity; i++) {
  //       flexColumns.add(null);
  //     }
  //   }

  //   bool hasFlex = false;
  //   if(flexColumns != null) {
  //     for(int i = 0; i < _horizontalQuantity - 1; i++) {
  //       if(flexColumns[i] != null) {
  //         hasFlex = true;
  //         break;
  //       }
  //     }
  //   }

  //   int column = 0;
  //   for(int i = fromIndex; i - fromIndex < _horizontalQuantity; i++) {
  //     column++;
  //     double _columnWidth;
  //     if(widthColumns != null) {
  //       _columnWidth = widthColumns[column - 1];
  //     }
  //     int flex = 1;
  //     if(flexColumns != null) {
  //       flex = flexColumns[column - 1] ?? flex;
  //     }

  //     Widget child;
  //     bool definedWidth = _columnWidth != null && hasFlex;
  //     if(i >= children.length) {
  //       if(definedWidth) {
  //         child = SizedBox(
  //           width: _columnWidth,
  //         );
  //       } else {
  //         child = Expanded(
  //           flex: flex,
  //           child: const SizedBox(),
  //         );
  //       }
  //       // * Test
  //       child = null;
  //     } else {
  //       if(definedWidth) {
  //         child = Container(
  //           width: _columnWidth,
  //           height: height,
  //           child: children[i],
  //         );
  //       } else {
  //         child = Expanded(
  //           flex: flex,
  //           child: Container(
  //             height: height,
  //             child: children[i],
  //           ),
  //         );
  //       }
  //     }
  //     if(child != null) {
  //       rowChildren.add(child);
  //     }
  //     if(child != null && spacing != null && column < _horizontalQuantity) {
  //       rowChildren.add(
  //         SizedBox(width: spacing),
  //       );
  //     }

  //   }

  //   return rowChildren;
  // }
}