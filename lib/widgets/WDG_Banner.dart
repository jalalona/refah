import 'package:flutter/material.dart';
import 'package:refah/models/OptionVM.dart';
import 'package:refah/pages/clients/ImageFullScreen.dart';

class WDG_Banner extends StatelessWidget {
  OptionVM opt;
  String url;

  WDG_Banner({
    this.url,
    this.opt,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String image = "";

    if (opt != null && opt.value != null && opt.value.isNotEmpty) {
      image = "https://api.refahandishanco.ir" + opt.value;
    } else if (url != null && url.isNotEmpty) {
      image = "https://api.refahandishanco.ir" + url;
    }

    return InkWell(
      child: Container(
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
              image: image.isNotEmpty
                  ? NetworkImage(image)
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
              url: image,
            ),
          ),
        );
      },
    );
  }
}
