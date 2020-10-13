import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_Footer1 extends StatelessWidget {
  WDG_Footer1({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(288.3, 0.0),
          child: SvgPicture.string(
            _svg_sjkof6,
            allowDrawingOutsideViewBox: true,
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, 21.0),
          child: Container(
            width: 375.0,
            height: 24.0,
            decoration: BoxDecoration(),
          ),
        ),
        Transform.translate(
          offset: Offset(125.0, 31.0),
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

const String _svg_sjkof6 =
    '<svg viewBox="288.3 0.0 86.7 45.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.630887" y2="0.791011"><stop offset="0.0" stop-color="#ff1fac9c"  /><stop offset="1.0" stop-color="#ff97c18b"  /></linearGradient></defs><path transform="translate(681.0, -3466.0)" d="M -305.9997863769531 3511.00048828125 L -392.7003173828125 3511.00048828125 C -389.19677734375 3506.031494140625 -385.2444152832031 3501.33740234375 -380.9538269042969 3497.046630859375 C -376.1585693359375 3492.251220703125 -370.8804626464844 3487.896484375 -365.2660217285156 3484.10302734375 C -359.6009216308594 3480.275390625 -353.5428771972656 3476.9873046875 -347.2601928710938 3474.32958984375 C -334.1915588378906 3468.80224609375 -320.3095703125 3465.999755859375 -305.9997863769531 3465.999755859375 L -305.9997863769531 3511.00048828125 L -305.9997863769531 3511.00048828125 L -305.9997863769531 3511.00048828125 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
