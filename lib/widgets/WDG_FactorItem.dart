import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refah/models/EnrollVM.dart';

class WDG_FactorItem extends StatelessWidget {
  String title;
  Function(String result) deleteTapCallback;
  Widget route;
  dynamic param;

  WDG_FactorItem({
    this.deleteTapCallback,
    this.title,
    this.route,
    this.param,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgPicture.string(
                  _svg_5t04sr,
                  allowDrawingOutsideViewBox: true,
                ),
                Expanded(
                  child: Text(
                    title ?? 'نام و نام خانوادگی',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 13,
                      color: const Color(0xff313450),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: SvgPicture.string(
                _svg_l6rffp,
                allowDrawingOutsideViewBox: true,
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

              if (deleteTapCallback != null) {
                deleteTapCallback(param);
              }
            },
          ),
        ],
      ),
    );
  }
}

const String _svg_5t04sr =
    '<svg viewBox="3.0 2.0 13.3 14.8" ><path transform="translate(0.0, -1.05)" d="M 2.999999761581421 6 L 4.47569465637207 6 L 16.28125 6" fill="none" stroke="#c7c7c7" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(-0.52, 0.0)" d="M 15.32986068725586 4.951388359069824 L 15.32986068725586 15.28125 C 15.32986068725586 16.09625434875488 14.66916847229004 16.75694465637207 13.85416603088379 16.75694465637207 L 6.475694179534912 16.75694465637207 C 5.660690784454346 16.75694465637207 5 16.09625244140625 5 15.28125 L 5 4.951388359069824 M 7.213541507720947 4.951388359069824 L 7.213541507720947 3.475694417953491 C 7.213541507720947 2.660691022872925 7.874232292175293 1.99999988079071 8.689235687255859 2 L 11.640625 2 C 12.45562744140625 2 13.11631965637207 2.660691022872925 13.11631965637207 3.475694417953491 L 13.11631965637207 4.951388359069824" fill="none" stroke="#c7c7c7" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_l6rffp =
    '<svg viewBox="0.0 36.6 308.8 1.0" ><path transform="translate(-8326.13, -63.0)" d="M 8326.134765625 99.55261993408203 L 8634.9453125 99.55261993408203" fill="none" stroke="#ececec" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
