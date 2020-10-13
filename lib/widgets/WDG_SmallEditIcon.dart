import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_SmallEditIcon extends StatelessWidget {
  Widget route;
  Function(dynamic result) onTapCallback;
  dynamic param;

  WDG_SmallEditIcon({
    this.onTapCallback,
    this.param,
    this.route,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(12.0, 12.0)),
          border: Border.all(width: 1.0, color: const Color(0xff1fac9c)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x21000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: SvgPicture.string(
            _svg_2yn0h5,
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
          onTapCallback(param);
        }
      },
    );
  }
}

const String _svg_2yn0h5 =
    '<svg viewBox="6.9 6.9 11.3 11.3" ><path transform="translate(3.87, 3.87)" d="M 14.25293064117432 10.50195407867432 C 14.25293064117432 11.19248962402344 13.69314002990723 11.75227832794189 13.00260353088379 11.75227832794189 L 5.500650882720947 11.75227832794189 L 3 14.25293064117432 L 3 4.250325679779053 C 3 3.559789657592773 3.559790134429932 3 4.250325679779053 3 L 13.00260353088379 3 C 13.69314098358154 3 14.25293064117432 3.559789657592773 14.25293064117432 4.250325679779053 L 14.25293064117432 10.50195407867432 Z" fill="none" stroke="#1f6aac" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" /></svg>';
