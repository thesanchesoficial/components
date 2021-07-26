import 'package:flutter/material.dart';

// ! Buscar: Fixar labels das colunas no topo ao rolar pra baixo (e também fixar alguns atributo da linha ao rolar pro lado (como o index))
//  https://pub.dev/packages/table_sticky_headers / https://pub.dev/packages/horizontal_data_table

class OwDataTable extends StatefulWidget {
  final List<ColumnField> columnFields;
  /// The row classes that will fill the table
  /// 
  /// The class needs to have the [toMap] method that returns a map
  final List<dynamic> dataTable;
  final bool rowIndex;
  final Widget rowIndexWidget;
  final double columnSpacing;
  final EdgeInsets margin;
  final Decoration decoration;
  final double dividerThickness;
  final bool shrinkWrap;
  final ScrollController controller;
  final bool toLowerCaseOnSorted;
  final double dataRowHeight;
  final TextStyle dataTextStyle;
  final TextStyle headingTextStyle;
  final Color dataRowColor;
  final double horizontalMargin;
  final bool showCheckboxColumn;
  /// [checked], [row index], [data]
  final void Function(bool, int, dynamic) onRowSelected;
  /// [data], [row index]
  final void Function(dynamic, int) onIndexCellTap;
  /// [data], [row index], [column index]
  final void Function(dynamic, int, int) onAnyCellTap;
  const OwDataTable({
    Key key,
    @required this.columnFields,
    @required this.dataTable,
    this.rowIndex = true,
    this.rowIndexWidget = const Text("#"),
    this.columnSpacing,
    this.margin = const EdgeInsets.all(8),
    this.decoration,
    this.dividerThickness,
    this.shrinkWrap = true,
    this.controller,
    this.toLowerCaseOnSorted = true,
    this.dataRowHeight,
    this.dataTextStyle,
    this.headingTextStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.dataRowColor,
    this.horizontalMargin,
    this.showCheckboxColumn,
    this.onRowSelected,
    this.onIndexCellTap,
    this.onAnyCellTap,
  }) : super(key: key);
  
  @override
  _OwDataTableState createState() => _OwDataTableState(
    columnFields, 
    dataTable, 
    rowIndex, 
    rowIndexWidget, 
    columnSpacing,
    margin,
    decoration,
    dividerThickness,
    shrinkWrap,
    controller,
    toLowerCaseOnSorted,
    dataRowHeight,
    dataTextStyle,
    headingTextStyle,
    dataRowColor,
    horizontalMargin,
    showCheckboxColumn,
    onRowSelected,
    onIndexCellTap,
    onAnyCellTap,
  );
}

class _OwDataTableState extends State<OwDataTable> {
  final List<ColumnField> columnFields;
  final List<dynamic> dataTable;
  final bool rowIndex;
  final Widget rowIndexWidget;
  final double columnSpacing;
  final EdgeInsets margin;
  final Decoration decoration;
  final double dividerThickness;
  final bool shrinkWrap;
  final bool toLowerCaseOnSorted;
  final ScrollController controller;
  final double dataRowHeight;
  final TextStyle dataTextStyle;
  final TextStyle headingTextStyle;
  final Color dataRowColor;
  final double horizontalMargin;
  final bool showCheckboxColumn;
  final void Function(bool, int, dynamic) onRowSelected;
  final void Function(dynamic, int) onIndexCellTap;
  final void Function(dynamic, int, int) onAnyCellTap;
  _OwDataTableState(
    this.columnFields,
    this.dataTable,
    this.rowIndex,
    this.rowIndexWidget,
    this.columnSpacing,
    this.margin,
    this.decoration,
    this.dividerThickness,
    this.shrinkWrap,
    this.controller,
    this.toLowerCaseOnSorted,
    this.dataRowHeight,
    this.dataTextStyle,
    this.headingTextStyle,
    this.dataRowColor,
    this.horizontalMargin,
    this.showCheckboxColumn,
    this.onRowSelected,
    this.onIndexCellTap,
    this.onAnyCellTap,
  );

