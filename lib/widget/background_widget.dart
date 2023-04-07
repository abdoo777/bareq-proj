import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {

  Widget widget;


  BackgroundWidget(this.widget);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                opacity: 0.2,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/logo.png"))
          ),
        ),
        widget,

      ],
    );
  }
}
