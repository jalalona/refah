import 'package:flutter/material.dart';
import 'package:adobe_xd/page_link.dart';

class WDG_Logo extends StatelessWidget {
  WDG_Logo({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageLink(
          links: [
            // PageLinkInfo(
            //   transition: LinkTransition.Fade,
            //   ease: Curves.easeOut,
            //   duration: 0.3,
            //   pageBuilder: () => WDG_page2(),
            // ),
          ],
          child:
              // Adobe XD layer: 'logo' (shape)
              Container(
            width: 200.0,
            height: 132.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(''),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
