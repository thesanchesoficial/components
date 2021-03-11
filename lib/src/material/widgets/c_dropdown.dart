import 'package:flutter/material.dart';

class MSDropdown extends StatelessWidget {
  final String value;
  final bool expanded;
  final String labelText;
  final bool readOnly;
  final ValueChanged<String> onChanged;
  final Function onTap;
  final EdgeInsets margin;
  final FocusNode focusNode;
  final List<String> listaOpcoes;
  final Color color;

  const MSDropdown({
    Key key,
    this.labelText,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.margin,
    this.value = "Conta Corrente",
    this.focusNode,
    this.listaOpcoes = const <String>['Conta Corrente', 'Poupança'],
    this.color,
  })  : expanded = false,
        super(key: key);

  const MSDropdown.withExpanded({
    Key key,
    this.labelText,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.margin,
    this.value = "Conta Corrente",
    this.focusNode,
    this.listaOpcoes = const <String>['Conta Corrente', 'Poupança'],
    this.color,
  }) : expanded = true,
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        isExpanded: expanded,
        decoration: InputDecoration(
          filled: true,
          fillColor: color ?? Theme.of(context).cardColor,
          labelText: labelText,
          alignLabelWithHint: false,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)
          ),
          contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 14),
          labelStyle: TextStyle(color: Theme.of(context).primaryTextTheme.bodyText1.color),
          errorBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(color: Colors.red),
        ),
        value: value,
        onChanged: onChanged,
        items: listaOpcoes.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
