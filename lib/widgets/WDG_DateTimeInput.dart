import 'package:flutter/material.dart';
import 'package:jalali_calendar/jalali_calendar.dart';

class WDG_DateTimeInput extends StatefulWidget {
  bool isRequired;
  Function(DateTime result) onChangeCallback;
  Function(int error) onErrorCallback;
  String hint;
  DateTime value;

  WDG_DateTimeInput({
    this.value,
    this.onChangeCallback,
    this.hint = "",
    this.isRequired,
    this.onErrorCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_DateTimeInputState createState() => _WDG_DateTimeInputState();
}

class _WDG_DateTimeInputState extends State<WDG_DateTimeInput> {
  bool isValid;
  DateTime dt;
  Future _selectDate() async {
    String picked = await jalaliCalendarPicker(
        context: context,
        convertToGregorian: true); // نمایش خروجی به صورت میلادی
    if (picked != null) {
      widget.value = DateTime.parse(picked.toString());
      dt = DateTime.parse(picked.toString());
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
                : dt != null
                    ? dt.toString()
                    : widget.value != null
                        ? widget.value.toString()
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
        await _selectDate();
      },
    );
  }
}
