import 'dart:io';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:refah/pages/admin/AdminInsuranceReportPage.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';
import 'package:refah/services/EnrollOrderService.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OrderService.dart';
import 'package:refah/widgets/WDG_BackIconCircle.dart';
import 'package:refah/widgets/WDG_BigBorderedGrayButton.dart';
import 'package:refah/widgets/WDG_BigIconButton.dart';

class AdminReportChoosePage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminReportChoosePage({
    this.description,
    this.title,
  });

  @override
  _AdminReportChoosePageState createState() => _AdminReportChoosePageState();
}

class _AdminReportChoosePageState extends State<AdminReportChoosePage> {
  int totalToday = 0;
  int totalDentist = 0;
  int totalInsurance = 0;
  int totalRegister = 0;
  int totalDentistRegister = 0;
  int totalIncome = 0;
  int totalTodayIncome = 0;

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminPanelPage(),
    //   ),
    // );

    return false;
  }

  @override
  void initState() {
    super.initState();

    EnrollService().init().then((enrolls_value) {
      OrderService().init().then((orders_value) {
        EnrollOrderService().init().then((value) {
          var payedEnrollOrders =
              value.where((element) => element.refId != null).toList();

          var payedOrderIds = value
              .where((element) => element.refId != null)
              .toList()
              .map((e) => e.id)
              .toList();

          payedOrderIds = payedOrderIds.distinct().toList();

          var payedEnrollIds = value
              .where((element) => element.refId != null)
              .toList()
              .map((e) => e.enrollId)
              .toList();

          payedEnrollIds = payedEnrollIds.distinct().toList();

          totalToday = enrolls_value
              .where(
                (element) =>
                    element.creationDateTime
                            .difference(DateTime.now())
                            .inDays ==
                        0 &&
                    element.creationDateTime.weekday ==
                        DateTime.now().weekday &&
                    payedEnrollIds.contains(element.id),
              )
              .length;

          totalDentist = enrolls_value
              .where((element) =>
                  element.creationDateTime.difference(DateTime.now()).inDays ==
                      0 &&
                  element.creationDateTime.weekday == DateTime.now().weekday &&
                  payedEnrollIds.contains(element.id) &&
                  element.enrollType == "dentist")
              .length;

          totalInsurance = enrolls_value
              .where((element) =>
                  element.creationDateTime.difference(DateTime.now()).inDays ==
                      0 &&
                  element.creationDateTime.weekday == DateTime.now().weekday &&
                  payedEnrollIds.contains(element.id) &&
                  element.enrollType == "insurance")
              .length;

          totalRegister = payedEnrollIds.length;

          totalDentistRegister = enrolls_value
              .where(
                (element) =>
                    payedEnrollIds.contains(element.id) &&
                    element.enrollType == "dentist",
              )
              .length;

          totalIncome = orders_value
              .where((element) => payedOrderIds.contains(element.id))
              .map((e) => e.totalPayment)
              .toList()
              .reduce((sum, element) => sum + element);

          var ttls = orders_value
              .where((element) =>
                  payedOrderIds.contains(element.id) &&
                  element.creationDateTime.weekday == DateTime.now().weekday &&
                  element.creationDateTime.difference(DateTime.now()).inDays ==
                      0)
              .map((e) => e.totalPayment)
              .toList();
          totalTodayIncome = ttls.reduce((sum, element) => sum + element);

          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: WillPopScope(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "images/ballonbackground.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                top: 50.0,
              ),
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WDG_BigIconButton(
                            title: totalToday.toString(),
                            description: "ثبت نام های امروز",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            //route: AdminPresentsPage(),
                          ),
                          WDG_BigIconButton(
                            title: totalDentist.toString(),
                            description: "ثبت نام های دندانپزشکی",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            //route: AdminPresentsPage(),
                          ),
                          WDG_BigIconButton(
                            title: totalInsurance.toString(),
                            description: "ثبت نام های بیمه",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            //route: AdminPresentsPage(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WDG_BigIconButton(
                            title: totalRegister.toString(),
                            description: "تمام ثبت نام",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            //route: AdminPresentsPage(),
                          ),
                          WDG_BigIconButton(
                            title: totalDentistRegister.toString(),
                            description: "تمام ثبت نام های دندانپزشکی",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            //route: AdminPresentsPage(),
                          ),
                          WDG_BigIconButton(
                            title: totalIncome.toString(),
                            description: "درآمد کل",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            //route: AdminPresentsPage(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WDG_BigIconButton(
                            title: totalTodayIncome.toString(),
                            description: "در آمد امروز",
                            icon: Image.asset(
                              "images/familyinsurance.png",
                            ),
                            //route: AdminPresentsPage(),
                          ),
                        ],
                      ),
                    ),
                    WDG_BigBorderedGrayButton(
                      text: "نمایش جزئیات گزارش",
                      route: AdminInsuranceReportPage(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    WDG_BackIconCircle(
                      route: AdminPanelPage(),
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
