import 'package:flutter/material.dart';

class WDG_SizedInput extends StatefulWidget {
  bool enabled;
  bool isRequired;
  int min;
  int max;
  double height;
  Function(String result) onChangeCallback;
  Function(int error) onErrorCallback;

  TextInputType inputType;
  bool password;
  String hint;
  String value;

  WDG_SizedInput({
    this.value,
    this.onChangeCallback,
    this.inputType,
    this.password = false,
    this.hint = "",
    this.enabled,
    this.isRequired,
    this.max,
    this.min,
    this.onErrorCallback,
    this.height,
    Key key,
  }) : super(key: key);

  @override
  _WDG_SizedInputState createState() => _WDG_SizedInputState();
}

class _WDG_SizedInputState extends State<WDG_SizedInput> {
  String text;
  bool isValid;

  FocusNode _focus = new FocusNode();

  bool _onFocusChange() {
    bool vld = true;
    if (widget.isRequired != null && widget.isRequired == true) {
      if (text == null || text.isEmpty) vld = false;
      if (widget.value != null && widget.value.isNotEmpty) vld = true;
    }

    setState(() {
      isValid = vld;
      if ((widget.value == null || widget.value.isEmpty) && text != null)
        widget.value = text;
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
    return _focus.hasFocus;
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5.0),
        //height: widget.height ?? 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1.0,
            color: isValid != null && isValid == false
                ? Colors.red
                : Color(0xffd6d6d6),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: TextField(
            maxLength: widget.max ?? 50,
            focusNode: _focus,
            controller: TextEditingController(
                text: widget.value != null
                    ? widget.value
                    : text != null ? text : ""),
            decoration: InputDecoration(
              hintText: widget.hint ?? "",
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 13,
              color: const Color(0xff313450),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
            keyboardType: widget.inputType ?? TextInputType.text,
            obscureText: widget.password ?? false,
            onSubmitted: (value) {
              bool vld = true;
              if (widget.isRequired != null && widget.isRequired == true) {
                if (value.isEmpty) vld = false;
              }
              if (widget.onErrorCallback != null) {
                if (vld == false) {
                  if (widget.onErrorCallback != null) {
                    widget.onErrorCallback(1);
                  }
                } else {
                  widget.onErrorCallback(0);
                }
              }
              setState(() {
                isValid = vld;
              });
            },
            onChanged: (value) {
              text = value;

              if (widget.onChangeCallback != null) {
                widget.onChangeCallback(value);
              }
            },
          ),
        ),
      ),
    );
  }
}
