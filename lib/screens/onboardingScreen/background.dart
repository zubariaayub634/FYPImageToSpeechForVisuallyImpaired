import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Column(
        children: <Widget>[
          //Positioned(
          // top: 130,
          //left: 0,
          Image.asset(
            "assets/onboardingLogo.png",
            height: 380,
            width: 100, // * 0.35,
          ),
          //),
        ],
      ),
    );
  }
}
