import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/EnrollOrderVM.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/OrderVM.dart';
import 'package:refah/services/EnrollOrderService.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OrderService.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BorderedGrayButton.dart';
import 'package:refah/widgets/WDG_BorderedGreenButton.dart';
import 'package:refah/widgets/WDG_ReportUserItem.dart';
import 'package:refah/widgets/WDG_SearchInput.dart';
import 'Registeration/AdminUserRegisterPage.dart';

class AdminInsuranceReportPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminInsuranceReportPage({
    this.description,
    this.title,
  });

  @override
  _AdminInsuranceReportPageState createState() =>
      _AdminInsuranceReportPageState();
}

class _AdminInsuranceReportPageState extends State<AdminInsuranceReportPage>
    with WidgetsBindingObserver {
  List<Widget> list = List<Widget>();
  bool vis = false;
  int step = 1;
  List<EnrollVM> enrolls = List<EnrollVM>();
  List<OrderVM> orders = List<OrderVM>();
  List<EnrollOrderVM> eorders = List<EnrollOrderVM>();

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);

    return false;
  }

  Future<List<EnrollVM>> initReport(int state) async {
    enrolls = await EnrollService().init();
    orders = await OrderService().init();
    eorders = await EnrollOrderService().init();

    var oks = eorders.where((element) => element.refId != null).toList();
    var eids = oks.map((e) => e.enrollId).toList();
    var eoids = eorders.map((e) => e.orderId).toList();

    switch (state) {
      case 1:
        return enrolls
            .where((element) =>
                element.enrollType == "dentist" &&
                element.creationDateTime.difference(DateTime.now()).inDays == 0)
            .toList();
      case 2:
        return enrolls
            .where((element) =>
                element.enrollType == "insurance" &&
                element.creationDateTime.difference(DateTime.now()).inDays == 0)
            .toList();
      case 3:
        return enrolls
            .where((element) =>
                element.enrollType == "insurance" &&
                element.creationDateTime.difference(DateTime.now()).inDays <= 7)
            .toList();
      case 4:
        return enrolls
            .where((element) =>
                element.enrollType == "dentist" &&
                element.creationDateTime.difference(DateTime.now()).inDays <= 7)
            .toList();
      case 5:
        var dpaid = enrolls
            .where((element) =>
                element.enrollType == "dentist" &&
                element.creationDateTime.difference(DateTime.now()).inDays <=
                    30 &&
                eorders.indexWhere((e) =>
                        e.enrollId == element.id &&
                        e.refId != null &&
                        e.refId.isNotEmpty) >=
                    0)
            .toList();
        return dpaid;
      case 6:
        var dp = enrolls
            .where((element) =>
                element.enrollType == "dentist" &&
                element.creationDateTime.difference(DateTime.now()).inDays <=
                    30 &&
                eorders.indexWhere((e) =>
                        e.enrollId == element.id &&
                        e.refId != null &&
                        e.refId.isNotEmpty) >=
                    0)
            .toList();

        var ntnl = dp.map((e) => e.nationalId).toList();

        var dunpaid = enrolls
            .where(
              (element) =>
                  element.enrollType == "dentist" &&
                  element.creationDateTime.difference(DateTime.now()).inDays <=
                      30 &&
                  !ntnl.contains(element.nationalId) &&
                  (eorders.indexWhere((e) =>
                              e.enrollId == element.id &&
                              (e.refId == null || e.refId.isEmpty)) >=
                          0 ||
                      eorders.indexWhere((e) => e.enrollId == element.id) ==
                          -1),
            )
            .toList();
        return dunpaid;
      case 7:
        var ipaid = enrolls
            .where((element) =>
                element.enrollType == "insurance" &&
                element.creationDateTime.difference(DateTime.now()).inDays <=
                    30 &&
                eorders.indexWhere((e) =>
                        e.enrollId == element.id &&
                        e.refId != null &&
                        e.refId.isNotEmpty) >=
                    0)
            .toList();
        return ipaid;
      case 8:
        var ipaid = enrolls
            .where((element) =>
                element.enrollType == "insurance" &&
                element.creationDateTime.difference(DateTime.now()).inDays <=
                    30 &&
                eorders.indexWhere((e) =>
                        e.enrollId == element.id &&
                        e.refId != null &&
                        e.refId.isNotEmpty) >=
                    0)
            .toList();

        var itl = ipaid.map((e) => e.nationalId).toList();

        var iunpaid = enrolls
            .where(
              (element) =>
                  element.enrollType == "insurance" &&
                  element.creationDateTime.difference(DateTime.now()).inDays <=
                      30 &&
                  !itl.contains(element.nationalId) &&
                  (eorders.indexWhere((e) =>
                              e.enrollId == element.id &&
                              (e.refId == null || e.refId.isEmpty)) >=
                          0 ||
                      eorders.indexWhere((e) => e.enrollId == element.id) ==
                          -1),
            )
            .toList();
        return iunpaid;
      default:
        return enrolls
            .where((element) =>
                element.enrollType == "dentist" &&
                element.creationDateTime.difference(DateTime.now()).inDays == 0)
            .toList();
    }

    // totalRegister = oks?.length ?? 0;

    // totalDentistRegister = enrolls_value
    //     .where(
    //       (element) =>
    //           eids.contains(element.id) && element.enrollType == "dentist",
    //     )
    //     .length;

    // totalIncome = orders_value
    //     .where((element) => eoids.contains(element.id))
    //     .map((e) => e.totalPayment)
    //     .toList()
    //     .reduce((sum, element) => sum + element);

    // totalTodayIncome = orders_value
    //     .where((element) =>
    //         eoids.contains(element.id) &&
    //         element.creationDateTime == DateTime.now())
    //     .map((e) => e.totalPayment)
    //     .toList()
    //     .reduce((sum, element) => sum + element);

    //setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //   UserService().init().then((value) {
    //     setState(() {
    //       list = UserService().getUserWidgetList(context);
    //     });
    //   });

    //   UserService().setRefreshCallback((result) {
    //     UserService().init().then((value) {
    //       setState(() {
    //         list = UserService().getUserWidgetList(context);
    //       });
    //     });
    //   });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed) {
    //   // UserService().init().then((value) {
    //   //   setState(() {
    //   //     list = UserService().getUserWidgetList(context);
    //   //   });
    //   // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                height: 50.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    WDG_BorderedGreenButton(
                      fontSize: 11,
                      title: "دندانپزشکی امروز",
                      onTapCallback: (result) {
                        step = 1;
                        setState(() {});
                      },
                    ),
                    WDG_BorderedGreenButton(
                      fontSize: 11,
                      title: "بیمه تکمیلی امروز",
                      onTapCallback: (result) {
                        step = 2;
                        setState(() {});
                      },
                    ),
                    WDG_BorderedGreenButton(
                      fontSize: 11,
                      title: "بیمه تکمیلی هفته",
                      onTapCallback: (result) {
                        step = 3;
                        setState(() {});
                      },
                    ),
                    WDG_BorderedGreenButton(
                      fontSize: 11,
                      title: "دندانپزشکی هفته",
                      onTapCallback: (result) {
                        step = 4;
                        setState(() {});
                      },
                    ),
                    WDG_BorderedGreenButton(
                      fontSize: 11,
                      title: "دندانپزشکی پرداخت شده",
                      onTapCallback: (result) {
                        step = 5;
                        setState(() {});
                      },
                    ),
                    WDG_BorderedGreenButton(
                      fontSize: 11,
                      title: "دندانپزشکی پرداخت نشده",
                      onTapCallback: (result) {
                        step = 6;
                        setState(() {});
                      },
                    ),
                    WDG_BorderedGreenButton(
                      fontSize: 11,
                      title: "تکمیلی پرداخت شده",
                      onTapCallback: (result) {
                        step = 7;
                        setState(() {});
                      },
                    ),
                    WDG_BorderedGreenButton(
                      fontSize: 11,
                      title: "تکمیلی پرداخت نشده",
                      onTapCallback: (result) {
                        step = 8;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10.0),
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
                  child: FutureBuilder(
                    future: initReport(step),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return WDG_ReportUserItem(
                                obj: snapshot.data[index],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
