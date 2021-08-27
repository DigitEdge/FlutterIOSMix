import 'package:flutter/material.dart';

class OnePage extends StatelessWidget {
  VoidCallback callback1;
  VoidCallback callback2;

  OnePage(this.callback1, this.callback2);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        GestureDetector(
          onTap: callback1,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.cyan,
          ),
        ),
        GestureDetector(
          onTap: callback2,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
          ),
        ),
      ]),
    );
  }
}
