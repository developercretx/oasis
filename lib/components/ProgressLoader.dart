import 'package:flutter/material.dart';

class ProgressLoader extends StatelessWidget {
  final bool isDark;

  const ProgressLoader({Key key, this.isDark = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color progress = isDark ? Colors.white : Color(0xFF3F3D3E);
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(progress),
    );
  }
}
