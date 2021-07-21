import 'package:components_venver/material.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';

class OwAutoForm extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final dynamic data;
  final List<FieldConfig> fieldsConfig;
  final double spacing;

  const OwAutoForm({
    Key key,
    this.margin,
    @required this.data,
    @required this.fieldsConfig,
    this.spacing,
  }) : super(key: key);

  @override
  _OwAutoFormState createState() => _OwAutoFormState(
    margin,
    data,
    fieldsConfig,
    spacing,
  );
}

class _OwAutoFormState extends State<OwAutoForm> {
  final EdgeInsetsGeometry margin;
  final dynamic data;
  final List<FieldConfig> fieldsConfig;
  final double spacing;

  _OwAutoFormState(
    this.margin,
    this.data,
    this.fieldsConfig,
    this.spacing,
  );

  List<dynamic> _usedMapKeys = [];
  Map<dynamic, dynamic> _mapFieldData;

  List<Widget> initialFields = [];
  List<Widget> finalFields = [];

  bool _firstBuild = true;

  @override
  void initState() { 
    super.initState();
    
    fieldsConfig.forEach((element) {
      _usedMapKeys.add(element.usedMapKey);
    });

    _mapFieldData = data.toMap();
  }

  @override
  Widget build(BuildContext context) {
    _generateWidgets();

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: initialFields + [
          Wrap(
            alignment: WrapAlignment.start,
            spacing: spacing ?? 0,
            runSpacing: spacing ?? 0,
            children: finalFields,
          ),
        ],
      ),
    );
  }

  void _generateWidgets() {
    if(_firstBuild) {
      List.generate(
        fieldsConfig.length, 
        (i) => _generateSingleWidget(i, fieldsConfig[i]),
      );
      
      if(spacing != null && finalFields.isNotEmpty) {
        initialFields.add(SizedBox(height: spacing));
      }
      _firstBuild = false;
    }
  }

  void _generateSingleWidget(int index, FieldConfig fieldConfig) {
    fieldConfig.data = _mapFieldData[fieldConfig.usedMapKey];

    Widget field;

    switch (fieldConfig.data.runtimeType) {
      case bool:
        fieldConfig.controller = fieldConfig.controller ?? fieldConfig.data;
        break;
      case Null:
        break;
      default:
        fieldConfig.controller = TextEditingController(text: "${fieldConfig.data}"); // ! MaskedTextController(text: "${fieldConfig.data}", mask: fieldConfig.textFieldMask);
    }

    if(fieldConfig.defineWidgetField != null) {
      field = fieldConfig.defineWidgetField(
        const BoxConstraints(
          maxHeight: 48,
          minHeight: 48,
        ), 
        fieldConfig,
      );
    } else {
      if(fieldConfig.editable) {
        switch (fieldConfig.data.runtimeType) {
          case bool:
            field = _OwIconForm(fieldConfig: fieldConfig);
            break;
          case Null:
            field = _OwIconForm(fieldConfig: fieldConfig, nullIcon: true);
            break;
          default:
            field = Container(
              width: fieldConfig.width,
              constraints: fieldConfig.maxWidth != null
                ? BoxConstraints(maxWidth: fieldConfig.maxWidth)
                : null,
              child: OwTextField(
                controller: fieldConfig.controller,
                labelText: fieldConfig.label,
                keyboardType: fieldConfig.keyboardType,
              ),
            );
            break;
        }
      } else {
        switch (fieldConfig.data.runtimeType) {
          case bool:
            field = _OwIconForm(fieldConfig: fieldConfig);
            break;
          case Null:
            field = _OwIconForm(fieldConfig: fieldConfig, nullIcon: true);
            break;
          default:
            field = Container(
              width: fieldConfig.width,
              constraints: fieldConfig.maxWidth != null
                ? BoxConstraints(maxWidth: fieldConfig.maxWidth)
                : null,
              child: OwTextField(
                controller: fieldConfig.controller,
                labelText: fieldConfig.label,
                onChanged: (_) => fieldConfig.controller.text = "${fieldConfig.data}",
                readOnly: true,
              ),
            );
        }
      }
    }

    if(
      fieldConfig.columnChild ?? (
        fieldConfig.width == null && 
        fieldConfig.maxWidth == null && 
        fieldConfig.data.runtimeType != bool && 
        fieldConfig.data != null
      )
    ) {
      if(spacing != null && index > 0) {
        initialFields.add(SizedBox(height: spacing));
      }
      initialFields.add(
        fieldConfig.tooltipLabel == null
          ? field
          : Tooltip(message: fieldConfig.tooltipLabel, child: field),
      );
    } else {
      finalFields.add(
        fieldConfig.tooltipLabel == null
          ? field
          : Tooltip(message: fieldConfig.tooltipLabel, child: field),
      );
    }
  }
}



// ! Separate file
class _OwIconForm extends StatefulWidget {
  final FieldConfig fieldConfig;
  final bool nullIcon;
  const _OwIconForm({
    Key key,
    this.fieldConfig,
    this.nullIcon = false,
  }) : super(key: key);
  
  @override
  __OwIconFormState createState() => __OwIconFormState();
}

class __OwIconFormState extends State<_OwIconForm> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).secondaryHeaderColor),
          color: Theme.of(context).cardColor,
        ),
        child: widget.fieldConfig.label == null
          ? _icon()
          : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${widget.fieldConfig.label}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              _icon(),
            ],
          ),
        ),
      onTap: widget.fieldConfig.editable && !widget.nullIcon
        ? () {
          widget.fieldConfig.controller = !widget.fieldConfig.controller;
          setState(() {});
        }
        : null,
    );
  }

  Widget _icon() {
    if(widget.nullIcon) {
      return Icon(Icons.do_not_disturb_on);
    } else {
      return widget.fieldConfig.controller
        ? const Icon(Icons.check, color: Colors.green)
        : const Icon(Icons.close, color: Colors.redAccent);
    }
  }
}



// ! Separate file
class FieldConfig {
  /// The label
  final String label;
  /// The tooltip of the label  
  final String tooltipLabel;
  /// The key from the map (toMap) of the data class
  final dynamic usedMapKey;
  /// Whether the field will or will not be editable
  final bool editable;
  /// Define the keyboard type if the generated widget is TextField
  final TextInputType keyboardType;
  /// Maximun width of the widget (if defined, it will be child of the Wrap)
  final double maxWidth;
  /// Width of the widget (if defined, it will be child of the Wrap)
  final double width;
  /// Whether the generated widget or the [defineWidgetField] will be child of the
  /// Column
  final bool columnChild;
  /// The firs field is suggested constraint to use. The second field is the FieldConfig
  /// instance
  final Widget Function(BoxConstraints, FieldConfig) defineWidgetField;
  /// It will be setted while the screen is building. It is the controller to use in
  /// TextFields, or boolean fields
  dynamic controller;
  /// It will be setted while the screen is building. It is the data of [usedMapKey]
  dynamic data;
  
  // final String textFieldMask;

  FieldConfig({
    this.label,
    this.tooltipLabel,
    @required this.usedMapKey,
    this.editable = false,
    this.defineWidgetField,
    this.keyboardType,
    this.maxWidth,
    this.width,
    this.columnChild,
    // this.textFieldMask,
  }): assert(!editable || keyboardType == null);
}
