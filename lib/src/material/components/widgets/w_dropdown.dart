import 'package:components_venver/src/settings/init.dart';
import 'package:components_venver/src/utils/helpers/dorpdown_type.dart';
import 'package:components_venver/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OwDropdown extends StatelessWidget { // ! Adicionar autoFocus (lista de focusNode)
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
  final Widget hint;
  final String hintText;
  final DropdownType dropdownType;

  static const Color errorColor = Colors.red;
  static const String assertMsgOptionsAndType = "'dropdownType' already define a 'optionsList'";

  OwDropdown({
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
    this.hint,
    this.hintText,
    this.dropdownType,
  }): assert(optionsList == null || dropdownType == null, assertMsgOptionsAndType),
      isExpanded = false,
      super(key: key);

  OwDropdown.withExpanded({
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
    this.hint,
    this.hintText,
    this.dropdownType,
  }): assert(optionsList == null || dropdownType == null, assertMsgOptionsAndType),
      isExpanded = true,
      super(key: key);

  List<String> _optionsList;

  @override
  Widget build(BuildContext context) {
    _optionsList = optionsList;
    changeDropdownType(context);

    return Container(
      key: key,
      margin: margin,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        isExpanded: isExpanded,
        disabledHint: disabledHint,
        hint: hint ?? 
          hintText != null 
            ? Text(hintText)
            : null,
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
            borderSide: BorderSide(color: AppTheme.errorColor ?? errorColor),
          ),
          errorStyle: TextStyle(color: AppTheme.errorColor ?? errorColor),
        ),
        value: value,
        onChanged: enabled
          ? onChanged
          : null,
        items: _optionsList?.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })?.toList(),
      ),
    );
  }

  void changeDropdownType(BuildContext context) {
    if(dropdownType != null) {
      bool removeSomeItems = false;

      switch (dropdownType.type) {
        case EDropdownType.bankAccountType:
          _optionsList = StandardConfig.bankAccountTypes;
          break;
        
        case EDropdownType.genders:
          _optionsList = StandardConfig.genders;
          removeSomeItems = true;
          break;
        
        case EDropdownType.integer:
          _optionsList = [];
          for(int i = dropdownType.min; i <= dropdownType.max; i += dropdownType.step) {
            _optionsList.add("$i");
          }
          break;
        
        case EDropdownType.decimal:
          _optionsList = [];
          for(double i = dropdownType.min; i <= dropdownType.max; i += dropdownType.step) {
            _optionsList.add("${(i).toStringAsFixed(dropdownType.places)}");
          }
          break;
        
        case EDropdownType.months:
          _optionsList = StandardConfig.months;
          removeSomeItems = true;
          break;
        
        case EDropdownType.weekDays:
          _optionsList = StandardConfig.weekDays;
          removeSomeItems = true;
          break;
      }

      if(removeSomeItems) {
        for(int i = 0; i < dropdownType.activatedItemsList.length; i++) {
          if(!dropdownType.activatedItemsList[i]) {
            _optionsList.removeAt(i);
          }
        }
      }
    }
  }
}
