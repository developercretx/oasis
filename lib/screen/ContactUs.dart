import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oasis/components/ContactUsAddress.dart';
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/utils/App.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF3F3D3E), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomAppBar(
      fromscreen: 6,
      hasdrawer: true,
      isdark: true,
      body: Container(
        color: Colors.black87,
        child: ListView(
          children: [
            Container(
              height: height * 0.3,
              width: width,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    height: height,
                    width: width,
                    imageUrl: App.config['contactUs'][0]['img'],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  Center(
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "book",
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ...App.config['address'].map((detail) {
              return ContactUsAddress(
                details: {
                  "title": detail['title'],
                  "desc": detail['desc'],
                  "phone": detail['phone'],
                  "mail": detail['mail'],
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
      ),
    );
    super.dispose();
  }
}
