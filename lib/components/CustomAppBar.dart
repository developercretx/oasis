import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis/screen/AboutUs.dart';
import 'package:oasis/screen/ContactUs.dart';
import 'package:oasis/screen/Downloads.dart';
import 'package:oasis/screen/Gallary.dart';
import 'package:oasis/screen/HomeScreen.dart';
import 'package:oasis/screen/Size.dart';
import 'package:oasis/utils/App.dart';
import 'package:oasis/utils/MyBehaviour.dart';

import 'CustomDrawer.dart';
import 'LogoMain.dart';

class CustomAppBar extends StatelessWidget {
  final bool isdark;
  final bool hasdrawer;
  final bool goback;
  final Widget body;
  final int fromscreen;

  const CustomAppBar(
      {Key key,
      this.isdark,
      this.hasdrawer,
      this.body,
      this.fromscreen,
      this.goback = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: isdark ? Color(0xFF3F3D3E) : Colors.white,
                  padding: EdgeInsets.only(top: height * 0.055),
                  child: ListTile(
                    leading: hasdrawer
                        ? Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: isdark ? Colors.white : Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return CustomDrawer(
                                        fromScreen: fromscreen,
                                      );
                                    },
                                    transitionsBuilder: (context, animation1,
                                        animation2, child) {
                                      return FadeTransition(
                                        opacity: animation1,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        Duration(milliseconds: 100),
                                  ),
                                );
                              },
                            ),
                            decoration: BoxDecoration(),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.close,
                              color: isdark ? Colors.white : Colors.black,
                            ),
                            onPressed: goback
                                ? () {
                                    Navigator.pop(context);
                                  }
                                : () {
                                    if (fromscreen == 1) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return HomeScreen();
                                          },
                                          transitionsBuilder: (context,
                                              animation1, animation2, child) {
                                            return FadeTransition(
                                              opacity: animation1,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 100),
                                        ),
                                      );
                                    } else if (fromscreen == 2) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return AboutUs();
                                          },
                                          transitionsBuilder: (context,
                                              animation1, animation2, child) {
                                            return FadeTransition(
                                              opacity: animation1,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 100),
                                        ),
                                      );
                                    } else if (fromscreen == 3) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return Sizes();
                                          },
                                          transitionsBuilder: (context,
                                              animation1, animation2, child) {
                                            return FadeTransition(
                                              opacity: animation1,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 100),
                                        ),
                                      );
                                    } else if (fromscreen == 4) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return Gallary();
                                          },
                                          transitionsBuilder: (context,
                                              animation1, animation2, child) {
                                            return FadeTransition(
                                              opacity: animation1,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 100),
                                        ),
                                      );
                                    } else if (fromscreen == 5) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return Downloads();
                                          },
                                          transitionsBuilder: (context,
                                              animation1, animation2, child) {
                                            return FadeTransition(
                                              opacity: animation1,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 100),
                                        ),
                                      );
                                    } else if (fromscreen == 6) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return ContactUs();
                                          },
                                          transitionsBuilder: (context,
                                              animation1, animation2, child) {
                                            return FadeTransition(
                                              opacity: animation1,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 100),
                                        ),
                                      );
                                    }
                                  },
                          ),
                  ),
                ),
                Expanded(child: body),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.05),
                child: Card(
                  elevation: 10,
                  child: LogoMain(
                    height: height * 0.09,
                    width: height * 0.09,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
