import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oasis/screen/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
