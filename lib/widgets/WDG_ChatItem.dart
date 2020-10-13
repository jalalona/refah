import 'package:flutter/material.dart';
import 'package:refah/models/UserMessageVM.dart';
import './WDG_ReplyIcon.dart';

class WDG_ChatItem extends StatelessWidget {
  UserMessageVM obj;

  WDG_ChatItem({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: const Color(0xffffffff),
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 61.0,
                        height: 61.0,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(30.5, 30.5)),
                          image: DecorationImage(
                            image: const AssetImage('images/female_avatar.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text(
                                  'مرجان رضائی',
                                  style: TextStyle(
                                    fontFamily: 'IRANSans',
                                    fontSize: 14,
                                    color: const Color(0xff313450),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  "متن نوشته شده پیام بیمار به دکتر و ...",
                                  style: TextStyle(
                                    fontFamily: "IRANSans",
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      WDG_ReplyIcon(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
