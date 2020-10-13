import 'package:flutter/material.dart';
import 'package:refah/models/ZarrinPalVerifyResponse.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/widgets/WDG_BackIconCircle.dart';
import 'package:refah/widgets/WDG_BigGreenButton.dart';

class ProccessSuccessPage extends StatefulWidget {
  String title;
  String description;
  String totalPrice;
  ZarrinPalVerifyResponseModel response;

  Widget content;

  ProccessSuccessPage({
    this.response,
    this.description,
    this.title,
    this.totalPrice,
  });

  @override
  _ProccessSuccessPageState createState() => _ProccessSuccessPageState();
}

class _ProccessSuccessPageState extends State<ProccessSuccessPage> {
  @override
  void initState() {
    super.initState();

    EnrollService().clearMyEnrolls();
  }

  @override
  Widget build(BuildContext context) {
    EnrollService().clearMyEnrolls();
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    top: 100.0,
                    left: 30.0,
                    right: 30.0,
                    bottom: 50.0,
                  ),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 10),
                        blurRadius: 38,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 75.0,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                widget.response?.data?.card_pan != null
                                    ? "شماره کارت : " +
                                        widget.response?.data?.card_pan
                                    : "شماره کارت : --",
                                style: TextStyle(
                                  fontFamily: "IRANSans",
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.response?.data?.ref_id != null
                                    ? "پیگیری : " +
                                        widget.response?.data?.ref_id.toString()
                                    : "پیگیری : --",
                                style: TextStyle(
                                  fontFamily: "IRANSans",
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.response?.data?.fee != null
                                    ? "مبلغ : " +
                                        widget.response?.data?.fee.toString()
                                    : "مبلغ : --",
                                style: TextStyle(
                                  fontFamily: "IRANSans",
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(
                          "با موفقیت اطلاعات شما ثبت شد",
                          style: TextStyle(
                            fontFamily: "IRANSans",
                          ),
                        ),
                      ),
                      Container(
                        child: WDG_BigGreenButton(
                          text: "تائید",
                          pop: true,
                          route: ClientHomePage(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Text(
                          "بازگشت",
                          style: TextStyle(
                            fontFamily: "IRANSans",
                          ),
                        ),
                      ),
                      Container(
                        child: WDG_BackIconCircle(
                          pop: true,
                          route: ClientHomePage(),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
