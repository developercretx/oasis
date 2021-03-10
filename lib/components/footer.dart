import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oasis/utils/App.dart';
import 'package:url_launcher/url_launcher.dart';

class footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
            ),
            onPressed: () async {
              var url =
                  App.config['social']['facebook'] ?? 'http://www.facebook.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.twitter,
              color: Colors.white,
            ),
            onPressed: () async {
              var url =
                  App.config['social']['twitter'] ?? 'http://www.twitter.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
            ),
            onPressed: () async {
              var url = App.config['social']['instagram'] ??
                  'http://www.instagram.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.youtube,
              color: Colors.white,
            ),
            onPressed: () async {
              var url =
                  App.config['social']['youtube'] ?? 'http://www.youtube.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          )
        ],
      ),
    );
  }
}
