import 'package:flutter/material.dart';

class OwGenericButton extends StatelessWidget { // ! Talvez deixar como OwButton.generic(); / Adicionar um label
  final Widget child;
  final void Function() onTap;
  final MouseCursor mouseCursor;
  final bool canRequestFocus;
  final bool autofocus;
  final BorderRadius borderRadius;
  final ShapeBorder customBorder;
  final void Function() onDoubleTap;
  final void Function() onTapCancel;
  final void Function() onLongPress;
  final void Function(bool) onHover;
  final void Function(bool) onFocusChange;
  final void Function(bool) onHighlightChanged;
  final void Function(TapDownDetails) onTapDown;
  final bool enableFeedback;
  final Color hoverColor;
  final Color focusColor;
  final Color highlightColor;
  final Color overlayColor;
  final Color splashColor;
  final FocusNode focusNode;
  final double radius;
  final bool excludeFromSemantics;
  final InteractiveInkFeatureFactory splashFactory;
  const OwGenericButton({
    Key key,
    @required this.child,
    this.onTap,
    this.mouseCursor,
    this.borderRadius,
    this.customBorder,
    this.onDoubleTap,
    this.onHover,
    this.onTapCancel,
    this.onLongPress,
    this.onFocusChange,
    this.onTapDown,
    this.onHighlightChanged,
    this.hoverColor,
    this.focusColor,
    this.highlightColor,
    this.overlayColor,
    this.splashColor,
    this.focusNode,
    this.radius,
    this.splashFactory,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: child,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onTapCancel: onTapCancel,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onHover: onHover,
          onHighlightChanged: onHighlightChanged,
          onFocusChange: onFocusChange,
          hoverColor: hoverColor,
          mouseCursor: mouseCursor,
          canRequestFocus: canRequestFocus,
          autofocus: autofocus,
          borderRadius: borderRadius,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          focusColor: focusColor,
          focusNode: focusNode,
          radius: radius,
          highlightColor: highlightColor,
          excludeFromSemantics: excludeFromSemantics,
          overlayColor: MaterialStateProperty.all(overlayColor),
          splashColor: splashColor,
          splashFactory: splashFactory,
        ),
      ],
    );
  }
}
