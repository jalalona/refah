import 'package:flutter/material.dart';

class WDG_SelectedRadio extends StatelessWidget {
  Color bg;

  WDG_SelectedRadio({
    this.bg,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(6.0, 6.0)),
        color: bg ?? Color(0xffffffff),
        border: Border.all(width: 1.0, color: const Color(0xff6e78f7)),
      ),
    );
  }
}
