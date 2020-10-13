import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/EnrollOrderVM.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/OrderVM.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';
import 'package:refah/pages/admin/AdminProccessSuccessPage.dart';
import 'package:refah/pages/admin/Registeration/AdminDentistryRegisterPage.dart';
import 'package:refah/services/EnrollOrderService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/services/OrderService.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_UploadBorderedInput.dart';

class AdminDentistryUploadPage extends StatefulWidget {
  String title;
  String description;
  EnrollVM obj;
  Widget route;
  Function(dynamic result) onUploadComplatedCallback;
  String cost = "";

  Widget content;

  AdminDentistryUploadPage({
    this.obj,
    this.route,
    this.onUploadComplatedCallback,
    this.description,
    this.title,
  });

  @override
  _AdminDentistryUploadPageState createState() =>
      _AdminDentistryUploadPageState();
}

class _AdminDentistryUploadPageState extends State<AdminDentistryUploadPage> {
  int isValid = 0;
  String _cost = "0";

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminDentistryRegisteryPage(),
    //   ),
    // );

    return false;
  }

  @override
  void initState() {
    super.initState();

    OptionService().getByName("dentist_one_cost").then((value) {
      setState(() {
        _cost = value.value;
        widget.cost = value?.value ?? "";
        widget.cost += " ریال";
      });
    });
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
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: 50.0,
                        left: 10.0,
                        right: 10.0,
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
                      child: Column(
                        children: <Widget>[
                          WDG_UploadBorderedInput(
                            // isRequired: true,
                            // onErrorCallback: (error) {
                            //   isValid = error;
                            // },
                            fileName: "عکس پرسنلی",
                            obj: widget.obj,
                            property: "avatar",
                            onTapCallback: (result) {
                              // method
                            },
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          WDG_BorderedTextInput(
                            value: widget.cost ?? "",
                            hintText: "مبلغ هزینه",
                            onChangeCallback: (result) {
                              widget.cost = result;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              WDG_FooterConfirmCancel(
                //confirmRoute: AdminProccessSuccessPage(),
                confirmCallback: (result) async {
                  if (isValid > 0) return;
                  if (widget.cost != null && widget.cost.isNotEmpty) {
                    OrderVM order = OrderVM(
                      authority: "admin",
                      orderCode: "admin_" +
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      totalPayment: int.parse(_cost),
                      transactionCode: "admin",
                      userCreatedId: ProfileService().getUserData().id,
                    );

                    var result = await OrderService().add(order);

                    if (result != null) {
                      EnrollOrderVM eo = EnrollOrderVM(
                        enrollId: widget.obj.id,
                        orderId: result.id,
                      );

                      var eoResult = await EnrollOrderService().add(eo);

                      if (eoResult != null) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminProccessSuccessPage(),
                          ),
                        );
                      }
                    }
                  }
                },
                cancelRoute: AdminPanelPage(),
              ),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
