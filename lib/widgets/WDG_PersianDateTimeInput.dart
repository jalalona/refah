import 'package:flutter/material.dart';
import 'package:jalali_calendar/jalali_calendar.dart';

class WDG_PersianDateTimeInput extends StatefulWidget {
  bool isRequired;
  Function(String result) onChangeCallback;
  Function(int error) onErrorCallback;
  String hint;
  String value;
  bool enabled;
  bool birthday;

  WDG_PersianDateTimeInput({
    this.value,
    this.onChangeCallback,
    this.hint = "",
    this.isRequired,
    this.onErrorCallback,
    this.enabled,
    this.birthday,
    Key key,
  }) : super(key: key);

  @override
  _WDG_PersianDateTimeInputState createState() =>
      _WDG_PersianDateTimeInputState();
}

class _WDG_PersianDateTimeInputState extends State<WDG_PersianDateTimeInput> {
  bool isValid;
  //DateTime dt;
  Future _selectDate() async {
    String picked = await jalaliCalendarPicker(
        context: context,
        selectedFormat: "yyyy-mm-dd",
        convertToGregorian: false);
    if (picked != null) {
      widget.value = picked.toString();
      //dt = DateTime.parse(picked.toString());
    }
    setState(() {
      widget.hint = picked.toString();
    });

    bool vld = true;
    if (widget.isRequired != null && widget.isRequired == true) {
      if (picked.isEmpty) vld = false;
    }

    setState(() {
      isValid = vld;
    });

    if (widget.onErrorCallback != null) {
      if (vld == false) {
        if (widget.onErrorCallback != null) {
          widget.onErrorCallback(1);
        }
      } else {
        widget.onErrorCallback(0);
      }
    }

    if (widget.onChangeCallback != null) {
      widget.onChangeCallback(widget.value);
    }
  }

  @override
  void initState() {
    super.initState();

    // if (widget.isRequired != null && widget.isRequired == true) {
    //   if (widget.onErrorCallback != null) {
    //     widget.onErrorCallback(1);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(5.0),
        height: 46.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1.0,
            color: isValid != null && isValid == false
                ? Colors.red
                : Color(0xffd6d6d6),
          ),
        ),
        child: Center(
          child: Text(
            widget.hint != null && widget.hint.isNotEmpty
                ? widget.hint
                : widget.value != null && widget.value.isNotEmpty
                    ? widget.value.toString()
                    : widget.birthday != null && widget.birthday == true
                        ? "تاریخ تولد "
                        : "انتخاب تاریخ",
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 14,
              color: const Color(0xff313450),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () async {
        if (widget.enabled == null || widget.enabled == true) {
          await _selectDate();
        }
      },
    );
  }
}
