import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class OcorreuUmErro extends StatefulWidget {
  @override
  _OcorreuUmErroState createState() => _OcorreuUmErroState();
}

class _OcorreuUmErroState extends State<OcorreuUmErro> {
  bool result = false;

  verificarInternet() async {
    result = await DataConnectionChecker().hasConnection;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    verificarInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 20),
            Image.asset('assets/images/comentarios.png', height: 230),
            SizedBox(height: 20),
            Text(
              result 
                ? "Ops... não conseguimos chegar no servidor"
                : "Parece que você tá sem internet",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                "Tente novamente em instantes",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}