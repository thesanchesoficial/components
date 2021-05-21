import 'package:flutter/material.dart';

class OwShortcutCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String group;
  final String value;
  final bool selected;
  final bool down;
  final String tooltipMessage; // ! Finalizar
  final ValueChanged<String> onChanged;

  /* // ! Colocar
  OwShortcutCard({
    this.title,
    this.icon,
    this.group,
    this.value,
    this.onChanged,
    this.selected,
    this.tooltipMessage,
  })  : down = false;
  */

  OwShortcutCard(
    this.title, 
    this.icon,
    {this.group,
    this.value,
    this.onChanged,
    this.selected,
    this.tooltipMessage,
  })  : down = false;

  OwShortcutCard.down(
    this.title, 
    this.icon, 
    {this.group,
    this.value,
    this.onChanged,
    this.selected,
    this.tooltipMessage,
  })  : down = true;

  @override
  Widget build(BuildContext context) {
    bool _selected = selected;
    if(value == null) {
      _selected = _selected ?? group == title;
    } else {
      _selected = _selected ?? group == value;
    }

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: _selected
            ? Theme.of(context).accentColor 
            : Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Center(
          child: title != null && title != ""
            ? Row(
              children: [
                _icon(context, _selected),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: _selected 
                      ? Colors.white 
                      : Theme.of(context).primaryTextTheme.bodyText1.color,
                    fontWeight: FontWeight.w600
                  ),
                ),
                down
                  ? Row(
                    children: [
                      Container(
                        height: 21,
                        width: 1,
                        margin: EdgeInsets.only(left: 8, right: 5),
                        color: _selected 
                          ? Colors.white 
                          : Theme.of(context).primaryTextTheme.bodyText1.color.withOpacity(.4)
                      ),
                      Icon(
                        Icons.keyboard_arrow_down, 
                        size: 21, 
                        color: _selected 
                          ? Colors.white 
                          : Theme.of(context).primaryTextTheme.bodyText1.color
                      )
                    ],
                  )
                  : SizedBox(),
                // Icon(
                //   icone,
                //   size: 17,
                //   color: selecionado == texto ?
                //     Colors.white :
                //     Theme.of(context).primaryTextTheme.bodyText1.color
                // ),
                // texto == "Filtros" ? SizedBox() : SizedBox(width: 10),
                // texto == "Filtros" ? SizedBox() : Text(texto, style: TextStyle(
                //   color: selecionado == texto ?
                //   Colors.white :
                //   Theme.of(context).primaryTextTheme.bodyText1.color,
                //   fontWeight: FontWeight.w500
                // ))
              ],
            )
            : Center(child: _icon(context, _selected)),
        ),
      ),
      onTap: onChanged != null
        ? () {
          if(onChanged != null) {
            if(value != null) {
              onChanged(value);
            } else {
              onChanged(title);
            }
          }
        }
        : null,
    );
  }

  Widget _icon(BuildContext context, bool selected) {
    return Icon(
      icon, 
      size: 21, 
      color: selected 
        ? Colors.white 
        : Theme.of(context).primaryTextTheme.bodyText1.color,
    );
  }
}
