import 'package:flutter/material.dart';

class BodyText extends Text {
  BodyText(String text, {double size = 12})
      : super(
          text, style: TextStyle(color: Colors.red, fontSize: size),
          textAlign: TextAlign.center,
          //TODO: add styling for body text here
        );

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
