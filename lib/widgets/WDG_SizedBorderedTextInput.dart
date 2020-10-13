import 'package:flutter/material.dart';

class WDG_SizedBorderedTextInput extends StatefulWidget {
  bool isRequired;
  int min;
  int max;
  bool enabled;
  bool password;
  String hintText;
  String value;
  TextInputType inputType;
  Function(String result) onChangeCallback;
  Function(int error) onErrorCallback;

  WDG_SizedBorderedTextInput({
    this.hintText,
    this.value,
    this.inputType,
    this.onChangeCallback,
    this.password,
    this.enabled,
    this.max,
    this.isRequired,
    this.min,
    this.onErrorCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_SizedBorderedTextInputState createState() =>
      _WDG_SizedBorderedTextInputState();
}

class _WDG_SizedBorderedTextInputState
    extends State<WDG_SizedBorderedTextInput> {
  String text;
  bool isValid;
  FocusNode _focus = new FocusNode();

  bool _onFocusChange() {
    bool vld = true;
    if (widget.isRequired != null && widget.isRequired == true) {
      if (text == null || text.isEmpty) vld = false;
      if (widget.value != null && widget.value.isNotEmpty) vld = true;
    }
    // if (widget.min != null && text != null && text.length < widget.min)
    //   vld = false;
    // if (widget.max != null && text != null && text.length > widget.max)
    //   vld = false;

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

    // if (widget.isRequired != null && widget.isRequired == true) {
    //   if (widget.onErrorCallback != null) {
    //     widget.onErrorCallback(1);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 325.7,
      //height: 45.0,

      margin: EdgeInsets.only(
        left: 5.0,
        right: 5.0,
        top: 5.0,
        bottom: 5.0,
      ),
      padding: EdgeInsets.only(
        //top: 5.0,
        left: 5.0,
        right: 5.0,
        //bottom: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: const Color(0xfff6f6f6),
        border: Border.all(
          width: 1.0,
          color: isValid != null && isValid == false
              ? Colors.red
              : Color(0xffd6d6d6),
        ),
      ),
      child: TextField(
        focusNode: _focus,
        maxLength: widget.max ?? 100,
        enabled: widget.enabled ?? true,
        controller: TextEditingController(
            text:
                widget.value != null ? widget.value : text != null ? text : ""),
        obscureText: widget.password ?? false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText ?? "متن فرم",
        ),
        style: TextStyle(
          fontFamily: "IRANSans",
          fontSize: 14,
        ),
        keyboardType: widget.inputType ?? TextInputType.text,
        textAlign: TextAlign.right,
        onSubmitted: (value) {
          bool vld = true;
          if (widget.isRequired != null && widget.isRequired == true) {
            if (value.isEmpty) vld = false;
          }
          // if (widget.min != null && value.length < widget.min) vld = false;
          // if (widget.max != null && value.length > widget.max) vld = false;

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
            widget.onChangeCallback(value);
          }
        },
        onChanged: (value) {
          text = value;
          // if (widget.max != null && widget.max <= value.length) return;

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

          if (widget.onChangeCallback != null) {
            widget.onChangeCallback(value);
          }
        },
      ),
    );
  }
}
