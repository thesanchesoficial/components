import 'package:flutter/material.dart';

class OwActivableIcon extends StatelessWidget {
  final bool activated;
  final IconData activatedIcon;
  final IconData inactivated;
  final VoidCallback onPressed;
  final Color color;

  const OwActivableIcon({
    Key key,
    @required this.activated,
    @required this.onPressed,
    this.activatedIcon = Icons.visibility_outlined,
    this.inactivated = Icons.visibility_off_outlined,
    this.color,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        activated
          ? activatedIcon
          : inactivated,
        color: color ?? Theme.of(context).accentColor,
      ),
    );
  }
}
