import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_OptionItem extends StatelessWidget {
  WDG_OptionItem({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(61.0, 0.04),
          child: SizedBox(
            width: 242.0,
            height: 36.0,
            child: Text(
              'حق بیمه',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: const Color(0xff898a8f),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, 37.04),
          child: SvgPicture.string(
            _svg_sxz3ll,
            allowDrawingOutsideViewBox: true,
          ),
        ),
      ],
    );
  }
}

const String _svg_sxz3ll =
    '<svg viewBox="0.0 37.0 310.1 1.0" ><path transform="translate(-154.0, -18.96)" d="M 154.0000457763672 56 L 464.0748596191406 56" fill="none" stroke="#ececec" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
