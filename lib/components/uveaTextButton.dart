import 'package:flutter/material.dart';

class UveaTextButton extends MaterialButton {
  UveaTextButton(String text, {Function onPressed})
      : super(
          child: Text(text, //TODO: add text styling for text buttons here
              style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          height: 45,
          minWidth: 180,
          color: Color(0xff1761a0), //TODO: change color of text buttons here
          onPressed: onPressed,
        );

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
