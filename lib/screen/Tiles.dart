import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/components/TilesCard.dart';
import 'package:oasis/models/Products.model.dart';
import 'package:oasis/models/TilesModel.dart';
import 'package:oasis/utils/App.dart';

class Tiles extends StatefulWidget {
  final int Id;
  final Products_model model;

  const Tiles({Key key, this.Id, this.model}) : super(key: key);

  @override
  _TilesState createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  bool isempty = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF3F3D3E), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
    getSizeList();
  }

  bool loading = false;
  TilesModel _tiles;
  List<TilesModel> _tilesmodelList = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CustomAppBar(
      fromscreen: 3,
      hasdrawer: false,
      isdark: true,
      goback: true,
      body: loading
          ? Center(
              child: ProgressLoader(
                isDark: false,
              ),
            )
          : isempty
              ? Center(
                  child: Text(
                    "No Tiles Founded",
                    style: TextStyle(fontFamily: "book"),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/background.png"),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: height * 0.07,
                          bottom: height * 0.01,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Products",
                          style: TextStyle(
                            fontFamily: "book",
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: _tilesmodelList.length,
                          itemBuilder: (context, index) => TilesCard(
                            Id: _tilesmodelList[index].id,
                            Title: _tilesmodelList[index].code,
                            imUrl: _tilesmodelList[index].imgurl,
                            model: widget.model,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio:
                                      height * 0.9 / height * 0.9),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }

  Future getSizeList() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    try {
      var response = await http.get(
        App.baseUrl + 'products/series/' + widget.Id.toString(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      Map responseMap = jsonDecode(response.body);
      print("Category Map ==> " + responseMap.toString());
      if (responseMap['Success'] == true) {
        List _temppro = [];
        _temppro = responseMap['produts'];
        if (_temppro.length > 0) {
          for (int i = 0; i < _temppro.length; i++) {
            _tiles = TilesModel.fromJson(responseMap['produts'][i]);
            _tilesmodelList.add(_tiles);
          }
          if (mounted) {
            setState(() {
              loading = false;
              isempty = false;
            });
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
        statusBarColor: Color(0xFF3F3D3E), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
  }
}
