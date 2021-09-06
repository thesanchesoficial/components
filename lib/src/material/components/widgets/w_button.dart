
import 'package:flutter/material.dart';

class OwButton extends StatelessWidget { // ! Testar opção de enviar ícone / Colocar um bool isStretch retornando o botão em um Column(stretch)
  final String labelText;
  final bool autoFocus;
  final bool enable;
  final bool outline;
  final bool secondary;
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
  final FocusNode focusNode;
  final bool absorbedPointer;
  final bool ignoredPointer;

  OwButton({
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
    this.minimumSize,
    this.textStyle,
    this.leading,
    this.trailing,
    this.focusNode,
    this.absorbedPointer = false,
    this.ignoredPointer = false,
  }): assert(!ignoredPointer || !absorbedPointer),
      outline = false,
      mainButton = true,
      secondary = false,
      color = null,
      super(key: key);

  OwButton.secondary({
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
    this.minimumSize,
    this.textStyle,
    this.leading,
    this.trailing,
    this.focusNode,
    this.absorbedPointer = false,
    this.ignoredPointer = false,
  }): assert(!ignoredPointer || !absorbedPointer),
      outline = false,
      mainButton = false,
      secondary = true,
      super(key: key);

  const OwButton.outline({
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
    this.minimumSize,
    this.textStyle,
    this.leading,
    this.trailing,
    this.focusNode,
    this.absorbedPointer = false,
    this.ignoredPointer = false,
  }): assert(!ignoredPointer || !absorbedPointer),
      outline = true,
      mainButton = false,
      secondary = false,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return ignoredPointer
      ? IgnorePointer(
        child: _button(context),
      )
      : absorbedPointer
        ? AbsorbPointer(
          child: _button(context),
        )
        : _button(context);
  }

  Widget _button(BuildContext context) {
    return Container(
      key: key,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: Colors.transparent,
      ),
      child: ElevatedButton(
        autofocus: autoFocus,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leading != null
                ? Container(
                    margin: EdgeInsets.only(
                      right: 20,
                    ),
                    child: Icon(leading),
                  )
                : SizedBox(),
              labelText != null && labelText.isNotEmpty
                ? Expanded(
                    child: Text(
                      labelText.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Expanded(
                  child: _getChild(),
                ),
              trailing != null
                ? Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Icon(trailing),
                  )
                : SizedBox(),
            ],
          ),
        ),
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
              : secondary
                ? Theme.of(context).cardColor.withOpacity(.6)
                : color ?? Theme.of(context).accentColor,
          ),
          elevation: MaterialStateProperty.all(elevation),
          minimumSize: MaterialStateProperty.all(minimumSize),
          textStyle: MaterialStateProperty.all(textStyle),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: color ?? Theme.of(context).accentColor),
            ),
          ),
          enableFeedback: enableFeedback,
        ),
        onPressed: enable ? onPressed : null,
        onLongPress: enable ? onLongPressed : null,
        focusNode: focusNode,
      ),
    );
  }

  Widget _getChild() {
    if(leading != null || trailing != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading != null
            ? Icon(leading)
            : const SizedBox(),
          child,
          trailing != null
            ? Icon(trailing)
            : const SizedBox(),
        ],
      );
    } else {
      return child;
    }
  }
}
