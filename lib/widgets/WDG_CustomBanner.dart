import 'package:flutter/material.dart';
import 'package:refah/pages/clients/ImageFullScreen.dart';

class WDG_CustomBanner extends StatelessWidget {
  String url;
  double height;

  WDG_CustomBanner({
    this.height,
    this.url,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: height ?? 150.0,
        margin: EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          border: Border.all(width: 1.0, color: const Color(0xffcccccc)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
            image: DecorationImage(
              image: url != null && url.isNotEmpty
                  ? NetworkImage("https://api.refahandishanco.ir" + url)
                  : AssetImage('images/banner.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageFullScreen(
              url: "https://api.refahandishanco.ir" + url,
            ),
          ),
        );
      },
    );
  }
}
