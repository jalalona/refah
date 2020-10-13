import 'package:flutter/material.dart';
import './WDG_EditIcon.dart';
import './WDG_RejectIcon.dart';
import './WDG_ConfirmIcon.dart';

class WDG_CommentAdminItem extends StatelessWidget {
  WDG_CommentAdminItem({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // width: 333.0,
          // height: 133.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: const Color(0xffffffff),
          ),
        ),
        Transform.translate(
          offset: Offset(99.0, 6.0),
          child: SizedBox(
            width: 217.0,
            height: 19.0,
            child: Text(
              'مرجان رضائی',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: const Color(0xff313450),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(13.0, 10.0),
          child: Container(
            width: 61.0,
            height: 61.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(30.5, 30.5)),
              image: DecorationImage(
                image: const AssetImage('images/female_avatar.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(105.0, 37.0),
          child: SizedBox(
            width: 201.0,
            height: 47.0,
            child: Text(
              'دستشون درد نکنه . خدا خیرش بده',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: const Color(0xff898a8f),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(99.0, 31.0),
          child: Container(
            width: 212.0,
            height: 57.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(width: 0.5, color: const Color(0xffececec)),
            ),
          ),
        ),
      ],
    );
  }
}
