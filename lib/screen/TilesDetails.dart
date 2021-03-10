import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/ProductDetailCard.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/models/Products.model.dart';

class TilesDetails extends StatefulWidget {
  final int Id;
  final String Title;
  final String imgurl;
  final Products_model model;

  const TilesDetails({Key key, this.Id, this.Title, this.model, this.imgurl})
      : super(key: key);

  @override
  _TilesDetailsState createState() => _TilesDetailsState();
}

class _TilesDetailsState extends State<TilesDetails> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF3F3D3E), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
  }

  bool loading = false;

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
                      "Product",
                      style: TextStyle(
                        fontFamily: "book",
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ProductDetailCard(
                      Id: widget.Id,
                      Title: widget.Title,
                      model: widget.model,
                      imUrl: widget.imgurl,
                    ),
                  )
                ],
              ),
            ),
    );
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
