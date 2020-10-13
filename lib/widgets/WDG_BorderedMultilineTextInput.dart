import 'package:flutter/material.dart';

class WDG_BorderedMultilineTextInput extends StatefulWidget {
  bool isRequired;
  String value;
  int minLines;
  int maxLines;
  double height;
  bool expandable;
  String hintText;
  Function(String result) onChangeCallback;
  Function(int error) onErrorCallback;

  WDG_BorderedMultilineTextInput({
    this.value,
    this.height = 150.0,
    this.minLines = 3,
    this.maxLines = 10,
    this.expandable = false,
    this.hintText,
    this.onChangeCallback,
    this.isRequired,
    this.onErrorCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_BorderedMultilineTextInputState createState() =>
      _WDG_BorderedMultilineTextInputState();
}

class _WDG_BorderedMultilineTextInputState
    extends State<WDG_BorderedMultilineTextInput> {
  bool isValid;
  String text;

  FocusNode _focus = new FocusNode();

  bool _onFocusChange() {
    bool vld = true;
    if (widget.isRequired != null && widget.isRequired == true) {
      if (text == null || text.isEmpty) vld = false;
      if (widget.value != null && widget.value.isNotEmpty) vld = true;
    }

    setState(() {
      isValid = vld;
      if (text != null && text.length > 0) {
        widget.value = text;
      } else if ((widget.value == null || widget.value.isEmpty) && text != null)
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
      height: widget.height ?? 150.0,
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
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
        controller: TextEditingController(
            text:
                widget.value != null ? widget.value : text != null ? text : ""),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText ?? "متن فرم",
        ),
        style: TextStyle(
          fontFamily: "IRANSans",
          fontSize: 14,
        ),
        minLines: widget.minLines ?? 3,
        maxLines: widget.maxLines ?? 10,
        //expands: expandable ?? true,
        keyboardType: TextInputType.multiline,
        textAlign: TextAlign.right,
        onChanged: (value) {
          text = value;
          bool vld = true;
          if (widget.isRequired != null && widget.isRequired == true) {
            if (value.isEmpty) vld = false;
          }

          // setState(() {
          //   isValid = vld;
          // });

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
