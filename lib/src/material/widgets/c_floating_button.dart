import 'package:components_venver/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  final bool back;
  final bool next;
  final bool two;

  OwFloatingButton({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.child,
    this.elevation,
    this.tooltip,
    this.splashColor,
    this.foregroundColor,
    this.isExtended,
    this.shape,
    this.autofocus,
    this.focusNode,
    this.mouseCursor,
  }) : back = false, next = false, two = false, super(key: key);

  OwFloatingButton.back({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.child,
    this.elevation,
    this.tooltip,
    this.splashColor,
    this.foregroundColor,
    this.isExtended,
    this.shape,
    this.autofocus,
    this.focusNode,
    this.mouseCursor,
  }) : back = true, next = false, two = false, super(key: key);

  OwFloatingButton.next({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.child,
    this.elevation,
    this.tooltip,
    this.splashColor,
    this.foregroundColor,
    this.isExtended,
    this.shape,
    this.autofocus,
    this.focusNode,
    this.mouseCursor,
  }) : back = false, next = true, two = false, super(key: key);

  OwFloatingButton.twoButton({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.child,
    this.elevation,
    this.tooltip,
    this.splashColor,
    this.foregroundColor,
    this.isExtended,
    this.shape,
    this.autofocus,
    this.focusNode,
    this.mouseCursor,
  }) : back = false, next = false, two = true, super(key: key);

  @override
  Widget build(BuildContext context) {
    if(two) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
              heroTag: tooltip ?? "Adicionar",
              tooltip: tooltip ?? "Adicionar",
              onPressed: () {},
              child: Icon(Icons.arrow_back_outlined),
            ),
            SizedBox(width: 40),
            FloatingActionButton(
              backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
              heroTag: tooltip ?? "Adicionar",
              tooltip: tooltip ?? "Adicionar",
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Avançar"),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_outlined),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return FloatingActionButton(
        key: key,
        onPressed: onPressed,
        autofocus: autofocus,
        backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
        child: child ?? next ? Icon(Icons.arrow_forward_outlined) : back ? Icon(Icons.arrow_back_outlined) : Icon(Icons.add),
        elevation: elevation,
        focusNode: focusNode,
        shape: shape,
        tooltip: tooltip ?? next ? "Avançar" : back ? "Voltar" : "Adicionar" ,
        mouseCursor: mouseCursor,
        splashColor: splashColor,
        isExtended: isExtended,
        foregroundColor: foregroundColor ?? Colors.white
      );
    }
  }
}
