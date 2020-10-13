import 'package:flutter/material.dart';

class WDG_BackgroundGreen extends StatelessWidget {
  WDG_BackgroundGreen({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Adobe XD layer: 'as' (shape)
        Container(
          width: 375.0,
          height: 812.0,
          decoration: BoxDecoration(
            color: const Color(0xff1fac9c),
          ),
        ),
      ],
    );
  }
}
