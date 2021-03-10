import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/components/SizesCard.dart';
import 'package:oasis/models/SizesModel.dart';
import 'package:oasis/utils/App.dart';

class Sizes extends StatefulWidget {
  @override
  _SizesState createState() => _SizesState();
}

class _SizesState extends State<Sizes> {
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
  SizesModel _sizes;
  List<SizesModel> _sizesmodellist = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CustomAppBar(
      fromscreen: 3,
      hasdrawer: true,
      isdark: true,
      body: loading
          ? Center(
              child: ProgressLoader(
                isDark: false,
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: height * 0.07,
                    bottom: height * 0.01,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Select Your Size",
                    style: TextStyle(
                      fontFamily: "book",
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: _sizesmodellist.length,
                    itemBuilder: (context, index) => SizesCard(
                      Title: _sizesmodellist[index].width.toString() +
                          " x " +
                          _sizesmodellist[index].heigth.toString() +
                          " " +
                          _sizesmodellist[index].unit.toString(),
                      Id: _sizesmodellist[index].id,
                      img: _sizesmodellist[index].width.toString() +
                          "*" +
                          _sizesmodellist[index].heigth.toString(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: height * 0.9 / height * 0.9),
                  ),
                )
              ],
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
        App.baseUrl + 'sizes',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      Map responseMap = jsonDecode(response.body);
      print("Category Map ==> " + responseMap.toString());
      if (responseMap['Success'] == true) {
        List _temppro = [];
        _temppro = responseMap['sizes']['data'];
        print("companies ===> $_temppro");
        for (int i = 0; i < _temppro.length; i++) {
          _sizes = SizesModel.fromJson(responseMap['sizes']['data'][i]);
          _sizesmodellist.add(_sizes);
        }
        if (mounted) {
          setState(() {
            loading = false;
          });
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
