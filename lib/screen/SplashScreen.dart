import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;

import 'package:oasis/components/LogoMain.dart';
import 'package:oasis/screen/HomeScreen.dart';
import 'package:oasis/utils/App.dart';
import 'package:oasis/utils/MyBehaviour.dart';
import 'package:http/http.dart' as http;

import 'main_web_view_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainWebViewHome(),
        ),
      );
    });
    // fetchData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF3f3d3e),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/background.png"),
          ),
        ),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child: Image.asset("images/circle.png"),
                    transform:
                        Matrix4.translationValues(0.0, -height * 0.25, 0.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.4),
                    alignment: Alignment.center,
                    child: LogoMain(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.9),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "www.Oasis.com",
                      style: TextStyle(color: Colors.white, fontFamily: "thin"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void fetchData() async {
    print("Here Function01");
    http.get("http://cms.oasis.cretxinc.com/config.json").then((value) {
      var jsonResponse = convert.jsonDecode(value.body);
      setState(() {
        App.config = jsonResponse;
      });
      print(App.config);
      print("Here Function02");
      http.get("http://cms.oasis.cretxinc.com/sliders.json").then((jsonData) {
        var jsonResponse = convert.jsonDecode(jsonData.body);
        setState(() {
          App.sliders = jsonResponse;
        });
        print("SLider Here");
        print(App.sliders);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }).catchError((err) {
        print("err" + err.toString());
      });
    }).catchError((err) {
      fetchData();
      print("err" + err.toString());
    });
  }
}
