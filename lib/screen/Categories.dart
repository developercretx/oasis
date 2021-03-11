import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/components/SeriesDisplay.dart';
import 'package:oasis/models/Products.model.dart';
import 'package:oasis/utils/App.dart';

class CategoryScreen extends StatefulWidget {
  int id = 6;

  CategoryScreen({Key key, this.id}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List list = [
    {
      "id": "1",
      "title": "Slab",
      "size": ["1600x800"]
    },
    {
      "id": "2",
      "title": "Full Body",
      "size": ["600x600", "1200x600"]
    },
    {
      "id": "3",
      "title": "Double Charge",
      "size": ["800x800", "600x600"]
    },
    {
      "id": "4",
      "title": "Pgvt Gvt",
      "size": ["1200x600", "600x600"]
    },
    {
      "id": "5",
      "title": "Wall Tiles",
      "size": ["300x600", "300x450", "250x357"]
    },
    {
      "id": "6",
      "title": "Parking Tiles",
      "size": ["400x400", "300x300"]
    },
    {
      "id": "7",
      "title": "Floor Tiles",
      "size": ["600x600"]
    },
    {
      "id": "8",
      "title": "Soluble Salt",
      "size": ["600x600"]
    },

    // "Slab",
    // "Full Body",
    // "Double Charge",
    // "Pgvt Gvt",
    // "Wall Tiles",
    // "Parking Tiles",
    // "Floor Tiles",
    // "Soluble Salt"
  ];
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
    // getSizeList();
    getProductList();
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CustomAppBar(
      fromscreen: 3,
      hasdrawer: true,
      isdark: true,
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SeriesDisplay(
                              imgurl: _listproduct[index].imageurl,
                              title: list[index]["title"],
                              Id: _listproduct[index].id,
                              model: _listproduct[index],
                              cId: list[index]["id"],
                              sizes: list[index]["size"],
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
        App.baseUrl + 'series/size/6',
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
        statusBarColor: Color(0xFF3F3D3E), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
  }
}
