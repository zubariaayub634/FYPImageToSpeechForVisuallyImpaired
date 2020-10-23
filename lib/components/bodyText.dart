import 'package:flutter/material.dart';

class BodyText extends Text {
  BodyText(
    String text,
  ) : super(
          text,
          style: TextStyle(
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
          //TODO: add styling for body text here
        );

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
