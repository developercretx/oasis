import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/GallaryItems.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/models/GalleryModel.dart';
import 'package:oasis/utils/App.dart';

class Gallary extends StatefulWidget {
  @override
  _GallaryState createState() => _GallaryState();
}

class _GallaryState extends State<Gallary> {
  bool loading = false;
  bool isempty = false;
  GalleryModel _gallary;
  List<GalleryModel> _listgallery = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF3F3D3E), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomAppBar(
      isdark: true,
      hasdrawer: true,
      fromscreen: 4,
      body: loading
          ? Center(
            child: ProgressLoader(
                isDark: false,
              ),
          )
          : Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: height * 0.08,
                      bottom: height * 0.02,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                          fontFamily: "book",
                          color: Colors.black,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _listgallery.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GallaryItems(
                          title: _listgallery[index].title,
                          imgurl: _listgallery[index].imgurl,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future getImages() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    try {
      var response = await http.get(
        App.baseUrl + 'gallarys',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      Map responseMap = jsonDecode(response.body);
      print("Category Map ==> " + responseMap.toString());
      if (responseMap['Success'] == true) {
        List _temppro = [];
        _temppro = responseMap['gallary'];
        if (_temppro.length > 0) {
          for (int i = 0; i < _temppro.length; i++) {
            _gallary = GalleryModel.fromJson(responseMap['gallary'][i]);
            _listgallery.add(_gallary);
            if (mounted) {
              setState(() {
                loading = false;
                isempty = false;
              });
            }
          }
        } else {
          if (mounted) {
            setState(() {
              loading = false;
              isempty = true;
            });
          }
        }
      } else {
        print("Wrong");
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      }
    } catch (err) {
      print("Error on Category Fetching ==> " + err.toString());
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
      ),
    );
  }
}
