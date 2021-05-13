import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

enum IconType {
  visiblePassword,
  search,
  sendChat,
}

// ignore: must_be_immutable
class OwActivableIcon extends StatelessWidget {
  final bool activated;
  final IconData activatedIcon;
  final IconData inactivatedIcon;
  final VoidCallback onPressed;
  final VoidCallback onPressedInactive;
  final Color iconColor;
  final IconType iconType;
  final TextEditingController controller;

  OwActivableIcon({
    Key key,
    @required this.onPressed,
    @required this.activatedIcon,
    @required this.inactivatedIcon,
    this.onPressedInactive,
    this.activated = true,
    this.iconColor,
  }): this.controller = null,
      this.iconType = null,
      super(key: key);
  
  OwActivableIcon.type({
    Key key,
    @required this.iconType,
    this.activated,
    this.controller,
    this.onPressedInactive,
    this.onPressed,
    this.activatedIcon,
    this.inactivatedIcon,
    this.iconColor,
  }): super(key: key);

  IconData _activatedIcon;
  IconData _inactivatedIcon;
  
  @override
  Widget build(BuildContext context) {
    assertValidate();
    defineIcons();
    
    return IconButton(
      onPressed: activated
        ? onPressed
        : onPressedInactive,
      icon: Icon(
        activated
          ? activatedIcon ?? _activatedIcon
          : inactivatedIcon ?? _inactivatedIcon,
        color: iconColor ?? Theme.of(context).accentColor,
      ),
    );
  }

  void assertValidate() {
    switch (iconType) {
      case IconType.search:
        assert(controller != null);
        break;
      case IconType.sendChat:
        break;
      case IconType.visiblePassword:
        assert(activated != null);
        break;
    }
  }

  void defineIcons() {
    switch (iconType) {
      case IconType.search:
        _activatedIcon = Icons.search_outlined;
        _inactivatedIcon = Icons.close_outlined;
        break;
      case IconType.sendChat:
        _activatedIcon = EvaIcons.paperPlaneOutline;
        break;
      case IconType.visiblePassword:
        _activatedIcon = Icons.visibility_outlined;
        _inactivatedIcon = Icons.visibility_off_outlined;
        break;
    }
  }
}
