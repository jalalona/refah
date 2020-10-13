import 'package:flutter/material.dart';

class WDG_Component511 extends StatelessWidget {
  WDG_Component511({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(6.0, 6.0),
          child: SizedBox(
            width: 201.0,
            height: 67.0,
            child: Text(
              'دستشون درد نکنه . خدا خیرش بده',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: const Color(0xff898a8f),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Container(
          width: 212.0,
          height: 78.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 0.5, color: const Color(0xffececec)),
          ),
        ),
      ],
    );
  }
}
