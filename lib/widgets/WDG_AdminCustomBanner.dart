import 'package:flutter/material.dart';
import 'package:refah/models/UserSampleVM.dart';
import 'package:refah/services/UserSampleService.dart';

class WDG_AdminCustomBanner extends StatelessWidget {
  UserSampleVM sample;
  String url;
  double height;
  Function(dynamic result) onTapCallback;
  Function(dynamic result) onTapStartCallback;

  WDG_AdminCustomBanner({
    this.height,
    this.url,
    this.sample,
    this.onTapCallback,
    this.onTapStartCallback,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200.0,
      margin: EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        border: Border.all(width: 1.0, color: const Color(0xffcccccc)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "حذف",
                style: TextStyle(
                  fontFamily: "IRANSans",
                ),
              ),
            ),
            onTap: () async {
              if (onTapCallback != null) {
                onTapStartCallback("tap");
              }
              var res = await UserSampleService().delete(sample);

              if (res != null) {
                if (onTapCallback != null) {
                  onTapCallback("tap");
                }
              }
            },
          ),
          Flexible(
            child: Container(
              //height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                image: DecorationImage(
                  image: sample != null &&
                          sample.filePath != null &&
                          sample.filePath.isNotEmpty
                      ? NetworkImage(
                          "https://api.refahandishanco.ir" + sample.filePath)
                      : AssetImage('images/banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
