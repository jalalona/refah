import 'package:flutter/material.dart';
import 'package:refah/pages/clients/insurance/ClientInsuranceQuestionPage.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedGreenButton.dart';
import 'package:refah/widgets/WDG_Vector3.dart';

class InsuranceContract extends StatefulWidget {
  String title;
  String description;
  Widget vector;

  InsuranceContract({
    this.description,
    this.title,
    this.vector,
  });

  @override
  _InsuranceContractState createState() => _InsuranceContractState();
}

class _InsuranceContractState extends State<InsuranceContract> {
  bool vis = false;
  Future initContract() async {
    setState(() {
      vis = true;
    });
    var opt = await OptionService().getByName("insurance_contract");
    setState(() {
      widget.description =
          opt != null ? opt.value : "شرح مربوط به توافقنامه ...";
      vis = false;
    });
  }

  @override
  void initState() {
    super.initState();

    initContract();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: vis,
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                child: WDG_Vector3(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  widget.title ?? "توافق نامه",
                  style: TextStyle(
                    fontFamily: "IRANSans",
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                width: MediaQuery.of(context).size.width - 100.0,
                height: MediaQuery.of(context).size.height / 3.0,
                child: SingleChildScrollView(
                  child: Text(
                    widget.description ?? "شرح مربوط به توافقنامه ...",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(""),
                ),
              ),
              Container(
                child: WDG_BorderedGreenButton(
                  title: "پایان",
                  width: 200.0,
                  pop: true,
                  route: ClientInsuranceQuestionPage(
                    title: "توافقنامه بیمه تکمیلی",
                    description: "متن شرح توافق نامه و شرایط جدید",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
