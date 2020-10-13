import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_BorderedIconButton extends StatelessWidget {
  SvgPicture icon;
  Widget route;
  Function(dynamic result) onTapCallback;

  WDG_BorderedIconButton({
    this.icon,
    this.onTapCallback,
    this.route,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(18.0, 18.0)),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xffe6e6e6)),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: icon ??
              SvgPicture.string(
                _svg_fdfon,
                allowDrawingOutsideViewBox: true,
              ),
        ),
      ),
      onTap: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        }

        if (onTapCallback != null) {
          onTapCallback("result");
        }
      },
    );
  }
}

const String _svg_fdfon =
    '<svg viewBox="12.9 12.9 11.3 11.3" ><path transform="translate(9.87, 9.87)" d="M 14.25293064117432 10.50195407867432 C 14.25293064117432 11.19248962402344 13.69314002990723 11.75227832794189 13.00260353088379 11.75227832794189 L 5.500650882720947 11.75227832794189 L 3 14.25293064117432 L 3 4.250325679779053 C 3 3.559789657592773 3.559790134429932 3 4.250325679779053 3 L 13.00260353088379 3 C 13.69314098358154 3 14.25293064117432 3.559789657592773 14.25293064117432 4.250325679779053 L 14.25293064117432 10.50195407867432 Z" fill="none" stroke="#3a58fc" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" /></svg>';
