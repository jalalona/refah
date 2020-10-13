import 'package:flutter/material.dart';

class WDG_TwoLableBorderedTextInput extends StatefulWidget {
  bool isRequired;
  int min;
  int max;
  String value;
  String hintText;
  String leftText;
  String rightText;
  TextInputType inputType;
  Function(String result) onChangeCallback;
  Function(int error) onErrorCallback;

  WDG_TwoLableBorderedTextInput({
    this.value,
    this.hintText,
    this.leftText,
    this.rightText,
    this.inputType,
    this.onChangeCallback,
    this.isRequired,
    this.max,
    this.min,
    this.onErrorCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_TwoLableBorderedTextInputState createState() =>
      _WDG_TwoLableBorderedTextInputState();
}

class _WDG_TwoLableBorderedTextInputState
    extends State<WDG_TwoLableBorderedTextInput> {
  bool isValid;
  String text;

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
      if (widget.value == null) widget.value = text;
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
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      //height: 60.0,
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
      child: Row(
        children: <Widget>[
          Text(
            widget.leftText ?? 'IR',
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 14,
              color: const Color(0xff707070),
            ),
            textAlign: TextAlign.left,
          ),
          Expanded(
            child: TextField(
              focusNode: _focus,
              controller: TextEditingController(
                  text: widget.value != null
                      ? widget.value
                      : text != null ? text : ""),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText ?? "متن فرم",
              ),
              style: TextStyle(
                fontFamily: "IRANSans",
                fontSize: 14,
              ),
              keyboardType: widget.inputType ?? TextInputType.number,
              maxLength: 24,
              textAlign: TextAlign.right,
              onSubmitted: (value) {
                bool vld = true;
                if (widget.isRequired != null && widget.isRequired == true) {
                  if (value.isEmpty) vld = false;
                }
                if (widget.min != null && value.length < widget.min)
                  vld = false;
                if (widget.max != null && value.length > widget.max)
                  vld = false;

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
          Text(
            widget.rightText ?? 'شباء',
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 14,
              color: const Color(0xff898a8f),
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
