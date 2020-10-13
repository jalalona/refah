import 'package:flutter/material.dart';

class WDG_RichInput extends StatelessWidget {
  bool enabled;
  bool isRequired;
  int min;
  int max;

  WDG_RichInput({
    this.enabled,
    this.isRequired,
    this.max,
    this.min,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 325.0,
          height: 190.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: const Color(0xfff6f6f6),
            border: Border.all(width: 1.0, color: const Color(0xffd6d6d6)),
          ),
        ),
        Transform.translate(
          offset: Offset(16.0, 11.0),
          child: SizedBox(
            width: 294.0,
            height: 162.0,
            child: Text(
              'محتوا',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: const Color(0xff898a8f),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
