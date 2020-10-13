import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/services/UserSampleService.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_Banner.dart';
import 'package:refah/widgets/WDG_CustomBanner.dart';
import 'package:refah/widgets/WDG_DoctorCardItem.dart';

class ClientOfferPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  ClientOfferPage({
    this.description,
    this.title,
  });

  @override
  _ClientOfferPageState createState() => _ClientOfferPageState();
}

class _ClientOfferPageState extends State<ClientOfferPage> {
  List<Widget> partners = List<Widget>();

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => ClientHomePage(),
    //   ),
    // );

    return false;
  }

  Future setupOffers() async {
    var parts = await UserSampleService().init();
    setState(() {
      partners = parts
          .map((e) => WDG_CustomBanner(
                url: e.filePath,
                height: 150.0,
              ))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    setupOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "images/BigGreenHeader.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100.0,
                    margin: EdgeInsets.only(
                      top: 100.0,
                      left: 20.0,
                      right: 20.0,
                      bottom: 50.0,
                    ),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 9),
                          blurRadius: 38,
                        ),
                      ],
                    ),
                    child: ListView(
                      children: partners,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                top: 75.0,
                right: 50.0,
                left: 50.0,
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          "images/backarrow.svg",
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientHomePage(),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: Text(
                        widget.title ?? "عنوان صفحه",
                        style: TextStyle(
                          fontFamily: "IRANSans",
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
