import 'package:flutter/material.dart';

class OwIcon extends StatelessWidget {
  final String message;
  final Function onPressed;
  final IconData icon;
  final Color color;
  final double size;
  final bool button;

  const OwIcon(
    this.icon, 
    {Key key,
    this.color, 
    this.size, 
    this.message = "",
  })  : onPressed = null, 
        button = false;

  const OwIcon.button(
    this.icon, 
    this.color, 
    this.size, 
    this.onPressed, 
    {Key key,
    this.message = "",
  })  : button = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: key,
      message: message,
      child: button 
      ? IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: size,
            semanticLabel: message,
          ),
        )
      : Icon(
          icon,
          color: color,
          size: size,
          semanticLabel: message,
        ),
    );
  }
}
