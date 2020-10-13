import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WDG_SMSForm extends StatelessWidget {
  String title;
  String decription;
  String hint;
  Function(String result) onTextChangeCallback;
  Function(String result) onTextSubmitCallback;

  WDG_SMSForm({
    this.decription,
    this.hint,
    this.onTextChangeCallback,
    this.onTextSubmitCallback,
    this.title,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 30.0, left: 30.0),
      padding: EdgeInsets.all(5.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              'پیامک عمومی',
              style: TextStyle(
                fontFamily: 'IRANSans',
                fontSize: 14,
                color: const Color(0xff313450),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              'ارسال پیامک به تمام شماره تماس های موجود در سیستم',
              style: TextStyle(
                fontFamily: 'IRANSans',
                fontSize: 10,
                color: const Color(0xff717171),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SvgPicture.string(
            _svg_p1o2da,
            allowDrawingOutsideViewBox: true,
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.0),
              color: const Color(0xfff6f6f6),
              border: Border.all(width: 1.0, color: const Color(0xffd6d6d6)),
            ),
            child: Container(
              height: 200.0,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "محتوی پیامک",
                  hintStyle: TextStyle(
                    fontFamily: "IRANSans",
                  ),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 6,
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  if (onTextChangeCallback != null) {
                    onTextChangeCallback(value);
                  }
                },
                onSubmitted: (value) {
                  if (onTextSubmitCallback != null) {
                    onTextSubmitCallback(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_p1o2da =
    '<svg viewBox="9.5 108.3 325.1 1.0" ><path transform="translate(-144.5, 52.3)" d="M 154.0000457763672 56 L 479.0748291015625 56" fill="none" stroke="#ececec" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
