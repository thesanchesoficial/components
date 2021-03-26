import 'package:flutter/material.dart';

class OwShortcut extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Function onTap;
  final Function onLongPress;

  OwShortcut({
    this.title, 
    this.icon, 
    this.onTap, 
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: selected 
            ? Theme.of(context).accentColor 
            : Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(right: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon, 
              size: 21, 
              color: selected
                ? Colors.white 
                : Theme.of(context).primaryTextTheme.bodyText1.color,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: selected 
                  ? Colors.white 
                  : Theme.of(context).primaryTextTheme.bodyText1.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}