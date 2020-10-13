import 'package:flutter/material.dart';

class WDG_UnselectedRadio extends StatelessWidget {
  WDG_UnselectedRadio({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(6.0, 6.0)),
            color: const Color(0xffffffff),
            border: Border.all(width: 1.0, color: const Color(0xff6e78f7)),
          ),
        ),
      ],
    );
  }
}
