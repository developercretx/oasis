import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/components/SeriesDisplay.dart';
import 'package:oasis/models/Products.model.dart';
import 'package:oasis/utils/App.dart';

class SliderSizes extends StatefulWidget {
  final String Title;

  const SliderSizes({Key key, this.Title}) : super(key: key);

  @override
  _SliderSizesState createState() => _SliderSizesState();
}

class _SliderSizesState extends State<SliderSizes> {
  bool loading = false;
  bool isempty = false;
  Products_model _products;
  List<Products_model> _listproduct = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF3F3D3E), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomAppBar(
      isdark: true,
      hasdrawer: false,
      goback: true,
      fromscreen: 3,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/background.png"),
          ),
        ),
        child: loading
            ? Center(
                child: ProgressLoader(
                  isDark: true,
                ),
              )
            : isempty
                ? Center(
                    child: Text(
                      "No Item Found",
                      style: TextStyle(
                          fontFamily: "book",
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  )
                : Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: height * 0.08,
                          bottom: height * 0.02,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.Title,
                          style: TextStyle(
                              fontFamily: "book",
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _listproduct.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SeriesDisplay(
                              spacing: false,
                              imgurl: _listproduct[index].imageurl,
                              title: _listproduct[index].size,
                              Id: _listproduct[index].id,
                              model: _listproduct[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Future getProductList() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    try {
      var response = await http.get(
        App.baseUrl + 'series/name/' + widget.Title.toString(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      Map responseMap = jsonDecode(response.body);
      print("Category Map ==> " + responseMap.toString());
      if (responseMap['Success'] == true) {
        List _temppro = [];
        _temppro = responseMap['series'];
        if (_temppro.length > 0) {
          for (int i = 0; i < _temppro.length; i++) {
            _products = Products_model.fromJson(responseMap['series'][i]);
            _listproduct.add(_products);
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
