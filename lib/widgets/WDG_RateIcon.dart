import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_RateIcon extends StatelessWidget {
  String rate;

  WDG_RateIcon({
    this.rate,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 3.5),
            child: Text(
              rate ?? '0.0',
              style: TextStyle(
                fontFamily: 'IRANSans',
                fontSize: 10,
                color: const Color(0xff898a8f),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: SvgPicture.string(
              _svg_2yjoaz,
              allowDrawingOutsideViewBox: true,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_2yjoaz =
    '<svg viewBox="0.0 0.2 14.1 13.4" ><path transform="translate(0.0, -1.1)" d="M 7.056396484375 1.317999958992004 L 9.236664772033691 5.736172676086426 L 14.1125316619873 6.444850921630859 L 10.5843334197998 9.883712768554688 L 11.41719436645508 14.73992919921875 L 7.056396484375 12.44726943969727 L 2.695336818695068 14.73992919921875 L 3.5281982421875 9.883712768554688 L 0 6.444850921630859 L 4.875866889953613 5.736172676086426 L 7.056396484375 1.317999958992004 Z" fill="#efce4a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
