import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/Products.model.dart';
import 'package:oasis/screen/TilesDetails.dart';
import 'package:oasis/utils/App.dart';

class TilesCard extends StatelessWidget {
  final String title;
  final String imUrl;
  final int id;
  final Products_model model;

  const TilesCard({Key key, this.title, this.id, this.imUrl, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return TilesDetails(
                Id: id,
                Title: title,
                model: model,
                imgurl: imUrl,
              );
            },
            transitionsBuilder: (context, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 100),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Hero(
                tag: imUrl.toString(),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFF3F3D3E),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          App.imgUrl + imUrl.split('/')[1]),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: "book",
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
