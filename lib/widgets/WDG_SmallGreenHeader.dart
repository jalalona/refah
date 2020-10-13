import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_SmallGreenHeader extends StatelessWidget {
  WDG_SmallGreenHeader({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SvgPicture.string(
          _svg_g3rbh,
          allowDrawingOutsideViewBox: true,
        ),
      ],
    );
  }
}

const String _svg_g3rbh =
    '<svg viewBox="0.0 0.0 375.0 106.0" ><path transform="translate(0.03, -28.0)" d="M 375.0154418945313 28 L 375 110 C 375 123.2548370361328 364.2548217773438 134 351 134 L 24 134 C 10.74516487121582 134 0 123.2548370361328 0 110 L -0.02557373046875 28.000244140625 L 375.0154418945313 28 Z" fill="#1fac9c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
