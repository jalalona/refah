import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_SmallDeleteIcon extends StatelessWidget {
  Widget route;
  Function(dynamic result) onTapCallback;
  dynamic param;

  WDG_SmallDeleteIcon({
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
            _svg_609uhz,
            allowDrawingOutsideViewBox: true,
          ),
        ),
      ),
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback(param);
        }

        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        }
      },
    );
  }
}

const String _svg_609uhz =
    '<svg viewBox="0.0 0.4 10.0 10.0" ><path transform="translate(0.0, 0.0)" d="M 9.743953704833984 8.453327178955078 L 1.906956076622009 0.6163303852081299 C 1.565162658691406 0.2745369076728821 1.011030554771423 0.2745369076728821 0.6697701811790466 0.6163303852081299 L 0.2567332983016968 1.028724789619446 C -0.0850602313876152 1.370624899864197 -0.0850602313876152 1.92475700378418 0.2567332983016968 2.266017198562622 L 8.093730926513672 10.10301399230957 C 8.43563175201416 10.44480800628662 8.989763259887695 10.44480800628662 9.331024169921875 10.10301399230957 L 9.74341869354248 9.690620422363281 C 10.08585166931152 9.349359512329102 10.08585166931152 8.795120239257813 9.743952751159668 8.453327178955078 Z M 9.743953704833984 8.453327178955078" fill="#f44336" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.0, 0.0)" d="M 8.093342781066895 0.6180838346481323 L 0.2563450336456299 8.455080986022949 C -0.08544846624135971 8.796874046325684 -0.08544846624135971 9.351113319396973 0.2563450336456299 9.692373275756836 L 0.6687394380569458 10.10476779937744 C 1.010639548301697 10.44656181335449 1.56477165222168 10.44656181335449 1.906032085418701 10.10476779937744 L 9.743576049804688 2.268290519714355 C 10.08547592163086 1.926496982574463 10.08547592163086 1.37236499786377 9.743576049804688 1.031104564666748 L 9.331181526184082 0.6187102794647217 C 8.989388465881348 0.2762768864631653 8.435256004333496 0.2762768864631653 8.093355178833008 0.6180694103240967 Z M 8.093342781066895 0.6180838346481323" fill="#f44336" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
