import 'package:flutter/material.dart';
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/footer.dart';
import 'package:oasis/screen/AboutUs.dart';
import 'package:oasis/screen/ContactUs.dart';
import 'package:oasis/screen/Downloads.dart';
import 'package:oasis/screen/Gallary.dart';
import 'package:oasis/screen/HomeScreen.dart';
import 'package:oasis/screen/Size.dart';

class CustomDrawer extends StatelessWidget {
  final int fromScreen;

  const CustomDrawer({Key key, this.fromScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomAppBar(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/background.png"),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: height * 0.08),
              child: FlatButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return HomeScreen();
                      },
                      transitionsBuilder:
                          (context, animation1, animation2, child) {
                        return FadeTransition(
                          opacity: animation1,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                    ),
                  );
                },
                child: Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fromScreen == 1 ? "book" : "thin",
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.04),
              child: FlatButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return AboutUs();
                      },
                      transitionsBuilder:
                          (context, animation1, animation2, child) {
                        return FadeTransition(
                          opacity: animation1,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                    ),
                  );
                },
                child: Text(
                  "About Us",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fromScreen == 2 ? "book" : "thin",
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.04),
              child: FlatButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return Sizes();
                      },
                      transitionsBuilder:
                          (context, animation1, animation2, child) {
                        return FadeTransition(
                          opacity: animation1,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                    ),
                  );
                },
                child: Text(
                  "Product",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fromScreen == 3 ? "book" : "thin",
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.04),
              child: FlatButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return Gallary();
                      },
                      transitionsBuilder:
                          (context, animation1, animation2, child) {
                        return FadeTransition(
                          opacity: animation1,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                    ),
                  );
                },
                child: Text(
                  "Gallery",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fromScreen == 4 ? "book" : "thin",
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.04),
              child: FlatButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return Downloads();
                      },
                      transitionsBuilder:
                          (context, animation1, animation2, child) {
                        return FadeTransition(
                          opacity: animation1,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                    ),
                  );
                },
                child: Text(
                  "Download",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fromScreen == 5 ? "book" : "thin",
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.04),
              child: FlatButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return ContactUs();
                      },
                      transitionsBuilder:
                          (context, animation1, animation2, child) {
                        return FadeTransition(
                          opacity: animation1,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                    ),
                  );
                },
                child: Text(
                  "Contact",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: fromScreen == 6 ? "book" : "thin",
                      fontSize: 25),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.07),
              alignment: Alignment.bottomCenter,
              child: footer(),
            )
          ],
        ),
      ),
      fromscreen: fromScreen,
      hasdrawer: false,
      isdark: false,
    );
  }
}
