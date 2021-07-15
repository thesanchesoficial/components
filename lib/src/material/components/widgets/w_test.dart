import 'package:flutter/material.dart';

class OwTests extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // ! Widget with a defined hole
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://www.estudokids.com.br/wp-content/uploads/2020/02/o-que-e-paisagem-1200x675.jpg',
          fit: BoxFit.cover,
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOut), // This one will create the magic
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.red,
              //     backgroundBlendMode: BlendMode.dstOut), // This one will handle background + difference out
              // ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 80),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Hello World',
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}