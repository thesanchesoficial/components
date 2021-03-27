import 'package:components_venver/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OwTwoFloatingButtons extends StatelessWidget {
  final Function onPressedLeft;
  final Function onPressedRight;
  final String tooltipLeft;
  final String tooltipRight;
  final MouseCursor mouseCursorLeft;
  final MouseCursor mouseCursorRight;
  final String textLeft;
  final String textRight;
  final bool isExtendedLeft;
  final bool isExtendedRight;
  final double elevation;
  final Color splashColor;
  final Color foregroundColor;
  final Color backgroundColor;
  final ShapeBorder shape;
  // final bool autofocus;
  // final FocusNode focusNode;

  final String typeButton;


  // ! Global
  final String backTextFloatingButton = "Voltar";
  final String nextTextFloatingButton = "Avançar";
  final String addTextFloatingButton = "Adicionar";
  

  OwTwoFloatingButtons({ // Add extended
    Key key,
    this.onPressedLeft,
    this.onPressedRight,
    this.tooltipLeft,
    this.tooltipRight,
    this.mouseCursorLeft,
    this.mouseCursorRight,
    this.textLeft,
    this.textRight,
    this.backgroundColor,
    this.elevation,
    this.splashColor,
    this.foregroundColor,
    this.shape,
  })  : isExtendedLeft = textLeft != null,
        isExtendedRight = textRight != null,
        typeButton = null,
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          isExtendedLeft
            ? FloatingActionButton.extended(
              backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
              onPressed: onPressedLeft,
              isExtended: isExtendedLeft,
              elevation: elevation,
              splashColor: splashColor,
              foregroundColor: foregroundColor,
              shape: shape,
              tooltip: tooltipLeft ?? textLeft,
              label: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_outlined, 
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(textLeft),
                ],
              ),
            )
            : FloatingActionButton(
              backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
              onPressed: onPressedLeft,
              isExtended: isExtendedLeft,
              elevation: elevation,
              splashColor: splashColor,
              foregroundColor: foregroundColor,
              tooltip: tooltipLeft,
              shape: shape,
              child: const Icon(
                Icons.arrow_back_outlined, 
                size: 25,
              ),
            ),
          const SizedBox(width: 40),
          isExtendedRight
            ? FloatingActionButton.extended(
              backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
              onPressed: onPressedRight,
              isExtended: isExtendedRight,
              elevation: elevation,
              splashColor: splashColor,
              foregroundColor: foregroundColor,
              tooltip: tooltipRight ?? textRight,
              shape: shape,
              label: Row(
                children: [
                  Text(textRight),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_outlined, 
                    size: 25,
                  ),
                ],
              ),
            ) 
            : FloatingActionButton(
              backgroundColor: backgroundColor ?? AppTheme.verdeVenver,
              onPressed: onPressedRight,
              isExtended: isExtendedRight,
              elevation: elevation,
              splashColor: splashColor,
              foregroundColor: foregroundColor,
              tooltip: tooltipRight,
              shape: shape,
              child: const Icon(
                Icons.arrow_forward_outlined, 
                size: 25,
              ),
            ),
        ],
      ),
    );
  }
}
