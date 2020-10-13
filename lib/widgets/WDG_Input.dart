import 'package:flutter/material.dart';

class WDG_Input extends StatefulWidget {
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

  WDG_Input({
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
  _WDG_InputState createState() => _WDG_InputState();
}

class _WDG_InputState extends State<WDG_Input> {
  String text;
  bool isValid;

  FocusNode _focus = new FocusNode();

  bool _onFocusChange() {
    bool vld = true;
    if (widget.isRequired != null && widget.isRequired == true) {
      if (text == null || text.isEmpty) vld = false;
      if (widget.value != null && widget.value.isNotEmpty) vld = true;
    }
    if (widget.min != null && text != null && text.length < widget.min)
      vld = false;
    if (widget.max != null && text != null && text.length > widget.max)
      vld = false;

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
    return Flexible(
      child: Container(
        margin: EdgeInsets.all(5.0),
        height: widget.height ?? 40.0,
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
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          child: TextField(
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
              if (widget.min != null && value.length < widget.min) vld = false;
              if (widget.max != null && value.length > widget.max) vld = false;
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
              if (widget.max != null && widget.max <= value.length) return;

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
