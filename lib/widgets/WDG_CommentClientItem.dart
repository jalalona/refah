import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refah/models/UserCommentVM.dart';

class WDG_CommentClientItem extends StatelessWidget {
  UserCommentVM obj;

  WDG_CommentClientItem({
    this.obj,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      padding: EdgeInsets.all(5.0),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffffffff),
      ),
      child: Container(
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: Text(
                obj?.description ?? 'متن کامنت کاربر',
                style: TextStyle(
                  fontFamily: 'IRANSans',
                  fontSize: 10,
                  color: const Color(0xff313450),
                  fontWeight: FontWeight.w500,
                  height: 1.9,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  SvgPicture.string(
                    _svg_j60biq,
                    allowDrawingOutsideViewBox: true,
                  ),
                  Text(
                    obj?.rate?.toString() ?? '0.0',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 10,
                      color: const Color(0xff898a8f),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _svg_j60biq =
    '<svg viewBox="12.6 18.5 14.1 13.4" ><path transform="translate(12.56, 17.21)" d="M 7.056396484375 1.317999958992004 L 9.236664772033691 5.736172676086426 L 14.1125316619873 6.444850921630859 L 10.5843334197998 9.883712768554688 L 11.41719436645508 14.73992919921875 L 7.056396484375 12.44726943969727 L 2.695336818695068 14.73992919921875 L 3.5281982421875 9.883712768554688 L 0 6.444850921630859 L 4.875866889953613 5.736172676086426 L 7.056396484375 1.317999958992004 Z" fill="#efce4a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
