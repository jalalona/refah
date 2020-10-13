import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './WDG_FactorItem.dart';

class WDG_FactorContainer extends StatelessWidget {
  WDG_FactorContainer({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SvgPicture.string(
          _svg_tyl4rc,
          allowDrawingOutsideViewBox: true,
        ),
        Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  'اعضای خانواده',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: const Color(0xff313450),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              WDG_FactorItem(),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(19.5, 274.0),
          child: SizedBox(
            width: 149.0,
            height: 19.0,
            child: Text(
              'اعضاء',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: const Color(0xff313450),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(168.68, 274.0),
          child: SizedBox(
            width: 155.0,
            height: 19.0,
            child: Text(
              '3 نفر',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: const Color(0xff313450),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

const String _svg_tyl4rc =
    '<svg viewBox="0.0 0.0 340.0 315.0" ><path  d="M 331.2666015625 251.65478515625 C 331.2666015625 251.65478515625 340.0712890625 260.459716796875 340 260.5237426757813 C 340 305.5039367675781 340 295 340 295 C 340 306.0456848144531 331.0456848144531 315 320 315 L 20 315 C 8.954304695129395 315 0 306.0456848144531 0 295 L 0 260.3984375 L 8.6181640625 252.817138671875 L 331.2666015625 251.65478515625 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path  d="M 20.9033203125 0 L 320 0 C 331.0456848144531 0 340 8.954304695129395 340 20 L 340 220.0003967285156 C 340 220.0003967285156 340 234.8610229492188 340 241.392822265625 C 340.0712890625 241.4296875 331.2666015625 251.65478515625 331.2666015625 251.65478515625 C 331.2666015625 251.65478515625 104.1549072265625 252.817138671875 8.6181640625 252.817138671875 L 0 244.47802734375 C 0 244.47802734375 0 280.627197265625 0 224.5076904296875 C 0 168.38818359375 0 20 0 20 C 0 8.954304695129395 9.857625007629395 0 20.9033203125 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-8310.63, 150.6)" d="M 8326.134765625 101.9526596069336 L 8637.4736328125 101.9526596069336" fill="none" stroke="#94a5a6" stroke-width="1" stroke-dasharray="3 3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
