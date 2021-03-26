import 'package:components_venver/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OwButton extends StatelessWidget {
  final String labelText;
  final bool autoFocus;
  final bool enable;
  final bool outline;
  final bool hideRadius;
  final bool mainButton;
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
  final Size minimumSize;
  final TextStyle textStyle;
  final IconData leading;
  final IconData trailing;

  OwButton({
    Key key,
    this.labelText,
    this.autoFocus = false,
    this.hideRadius = false,
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
    this.minimumSize,
    this.textStyle,
    this.leading,
    this.trailing,
  })  : outline = false,
        mainButton = true,
        color = AppTheme.verdeVenver,
        super(key: key);

  OwButton.secondary({
    Key key,
    this.labelText,
    this.autoFocus = false,
    this.hideRadius = false,
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
    this.minimumSize,
    this.textStyle,
    this.leading,
    this.trailing,
  })  : outline = false,
        mainButton = false,
        super(key: key);

  const OwButton.outline({
    Key key,
    this.labelText,
    this.autoFocus = false,
    this.hideRadius = false,
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
    this.minimumSize,
    this.textStyle,
    this.leading,
    this.trailing,
  })  : outline = true,
        mainButton = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(
          hideRadius ? 0 : radius,
        )),
        color: Colors.transparent,
      ),
      child: ElevatedButton(
        autofocus: autoFocus,
        child: labelText != null && labelText.isNotEmpty
          ? Text(
            labelText.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
          : child,
        style: ButtonStyle(
          foregroundColor: mainButton
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(
              foregroundColor ?? color ?? Theme.of(context).accentColor,
            ),
          padding: MaterialStateProperty.all(padding),
          backgroundColor: MaterialStateProperty.all(
            outline 
              ? Colors.transparent 
              : color ?? AppTheme.verdeVenver,
          ),
          elevation: MaterialStateProperty.all(elevation),
          minimumSize: MaterialStateProperty.all(minimumSize),
          textStyle: MaterialStateProperty.all(textStyle),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: color ?? AppTheme.verdeVenver),
            ),
          ),
          enableFeedback: enableFeedback,
        ),
        onPressed: enable ? onPressed : null,
        onLongPress: enable ? onLongPressed : null,
      ),
    );
  }
}
