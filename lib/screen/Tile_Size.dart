import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/models/Products.model.dart';

import 'TileFinish.dart';

class TileSize extends StatefulWidget {
  int id;
  List list;
  final Products_model model;
  TileSize({this.id, this.list, this.model});
  @override
  _TileSizeState createState() => _TileSizeState();
}

class _TileSizeState extends State<TileSize> {
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

  bool loading = false;

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
                    "No Sizes Founded",
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
                          "Available Sizes",
                          style: TextStyle(
                            fontFamily: "book",
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: widget.list.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return TileType(
                                        id: widget.id, model: widget.model);
                                  },
                                  transitionsBuilder:
                                      (context, animation1, animation2, child) {
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
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        "http://oasistiles.in/admin/layout1/Aspero/600x1200x10/Doge%20Rock/ROCK_DOGE_NERO_R1%20copy.jpg"),
                                  ),
                                ),

                                margin: EdgeInsets.all(1),
                                // padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            widget.list[index],
                                            style: TextStyle(
                                                fontFamily: "book",
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio:
                                      height * 0.95 / height * 1.2),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