  List<dynamic> _usedMapKeys = [];
  int _sortColumnIndex = 0;
  bool _isAscending = true;
  ScrollController _scrollController;
  List<bool> _selectedRows;
  void Function() _updateState;

  @override
  void initState() { 
    super.initState();
    if(!shrinkWrap) {
      _scrollController = controller ?? ScrollController();
    }

    columnFields.forEach((element) {
      _usedMapKeys.add(element.usedMapKey);
    });
    
    if(onRowSelected != null) {
      _selectedRows = [];
      dataTable.forEach((element) {
        _selectedRows.add(false);
      });
    }

    _updateState = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return shrinkWrap
      ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _dataTable(context),
      )
      : SingleChildScrollView(
        controller: _scrollController,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _dataTable(context),
        ),
      );
  }

  Widget _dataTable(BuildContext context) {
    return Container(
      margin: margin,
      child: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _isAscending,
        columns: _getColumns(),
        rows: _getRows(dataTable),
        columnSpacing: columnSpacing,
        dividerThickness: dividerThickness,
        dataRowColor: MaterialStateProperty.all(dataRowColor),
        dataRowHeight: dataRowHeight,
        showBottomBorder: true,
        dataTextStyle: dataTextStyle,
        headingTextStyle: headingTextStyle,
        horizontalMargin: horizontalMargin,
        decoration: decoration ?? BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Theme.of(context).accentColor),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).accentColor.withOpacity(0.1),
              Theme.of(context).accentColor.withOpacity(0.2),
            ],
          ),
        ),
        showCheckboxColumn: showCheckboxColumn ?? onRowSelected != null,
      ),
    );
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumns = [];
    if(rowIndex) {
      dataColumns.add(DataColumn(label: rowIndexWidget));
    }
    dataColumns = dataColumns + List.generate(
      columnFields.length, 
      (cIndex) => DataColumn(
        label: columnFields[cIndex].widgetColumn ?? Text(
          "${columnFields[cIndex].labelColumn}",
          style: columnFields[cIndex].labelColumnTextStyle,
        ),
        tooltip: columnFields[cIndex].tooltipLabelColumn,
        numeric: cIndex == 0 && rowIndex
          ? true
          : columnFields[cIndex].numeric,
        onSort: columnFields[cIndex].canSortByThisColumn
          ? (index, ascending) {
            _sortColumnIndex = index;
            _isAscending = ascending;
            _sortList(index, ascending);
            _updateState();
          }
          : null,
      ),
    );
    return dataColumns;
  }

  List<DataRow> _getRows(List<dynamic> rows) {
    return List.generate(
      dataTable.length, 
      (ri) {
        List<dynamic> cells = [];
        Map mapResult = dataTable[ri].toMap();
        _usedMapKeys.forEach((element) {
          cells.add(mapResult[element]);
        });
        return DataRow(
          onSelectChanged: onRowSelected == null
            ? null
            : (value) {
              onRowSelected(value, ri, dataTable[ri]);
              if(showCheckboxColumn != false) {
                _selectedRows[ri] = value;
                _updateState();
              }
            },
          selected: onRowSelected == null
            ? false
            : _selectedRows[ri],
          cells: _getCells(cells, ri),
        );
      },
    );
  }

  List<DataCell> _getCells(List<dynamic> cells, int rIndex) {
    List<DataCell> result = List.generate(
      cells.length, 
      (cIndex) => DataCell(
        _defineCellWidget(cells[cIndex], rIndex, cIndex),
        onTap: columnFields[cIndex].onCellTap != null
          ? () => columnFields[cIndex].onCellTap(cells[cIndex], rIndex, cIndex)
          : onAnyCellTap != null
            ? () => onAnyCellTap(cells[cIndex], rIndex, cIndex)
            : null,
      ),
    );
    if(rowIndex) {
      result.insert(0, DataCell(
        Text(
          "${rIndex + 1}",
          textAlign: TextAlign.right,
        ),
        onTap: onIndexCellTap != null
          ? () => onIndexCellTap(dataTable[rIndex], rIndex)
          : onAnyCellTap != null
            ? () => onAnyCellTap(dataTable[rIndex], rIndex, 0)
            : null,
      ));
    }
    return result;
  }

  Widget _defineCellWidget(dynamic data, int rIndex, int cIndex) {
    if(columnFields[cIndex].defineWidgetCell != null) {
      return columnFields[cIndex].defineWidgetCell(
        data, 
        rIndex,
        rowIndex ? cIndex + 1 : cIndex,
      );
    }

    Widget containerWidget;

    switch (data.runtimeType) {
      case Null:
        containerWidget = const Center(child: Icon(Icons.do_not_disturb_on));
        break;
      case bool:
        containerWidget = Center(
          child: data == true 
            ? const Icon(Icons.check, color: Colors.green)
            : const Icon(Icons.close, color: Colors.redAccent),
        );
        break;
      default:
        containerWidget = Text(
          "$data",
          maxLines: columnFields[cIndex].maxLines,
          style: columnFields[cIndex].columnCellsTextStyle,
        );
        break;
    }

    return Container(
      width: columnFields[cIndex].width,
      color: columnFields[cIndex].backgroundColor,
      constraints: columnFields[cIndex].maxWidth != null
        ? BoxConstraints(
          maxWidth: columnFields[cIndex].maxWidth,
        )
        : null,
      child: containerWidget,
    );
  }

  void _sortList(int index, bool ascending) {
    if(rowIndex) index--;
    dataTable.sort((row1, row2) {
      var rowMap1 = row1.toMap();
      var rowMap2 = row2.toMap();
      dynamic value1 = rowMap1[_usedMapKeys[index]];
      dynamic value2 = rowMap2[_usedMapKeys[index]];
      // if(_usedMapKeys[index] is String && _usedMapKeys[index].contains(_mapSeparator)) {
      //   List<String> separatorMapKeys = _usedMapKeys[index].toString().split(_mapSeparator);
      //   value1 = rowMap1;
      //   separatorMapKeys.forEach((element) {
      //     value1 = value1[element];
      //   });
      // }
      return _compareValues(ascending, value1, value2);
    });
  }

  int _compareValues(bool ascending, dynamic value1, dynamic value2) {
    if(value1 == null && value2 == null) return 0;
    if(ascending) {
      if(value1 == null) return 1;
      if(value2 == null) return -1;
    } else {
      if(value1 == null) return -1;
      if(value2 == null) return 1;
    }

    value1 = toLowerCaseOnSorted 
      ? value1.toString().toLowerCase() 
      : value1.toString();
    value2 = toLowerCaseOnSorted
      ? value2.toString().toLowerCase()
      : value2.toString();

    return ascending 
      ? value1.compareTo(value2) 
      : value2.compareTo(value1);
  }
}



// ! Separate file
class ColumnField {
  final String labelColumn;
  final Widget widgetColumn;
  final String tooltipLabelColumn;
  final dynamic usedMapKey;
  final bool numeric;
  final TextStyle labelColumnTextStyle;
  final TextStyle columnCellsTextStyle;
  final double maxWidth;
  final double width;
  final int maxLines;
  final Color backgroundColor;
  final Widget Function(dynamic, int, int) defineWidgetCell;
  final bool canSortByThisColumn;
  final void Function(dynamic, int, int) onCellTap;

  ColumnField({
    @required this.usedMapKey,
    this.labelColumn,
    this.widgetColumn,
    this.defineWidgetCell,
    this.tooltipLabelColumn,
    this.numeric = false,
    this.labelColumnTextStyle,
    this.columnCellsTextStyle,
    this.maxWidth,
    this.maxLines = 2,
    this.width,
    this.backgroundColor,
    this.canSortByThisColumn = true,
    this.onCellTap,
  }): assert(labelColumn != null || widgetColumn != null),
      assert(usedMapKey != null);
}
