import 'package:flutter/material.dart';

/// [iconeVoltar] = "voltar" (back_ios), "fechar" (close), "" (sem ícone)
class MSAppBar extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String iconeVoltar;
  final Widget leading;
  final double elevation;
  final List<Widget> actions;
  final bool appBarPrimario;
  final Color corFundo;
  final PreferredSizeWidget bottom;

  const MSAppBar({
    Key key,
    this.titulo,
    this.subtitulo,
    this.iconeVoltar = "voltar",
    this.leading,
    this.elevation = 0,
    this.actions,
    this.appBarPrimario = true,
    this.corFundo,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ?? leadingF(context),
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            titulo.toString().toUpperCase(),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          subtitulo != null
            ? Text(
                subtitulo.toString().toUpperCase(),
                style: const TextStyle(fontSize: 13),
              )
            : const SizedBox(),
        ],
      ),
      elevation: elevation,
      actions: actions,
      backgroundColor: corFundo ?? corFundoF(),
      bottom: bottom,
    );
  }

  Widget leadingF(context){
    if(iconeVoltar.toLowerCase() == "voltar"){
      return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).appBarTheme.actionsIconTheme.color,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }else if(iconeVoltar.toLowerCase() == "fechar"){
      return IconButton(
        icon: Icon(
          Icons.close_outlined,
          color: Theme.of(context).appBarTheme.actionsIconTheme.color,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }

    return null;
  }

  Color corFundoF(){
    if(appBarPrimario) return null;
    else return Colors.green;
  }
}