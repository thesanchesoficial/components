import 'package:flutter/material.dart';

class OwAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final Widget child;
  final String title;
  final String subtitle;
  final Widget leading;
  final double elevation;
  final List<Widget> actions;
  final Color color;
  final PreferredSizeWidget bottom;
  final bool centerTitle;

  const OwAppBar({
    Key key,
    this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.bottom,
    this.color,
    this.centerTitle = true,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      centerTitle: centerTitle,
      title: child ??
        title == null ? null : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title.toString().toUpperCase(),
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            subtitle != null
              ? Text(
                  subtitle.toString().toUpperCase(),
                  style: const TextStyle(fontSize: 13),
                )
              : const SizedBox(),
          ],
        ),
      elevation: elevation,
      actions: actions,
      backgroundColor: color ?? Theme.of(context).accentColor,
      bottom: bottom,
    );
  }
}
