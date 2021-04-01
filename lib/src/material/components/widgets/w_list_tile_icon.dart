import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class OwListTileIcon extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget page;
  final Function onTap;

  const OwListTileIcon({
    Key key,
    this.title,
    this.icon,
    this.page,
    this.onTap,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      onTap: () async {
        if(onTap != null) {
          onTap();
        }
        if(page != null) {
          // openLink(context, page); // ! Terminar
        }
      },
      title: Text(
        title, 
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 3, 
        horizontal: 20,
      ),
      trailing: Icon(
        EvaIcons.chevronRightOutline,
      ),
      leading: Container(
        width: 40,
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
