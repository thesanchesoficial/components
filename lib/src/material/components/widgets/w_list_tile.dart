import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OwListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Widget leading;
  final Widget icon;
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
  final bool showArrow;
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
    this.showArrow = false,
    this.onTap,
    this.onLongPress,
    this.enabled = false,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
  }) : onChanged = null, value = false, icon = null, super(key: key);

  OwListTile.check({
    Key key,
    this.title,
    this.subtitle,
    this.leading,
    this.padding,
    this.margin,
    this.shape,
    this.selected = false,
    this.showArrow = false,
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
  ), icon = null, super(key: key);

  OwListTile.icon({
    Key key,
    this.title,
    this.subtitle,
    this.padding,
    @required this.icon,
    this.margin,
    this.shape,
    this.selected = false,
    this.showArrow = false,
    this.onTap,
    this.onLongPress,
    this.enabled = false,
    this.autofocus = false,
    this.focusNode,
    this.trailing,
    this.mouseCursor,
  }) : 
    onChanged = null, 
    value = null, 
    leading = Container(
      width: 40,
      child: Center(
        child: icon,
      ),
    ),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
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
        trailing: trailing != null ? trailing : showArrow ? Icon(Icons.keyboard_arrow_right_outlined) : null,
        leading: leading,
        shape: shape,
        focusNode: focusNode,
        selected: selected,
        mouseCursor: mouseCursor,
      ),
    );
  }
}