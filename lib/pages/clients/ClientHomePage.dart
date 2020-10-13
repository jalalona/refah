import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_carousel/carousel.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/pages/InsuranceContract.dart';
import 'package:refah/pages/RefahSidebar.dart';
import 'package:refah/pages/clients/AboutUs.dart';
import 'package:refah/pages/clients/ClientCreditPage.dart';
import 'package:refah/pages/clients/ClientDoctorsPage.dart';
import 'package:refah/pages/clients/ClientOfferPage.dart';
import 'package:refah/pages/clients/JoinApp.dart';
import 'package:refah/pages/clients/ShareApp.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/services/UserCommentService.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_Banner.dart';
import 'package:refah/widgets/WDG_BigIconButton.dart';
import 'package:refah/widgets/WDG_CommentClientItem.dart';
import 'package:refah/widgets/WDG_DoctorCard.dart';
import 'package:refah/widgets/WDG_InstagramButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

import '../DentistryContract.dart';
import 'ClientLogin.dart';

class ClientHomePage extends StatefulWidget {
  ClientHomePage({
    Key key,
  }) : super(key: key);

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  String expirationDay = "";
  List<Widget> partners = List<Widget>();
  List<Widget> comments = List<Widget>();

  Future initExpiration() async {
    await EnrollService().getMyAllEnrolls();
    await EnrollService().getMyActiveEnroll();
    setState(() {
      expirationDay = EnrollService().calculateCredit();
    });
  }

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => ClientLogin(),
    //   ),
    // );

