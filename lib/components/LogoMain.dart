import 'package:flutter/material.dart';
import 'package:oasis/screen/HomeScreen.dart';

class LogoMain extends StatelessWidget {
  final double height;
  final double width;

  const LogoMain({Key key, this.height = 150, this.width = 150})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/logo.png"),
          ),
        ),
      ),
    );
  }
}
