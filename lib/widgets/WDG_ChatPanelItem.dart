import 'package:flutter/material.dart';
import 'package:refah/models/UserMessageVM.dart';
import 'package:refah/models/UserVM.dart';

class WDG_ChatPanelItem extends StatelessWidget {
  UserMessageVM obj;
  UserVM client;
  UserVM me;
  bool isMe = false;

  WDG_ChatPanelItem({
    this.client,
    this.obj,
    this.me,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (obj.userCreatedId == me.id) {
      isMe = true;
    } else {
      isMe = false;
    }

    return Container(
      //margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffffffff),
      ),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: obj?.userCreatedId == me?.id
              ? Colors.grey[100]
              : Colors.green[100],
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Row(
          textDirection: obj?.userCreatedId == me?.id
              ? TextDirection.ltr
              : TextDirection.rtl,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(
                      20.0,
                      20.0,
                    )),
                    image: DecorationImage(
                      image: isMe && me?.avatar != null && me?.avatar.isNotEmpty
                          ? NetworkImage(
                              "https://api.refahandishanco.ir" + me.avatar)
                          : isMe == false &&
                                  client?.avatar != null &&
                                  client?.avatar.isNotEmpty
                              ? NetworkImage("https://api.refahandishanco.ir" +
                                  client.avatar)
                              : AssetImage('images/female_avatar.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 15.0,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                width: MediaQuery.of(context).size.width - 80.0,
                child: Text(
                  obj?.message ?? "متن ندارد",
                  style: TextStyle(
                    fontFamily: "IRANSans",
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
