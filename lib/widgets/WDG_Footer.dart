import 'package:flutter/material.dart';

class WDG_Footer extends StatelessWidget {
  WDG_Footer({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 375.0,
          height: 24.0,
          decoration: BoxDecoration(),
        ),
        Transform.translate(
          offset: Offset(125.0, 10.0),
          child: Container(
            width: 118.0,
            height: 4.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: const Color(0xfff0f0f3),
            ),
          ),
        ),
      ],
    );
  }
}
