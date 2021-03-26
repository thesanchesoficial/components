import 'package:flutter/material.dart';

class OwDropdown extends StatelessWidget {
  final String value;
  final bool isExpanded;
  final String labelText;
  final bool readOnly;
  final ValueChanged<String> onChanged;
  final Function onTap;
  final EdgeInsets margin;
  final FocusNode focusNode;
  final List<String> optionsList;
  final Color color;
  final bool enabled;
  final Widget disabledHint;

  final Color errorColor = Colors.red;

  const OwDropdown({
    Key key,
    this.labelText,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.margin,
    this.value,
    this.focusNode,
    this.optionsList,
    this.color,
    this.enabled = true,
    this.disabledHint,
  })  : isExpanded = false,
        super(key: key);

  const OwDropdown.withExpanded({
    Key key,
    this.labelText,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.margin,
    this.value,
    this.focusNode,
    this.optionsList,
    this.color,
    this.enabled = true,
    this.disabledHint,
  })  : isExpanded = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        isExpanded: isExpanded,
        disabledHint: disabledHint,
        decoration: InputDecoration(
          filled: true,
          fillColor: color ?? Theme.of(context).cardColor,
          labelText: labelText,
          alignLabelWithHint: false,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).secondaryHeaderColor, 
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
          ),
          contentPadding: const EdgeInsets.only(
            left: 20, 
            right: 20, 
            top: 15, 
            bottom: 14,
          ),
          labelStyle: TextStyle(
            color: Theme.of(context).primaryTextTheme.bodyText1.color,
          ),
          errorBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: errorColor),
          ),
          errorStyle: TextStyle(color: errorColor),
        ),
        value: value,
        onChanged: enabled
          ? onChanged
          : null,
        items: optionsList?.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })?.toList(),
      ),
    );
  }
}
