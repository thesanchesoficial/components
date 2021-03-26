import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OwListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Widget leading;
  final EdgeInsetsGeometry padding;
  final EdgeInsets margin;
  final ShapeBorder shape;
  final bool selected;
  final Function onTap;
  final Function onLongPress;
  final Function onChanged;
  final bool enabled;
  final bool autofocus;
  final bool value;
  final FocusNode focusNode;
  final MouseCursor mouseCursor;

  OwListTile({
    Key key,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.padding,
    this.margin,
    this.shape,
    this.selected = false,
    this.onTap,
    this.onLongPress,
    this.enabled = false,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
  }) : onChanged = null, value = false, super(key: key);

  OwListTile.check({
    Key key,
    this.title,
    this.subtitle,
    this.leading,
    this.padding,
    this.margin,
    this.shape,
    this.selected = false,
    this.onTap,
    this.onLongPress,
    this.enabled = false,
    @required this.value,
    @required this.onChanged,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
  }) : trailing = CupertinoSwitch(
    value: value, 
    onChanged: onChanged,
  ), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        autofocus: autofocus,
        contentPadding: padding,
        enabled: enabled,
        onLongPress: onLongPress,
        onTap: onTap,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        leading: leading,
        shape: shape,
        focusNode: focusNode,
        selected: selected,
        mouseCursor: mouseCursor,
      ),
    );
  }
}