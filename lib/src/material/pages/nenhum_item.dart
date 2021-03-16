import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NenhumItem extends StatefulWidget {
  final String titulo;
  final String subtitulo;
  final String imagem;
  NenhumItem({@required this.titulo, @required this.subtitulo, this.imagem});

  @override
  _NenhumItemState createState() => _NenhumItemState();
}

class _NenhumItemState extends State<NenhumItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          widget.imagem == null ? SizedBox() : SvgPicture.asset(widget.imagem, height: 250),
          widget.imagem == null ? SizedBox() : SizedBox(height: 20),
          Text(
            widget.titulo,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              widget.subtitulo,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
