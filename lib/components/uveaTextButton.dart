import 'package:flutter/material.dart';

class UveaTextButton extends MaterialButton {
  UveaTextButton(String text, {Function onPressed})
      : super(
          child: Text(
            text, //TODO: add text styling for text buttons here
          ),
          color: Colors.red, //TODO: change color of text buttons here
          onPressed: onPressed,
        );

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
