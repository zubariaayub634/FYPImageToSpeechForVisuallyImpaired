import 'package:flutter/material.dart';

class BodyText extends Text {
  BodyText(String text,
      {double size = 17.5, Color textColor = const Color(0xfffad4fa)})
      : super(
          text,
          style: TextStyle(
              color: textColor, fontSize: size, backgroundColor: Colors.black),
>>>>>>> e6bb5c50f10da166378970d96dc9ba21405d126f
          textAlign: TextAlign.center,
          //TODO: add styling for body text here
        );

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
