import 'package:components_venver/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MSButton extends StatelessWidget {
  final String labelText;
  final bool autoFocus;
  final bool enable;
  final bool outline;
  final bool principal;
  final bool enableFeedback;
  final Function onPressed;
  final Function onLongPressed;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final Color foregroundColor;
  final Widget child;
  final double elevation;
  final double radius;
  final double height;
  final Size size;
  final TextStyle textStyle;
  final IconData leading;
  final IconData trailing;

  MSButton({
    Key key,
    this.labelText,
    this.autoFocus = false,
    this.enable = true,
    this.enableFeedback = false,
    this.onPressed,
    this.onLongPressed,
    this.margin,
    this.foregroundColor,
    this.padding,
    this.child,
    this.elevation = 0,
    this.radius = 10,
    this.height = 60,
    this.size,
    this.textStyle,
    this.leading,
    this.trailing,
  }) : outline = false, principal = true, color = AppTheme.verdeVenver ?? Colors.green, super(key: key);

  MSButton.secondary({
    Key key,
    this.labelText,
    this.autoFocus = false,
    this.enable = true,
    this.enableFeedback = false,
    this.onPressed,
    this.onLongPressed,
    this.margin,
    this.padding,
    this.foregroundColor,
    this.color,
    this.child,
    this.elevation = 0,
    this.radius = 10,
    this.height = 60,
    this.size,
    this.textStyle,
    this.leading,
    this.trailing,
  }) : outline = false, principal = false, super(key: key);

  const MSButton.outline({
    Key key,
    this.labelText,
    this.autoFocus = false,
    this.enable = true,
    this.enableFeedback = false,
    this.onPressed,
    this.onLongPressed,
    this.margin,
    this.padding,
    this.color,
    this.foregroundColor,
    this.child,
    this.elevation = 0,
    this.radius = 10,
    this.height = 60,
    this.size,
    this.textStyle,
    this.leading,
    this.trailing,
  }) : outline = true, principal = false, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: Colors.transparent
      ),
      child: ElevatedButton(
        autofocus: autoFocus,
        child: labelText != null && labelText.isNotEmpty
          ? Text(labelText.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)) 
          : child,
        style: ButtonStyle(
          foregroundColor: principal ? MaterialStateProperty.all(Colors.white) : MaterialStateProperty.all(foregroundColor ?? color ?? Colors.green),
          padding: MaterialStateProperty.all(padding),
          backgroundColor: MaterialStateProperty.all(outline ? Colors.transparent : color ?? Colors.green),
          elevation: MaterialStateProperty.all(elevation),
          minimumSize: MaterialStateProperty.all(size),
          textStyle: MaterialStateProperty.all(textStyle),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: color ?? AppTheme.verdeVenver ?? Colors.green),
            ), 
          ),
          enableFeedback: enableFeedback
        ),
        onPressed: enable ? onPressed : null,
        onLongPress: enable ? onLongPressed : null,
      ),
    );
  }
}
