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

  const OwGrid({
    Key key,
    this.children,
    this.padding,
    this.constraints,
    this.rowHeight,
    this.spacing = 10,
    this.runSpacing = 10,
    this.horizontalQuantity = 1,
    this.numbersInRowAccordingToWidgth,
    this.centeredChildren = false,
    this.alignment = Alignment.topLeft,
    this.maxNumberOfRows = 2,
    this.flexColumns,
    this.widthColumns, // * Verificar o que fazer quando colocar um némero maior que o de numbersInRowAccordingToWidgth
    this.heightRows,
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
        children: _columnChildren(context),
      ),
    );
  }

  List<Widget> _columnChildren(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    List<Widget> columnChildren = [];
    int rowQuantity = maxNumberOfRows ?? children.length;
    if(heightRows != null && heightRows.length < rowQuantity) {
      for(int i = heightRows.length; i < rowQuantity; i++) {
        heightRows.add(null);
      }
    }

    int _horizontalQuantity;
    if(numbersInRowAccordingToWidgth == null) {
      _horizontalQuantity = horizontalQuantity;
    } else {
      int i = 0;
      for(; i < numbersInRowAccordingToWidgth.length; i++) {
        if(_widthScreen <= numbersInRowAccordingToWidgth[i]) {
          break;
        }
      }
      // if(children != null && i >= children.length) {
      //   i = children.length - 1;
      // }
      _horizontalQuantity = i + 1;
    }

    int row = 0;
    for(int i = 0; i < children.length; i++) {
      row++;

      double _rowHeight = rowHeight;
      if(heightRows != null) {
        _rowHeight = heightRows[row - 1] ?? _rowHeight;
      }

      List<Widget> rowChildren = _rowChildren(context, i, _rowHeight, _horizontalQuantity);
      i += _horizontalQuantity - 1;

      columnChildren.add(
        Row(
          children: rowChildren,
        ),
      );
      if(runSpacing != null && i < children.length) {
        columnChildren.add(
          SizedBox(height: runSpacing),
        );
      }
    }
    return columnChildren;
  }

  List<Widget> _rowChildren(BuildContext context, int fromIndex, double height, int _horizontalQuantity) {
    List<Widget> rowChildren = [];

    if(widthColumns != null && widthColumns.length < _horizontalQuantity) {
      for(int i = widthColumns.length; i < _horizontalQuantity; i++) {
        widthColumns.add(null);
      }
    }
    if(flexColumns != null && flexColumns.length < _horizontalQuantity) {
      for(int i = flexColumns.length; i < _horizontalQuantity; i++) {
        flexColumns.add(null);
      }
    }

    bool hasFlex = false;
    if(flexColumns != null) {
      for(int i = 0; i < _horizontalQuantity - 1; i++) {
        if(flexColumns[i] != null) {
          hasFlex = true;
          break;
        }
      }
    }

    int column = 0;
    for(int i = fromIndex; i - fromIndex < _horizontalQuantity; i++) {
      column++;
      double _columnWidth;
      if(widthColumns != null) {
        _columnWidth = widthColumns[column - 1];
      }
      int flex = 1;
      if(flexColumns != null) {
        flex = flexColumns[column - 1] ?? flex;
      }

      Widget child;
      bool definedWidth = _columnWidth != null && hasFlex;
      if(i >= children.length) {
        if(definedWidth) {
          child = SizedBox(
            width: _columnWidth,
          );
        } else {
          child = Expanded(
            flex: flex,
            child: const SizedBox(),
          );
        }
      } else {
        if(definedWidth) {
          child = Container(
            width: _columnWidth,
            height: height,
            child: children[i],
          );
        } else {
          child = Expanded(
            flex: flex,
            child: Container(
              height: height,
              child: children[i],
            ),
          );
        }
      }
      rowChildren.add(child);
      if(spacing != null && column < _horizontalQuantity) {
        rowChildren.add(
          SizedBox(width: spacing),
        );
      }

    }

    return rowChildren;
  }
}