    return false;
  }

  Future initWellcomeMessage() async {
    if (ProfileService().getWellcome() == false) {
      if (expirationDay != null && expirationDay.length > 0) {
        var mess = await OptionService().getByName("wellcome_message");
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.SCALE,
          title:
              ProfileService().getUserData().fullname ?? "نام و نام خانوادگی",
          desc: mess?.value ?? "خوش آمدید به سیستم سلامتی رفاه اندیشان",
          btnOkText: "ممنون",
          btnOkOnPress: () async {},
        )..show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.SCALE,
          title: "کاربر مهمان",
          desc: "خوش آمدید به سیستم سلامتی رفاه اندیشان",
          btnOkText: "ممنون",
          btnOkOnPress: () async {},
        )..show();
      }
    }

    ProfileService().setWellcome(true);
  }

  Future setupPartners() async {
    var parts = await UserService().init();
    parts =
        parts.where((element) => element.status == "partner").take(15).toList();
    parts.sort((a, b) => a.priority.compareTo(b.priority));
    setState(() {
      for (int i = 0; i < parts.length; i++) {
        partners.add(
          WDG_DoctorCard(
            obj: parts[i],
          ),
        );
      }
    });
  }

  Future setupLastComments() async {
    var cnts = await UserCommentService().init();
    cnts.sort((a, b) => b.id.compareTo(a.id));
    cnts = cnts.where((element) => element.isActive == true).toList();
    cnts = cnts.take(10).toList();

    setState(() {
      comments = cnts.map((e) => WDG_CommentClientItem(obj: e)).toList();
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      //throw 'Could not launch $url';
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();

    initExpiration().then((value) {
      initWellcomeMessage();
    });

    setupPartners();

    setupLastComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => HawkFabMenu(
          icon: AnimatedIcons.menu_arrow,
          fabColor: Colors.white,
          iconColor: Colors.green,
          items: [
            HawkFabMenuItem(
              label: 'درباره ما',
              ontap: () {
                // Scaffold.of(context)..hideCurrentSnackBar();
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('اطلاعات تماس')),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              },
              icon: Icon(Icons.merge_type),
              color: Colors.green,
              labelColor: Colors.lightGreen,
            ),
            HawkFabMenuItem(
              label: 'همکاری با ما',
              ontap: () {
                // Scaffold.of(context)..hideCurrentSnackBar();
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('متن همکاری شما')),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinApp(),
                  ),
                );
              },
              icon: Icon(Icons.merge_type),
              labelColor: Colors.white,
              labelBackgroundColor: Colors.blue,
            ),
            HawkFabMenuItem(
              label: 'معرفی به دوست',
              ontap: () {
                // Scaffold.of(context)..hideCurrentSnackBar();
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('پیشنهاد به دوستان')),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShareApp(),
                  ),
                );
              },
              icon: Icon(Icons.share),
              labelColor: Colors.white,
              labelBackgroundColor: Colors.blue,
            ),
          ],
          body: Scaffold(
            drawer: RefahSidebar(),
            backgroundColor: const Color(0xfff6f6f6),
            body: WillPopScope(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Image.asset(
                              "images/smallgreenheader.png",
                              width: MediaQuery.of(context).size.width,
                              height: 110.0,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              height: 120.0,
                              margin: EdgeInsets.only(top: 65.0),
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                              ),
                              child: ListView(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  WDG_BigIconButton(
                                    title: "تکمیلی",
                                    description: "ثبت نام",
                                    icon: Image.asset(
                                      "images/familyinsurance.png",
                                    ),
                                    route: InsuranceContract(),
                                  ),
                                  WDG_BigIconButton(
                                    title: "دندانپزشکی",
                                    description: "ثبت نام",
                                    icon: Image.asset(
                                      "images/dentistry1.png",
                                    ),
                                    route: DentistryContract(),
                                  ),
                                  WDG_BigIconButton(
                                    title: expirationDay ?? "بدون اعتبار",
                                    description: "اعتبار به روز",
                                    icon: Image.asset("images/cards.png"),
                                    route: ClientCreditPage(),
                                  ),
                                  WDG_BigIconButton(
                                    description: "مراکز تحت قرارداد",
                                    title: "تخفیف",
                                    icon: Image.asset("images/priceoffer.png"),
                                    route: ClientOfferPage(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: CarouselSlider(
                            options: CarouselOptions(height: 170.0),
                            items: OptionService()
                                .getAllLocalByType("banner")
                                .map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return WDG_Banner(
                                    opt: i,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            left: 25.0,
                            right: 25.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    child: Text(
                                      "همه",
                                      style: TextStyle(
                                          fontFamily: "IRANSans",
                                          color: Color(0xff1fac9c),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ClientDoctorsPage(),
                                        ),
                                      );
                                    },
                                  ),
                                  Text("مراکز طرف قرارداد ما",
                                      style: TextStyle(
                                        fontFamily: "IRANSans",
                                      ),
                                      textAlign: TextAlign.right),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: Carousel(
                            rowCount: 3,
                            children: partners.map((i) {
                              return Container(
                                child: i,
                                padding: EdgeInsets.only(bottom: 20.0),
                              );
                            }).toList(),
                          ),
                        ),
                        // Container(
                        //   child: CarouselSlider(
                        //     options: CarouselOptions(
                        //       height: 200.0,
                        //       initialPage: 0,
                        //     ),
                        //     items: partners.map((i) {
                        //       return i;
                        //     }).toList(),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            left: 25.0,
                            right: 25.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                child: WDG_InstagramButton(),
                                onTap: () async {
                                  try {
                                    var opt = await OptionService()
                                        .getByName("instagram_address");
                                    var url = opt != null
                                        ? opt.value
                                        : 'https://www.instagram.com/jalalonagh/';
                                    //await _launchURL(url);
                                    await _launchInBrowser(url);
                                  } catch (e) {}
                                },
                              ),
                              Container(
                                child: Text(
                                  "آخرین نظرات",
                                  style: TextStyle(
                                    fontFamily: "IRANSans",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 300.0,
                          margin: EdgeInsets.only(bottom: 60.0),
                          child: ListView(
                            children: comments,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onWillPop: () => backPress()),
          ),
        ),
      ),
    );
  }
}
