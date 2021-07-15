import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

enum IconType {
  visiblePassword,
  search,
  sendChat,
  erasableText,
  // datePicker, // ! Inserir
}

// ignore: must_be_immutable
class OwActivableIcon extends StatelessWidget { // ! Adicionar ícone de X pra limpar texto (como no 'CPF / CNPJ na nota' do carrinho)
  final bool activated;
  final IconData activatedIcon;
  final IconData inactivatedIcon;
  final VoidCallback onPressed;
  final VoidCallback onPressedInactive;
  final Color iconColor;
  final IconType iconType;
  final TextEditingController controller;
  final bool hideInactivatedIcon;

  OwActivableIcon({
    Key key,
    @required this.onPressed,
    @required this.activatedIcon,
    @required this.inactivatedIcon,
    this.onPressedInactive,
    this.activated = true,
    this.iconColor,
    this.hideInactivatedIcon = false,
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
    this.hideInactivatedIcon = false,
  }): super(key: key);

  IconData _activatedIcon;
  IconData _inactivatedIcon;
  bool _activated;
  bool _hideInactivatedIcon;
  
  @override
  Widget build(BuildContext context) {
    defineIcons();
    
    return IconButton(
      onPressed: activated ?? _activated
        ? onPressed
        : onPressedInactive,
      icon: (hideInactivatedIcon && _hideInactivatedIcon) && !(activated ?? _activated) // ! Testar
        ? Icon(
          activated ?? _activated
            ? activatedIcon ?? _activatedIcon
            : inactivatedIcon ?? _inactivatedIcon,
          color: iconColor ?? Theme.of(context).accentColor,
        )
        : const SizedBox(),
    );
  }

  void defineIcons() {
    assertValidate();
    switch (iconType) {
      case IconType.search:
        _activated = controller.text.isNotEmpty;
        _hideInactivatedIcon = _activated;
        _activatedIcon = Icons.search_outlined;
        _inactivatedIcon = Icons.close_outlined;
        break;
      case IconType.sendChat:
        _activated = controller.text.isNotEmpty;
        _hideInactivatedIcon = _activated;
        _activatedIcon = EvaIcons.paperPlaneOutline;
        break;
      case IconType.visiblePassword:
        _activatedIcon = Icons.visibility_outlined;
        _inactivatedIcon = Icons.visibility_off_outlined;
        break;
      case IconType.erasableText: // ! Terminar
        _activated = controller.text.isNotEmpty;
        _hideInactivatedIcon = _activated;
        _activatedIcon = Icons.cancel;
        // _inactivatedIcon = Icons.visibility_off_outlined; // ?
        break;
      // case IconType.datePicker: // ! Terminar
      //   break;
    }
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
      case IconType.erasableText:
        assert(activated != null);
        break;
      // case IconType.datePicker:
      //   break;
    }
  }
}
