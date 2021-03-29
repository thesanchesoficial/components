import 'package:components_venver/theme/app_theme.dart';
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
  final Color foregroundColor;
  final PreferredSizeWidget bottom;
  final bool centerTitle;
  final bool showBackButtonAutomatically;

  const OwAppBar({
    Key key,
    this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.bottom,
    this.color,
    this.foregroundColor,
    this.centerTitle = true,
    this.showBackButtonAutomatically = true,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      leading: leading,
      centerTitle: centerTitle,
      automaticallyImplyLeading: showBackButtonAutomatically,
      title: child ?? title == null 
        ? null 
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 15, 
                fontWeight: FontWeight.w500, 
                color: Colors.white,
              ),
            ),
            subtitle != null
              ? Text(
                subtitle.toUpperCase(),
                style: TextStyle(
                  fontSize: 13, 
                  color: Colors.grey[200],
                ),
              )
              : const SizedBox(),
          ],
        ),
      elevation: elevation,
      actions: actions,
      backgroundColor: color ?? AppTheme.verdeVenver,
      bottom: bottom,
      foregroundColor: foregroundColor ?? Colors.white,
    );
  }
}
