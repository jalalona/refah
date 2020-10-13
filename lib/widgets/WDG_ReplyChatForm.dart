import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './WDG_RichInput.dart';

class WDG_ReplyChatForm extends StatelessWidget {
  WDG_ReplyChatForm({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 345.0,
          height: 393.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: const Color(0x17000000),
                offset: Offset(0, 9),
                blurRadius: 38,
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(26.0, 11.0),
          child: SizedBox(
            width: 294.0,
            height: 137.0,
            child: Text(
              'متن پیام نوشته ...',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: const Color(0xff313450),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(9.5, 173.22),
          child: SvgPicture.string(
            _svg_zh96ga,
            allowDrawingOutsideViewBox: true,
          ),
        ),
        Transform.translate(
          offset: Offset(10.0, 186.0),
          child:
              // Adobe XD layer: 'RichInput' (component)
              WDG_RichInput(),
        ),
        Transform.translate(
          offset: Offset(26.0, 150.0),
          child: SizedBox(
            width: 294.0,
            height: 16.0,
            child: Text(
              'نویسنده پیام',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
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

const String _svg_zh96ga =
    '<svg viewBox="9.5 173.2 325.1 1.0" ><path transform="translate(-144.5, 117.22)" d="M 154.0000457763672 56 L 479.0748291015625 56" fill="none" stroke="#ececec" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
