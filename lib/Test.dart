import 'package:flutter/material.dart';
import 'package:oasis/components/LogoMain.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Build"),
      ),
      body: Center(
        child: LogoMain(),
      ),
    );
  }
}
