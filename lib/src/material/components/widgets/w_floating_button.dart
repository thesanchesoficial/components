import 'package:components_venver/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OwFloatingButton extends StatelessWidget {
  final Color backgroundColor;
  final Function onPressed;
  final Widget child;
  final double elevation;
  final String tooltip;
  final Color splashColor;
  final Color foregroundColor;
  final bool isExtended;
  final ShapeBorder shape;
  final bool autofocus;
  final FocusNode focusNode;
  final MouseCursor mouseCursor;
  final Widget iconLabel;
  final String textLabel;
  final bool buttonOnRight;
  final bool useAddIcon;

  OwFloatingButton({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.child,
    this.elevation,
    this.tooltip,
    this.splashColor,
    this.foregroundColor,
    this.shape,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
    this.textLabel,
    this.useAddIcon = false,
    this.iconLabel,
  })  : isExtended = textLabel != null,
        buttonOnRight = null,
        super(key: key);

  OwFloatingButton.left({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.child,
    this.elevation,
    this.tooltip,
    this.splashColor,
    this.foregroundColor,
    this.shape,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
    this.textLabel,
    this.useAddIcon = false,
    this.iconLabel,
  })  : buttonOnRight = false,
        isExtended = textLabel != null,
        super(key: key);

  OwFloatingButton.right({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.child,
    this.elevation,
    this.tooltip,
    this.splashColor,
    this.foregroundColor,
    this.shape,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
    this.textLabel,
    this.useAddIcon = false,
    this.iconLabel,
  })  : buttonOnRight = true,
        isExtended = textLabel != null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExtended
      ? FloatingActionButton.extended(
        key: key,
        onPressed: onPressed,
        autofocus: autofocus,
        backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
        elevation: elevation,
        focusNode: focusNode,
        shape: shape,
        tooltip: tooltip ?? textLabel,
        mouseCursor: mouseCursor,
        splashColor: splashColor,
        isExtended: isExtended,
        foregroundColor: foregroundColor ?? Colors.white,
        label: _label(),
        icon: buttonOnRight == false 
          ? _icon() 
          : null,
      )
      : FloatingActionButton(
        key: key,
        onPressed: onPressed,
        autofocus: autofocus,
        backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
        child: child ?? _icon(),
        elevation: elevation,
        focusNode: focusNode,
        shape: shape,
        tooltip: tooltip,
        mouseCursor: mouseCursor,
        splashColor: splashColor,
        isExtended: isExtended,
        foregroundColor: foregroundColor ?? Colors.white,
      );
  }

  Widget _label() {
    return Row(
      children: buttonOnRight == false
        ? [
          Text(textLabel),
        ]
        : [
          Text(textLabel),
          const SizedBox(width: 10),
          _icon(),
        ],
    );
  }

  Widget _icon() {
    return iconLabel ?? useAddIcon || buttonOnRight == null
      ? const Icon(Icons.add, size: 25) 
      : Icon(
        !buttonOnRight
          ? Icons.arrow_back_outlined
          : Icons.arrow_forward_outlined, 
        size: 25,
      );
  }
}
