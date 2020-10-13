import 'package:flutter/material.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedGreenButton.dart';
import 'package:refah/widgets/WDG_Vector2.dart';

import 'clients/dentistry/RegistrationChoosePage.dart';

class DentistryContract extends StatefulWidget {
  String title;
  String description;
  Widget vector;

  DentistryContract({
    this.description,
    this.title,
    this.vector,
  });

  @override
  _DentistryContractState createState() => _DentistryContractState();
}

class _DentistryContractState extends State<DentistryContract> {
  bool vis = false;
  Map<String, dynamic> values;

  Future initContract() async {
    setState(() {
      vis = true;
    });
    var opt = await OptionService().getByName("dentist_contract");
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
                child: WDG_Vector2(),
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
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                width: MediaQuery.of(context).size.width - 100.0,
                height: MediaQuery.of(context).size.height / 3,
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
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  child: Text(""),
                ),
              ),
              Container(
                child: WDG_BorderedGreenButton(
                  title: "پایان",
                  pop: true,
                  width: 200.0,
                  route: RegisterationChoosePage(
                    title: "توافقنامه دندانپزشکی",
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
