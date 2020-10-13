import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/UserService.dart';

class WDG_SearchInput extends StatefulWidget {
  String hint;
  Function(String result) searchTextChangeCallback;
  Function(dynamic result) submitSearchCallback;
  Function(String result) submitSearchTextCallback;

  WDG_SearchInput({
    this.hint,
    this.searchTextChangeCallback,
    this.submitSearchCallback,
    this.submitSearchTextCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_SearchInputState createState() => _WDG_SearchInputState();
}

class _WDG_SearchInputState extends State<WDG_SearchInput> {
  bool vis = false;
  String searchedText = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: SvgPicture.string(
            _svg_x6ooj9,
            allowDrawingOutsideViewBox: true,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 7.5,
              right: 15.0,
              bottom: 5.0,
              left: 15.0,
            ),
            child: TextField(
              onChanged: (value) {
                searchedText = value;
                if (widget.searchTextChangeCallback != null) {
                  widget.searchTextChangeCallback(value);
                }
              },
              decoration: InputDecoration(
                hintText: widget.hint ?? "جستجوی بیمار",
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontFamily: 'IRANSans',
                fontSize: 14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 15.0,
            bottom: 5.0,
            left: 14.0,
          ),
          child: Visibility(
            child: CircularProgressIndicator(),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: vis,
          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.all(25.0),
            child: SvgPicture.string(
              searchIcon,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          onTap: () async {
            setState(() {
              vis = true;
            });

            var res = await EnrollService().search(searchedText);

            if (widget.submitSearchCallback != null) {
              widget.submitSearchCallback(res);
            }

            if (widget.submitSearchTextCallback != null) {
              widget.submitSearchTextCallback(searchedText);
            }

            setState(() {
              vis = false;
            });
          },
        ),
      ],
    );
  }
}

const String _svg_x6ooj9 =
    '<svg viewBox="0.0 0.0 341.7 46.9" ><defs><filter id="shadow"><feDropShadow dx="0" dy="12" stdDeviation="24"/></filter></defs><path  d="M 23.4375 0 L 318.2291564941406 0 C 331.1733093261719 0 341.6666564941406 10.49332714080811 341.6666564941406 23.4375 C 341.6666564941406 36.38167190551758 331.1733093261719 46.875 318.2291564941406 46.875 L 23.4375 46.875 C 10.49332714080811 46.875 0 36.38167190551758 0 23.4375 C 0 10.49332714080811 10.49332714080811 0 23.4375 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String searchIcon =
    '<svg viewBox="0.0 0.0 14.1 14.1" ><path transform="translate(-10.47, -44.03)" d="M 13.63418674468994 53.57024383544922 C 11.49496555328369 51.43088912963867 11.28203773498535 48.0338249206543 13.13744354248047 45.64400863647461 C 11.38450527191162 47.01784515380859 10.53651142120361 49.24959945678711 10.9350643157959 51.44093704223633 C 11.33347988128662 53.63214492797852 12.91279220581055 55.42259216308594 15.03724575042725 56.09132766723633 C 17.16170883178711 56.76017761230469 19.48187828063965 56.19723510742188 21.06365394592285 54.62936782836914 C 21.24072647094727 54.45243453979492 21.40662956237793 54.26460266113281 21.56039619445801 54.06697845458984 C 19.17059898376465 55.92238998413086 15.77366638183594 55.70945739746094 13.63415813446045 53.57023620605469 Z M 13.63418674468994 53.57024383544922" fill="#d4e1f4" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-0.44, 0.0)" d="M 11.52578830718994 10.58972644805908 C 13.75809574127197 8.097461700439453 13.67741966247559 4.252607345581055 11.2832088470459 1.858412623405457 C 8.834249496459961 -0.5882022976875305 4.877140998840332 -0.6236444115638733 2.384730100631714 1.778839826583862 C -0.1076711267232895 4.181186676025391 -0.2177179604768753 8.136929512023926 2.137324571609497 10.6741418838501 C 4.492367267608643 13.2113618850708 8.445352554321289 13.39588451385498 11.02641296386719 11.08910465240479 L 13.95266819000244 14.01536083221436 C 14.09071350097656 14.15216445922852 14.31343650817871 14.15161418914795 14.45092964172363 14.01425838470459 C 14.58828544616699 13.87676334381104 14.58883666992188 13.65404605865479 14.45203304290771 13.5159969329834 L 11.52578830718994 10.58972644805908 Z M 2.794475078582764 10.34714698791504 C 0.5780262351036072 8.151248931884766 0.5613414645195007 4.574331760406494 2.757239818572998 2.357752799987793 C 4.95313835144043 0.1413042992353439 8.530054092407227 0.1246195361018181 10.7466344833374 2.320517778396606 C 10.75904560089111 2.332929372787476 10.77145862579346 2.345340967178345 10.78386974334717 2.357752799987793 C 12.9865255355835 4.560408115386963 12.9865255355835 8.144336700439453 10.78386974334717 10.34714698791504 C 8.581076622009277 12.54980182647705 4.997003555297852 12.54980182647705 2.794475317001343 10.34714698791504 Z M 2.794475078582764 10.34714698791504" fill="#c7c7c7" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
