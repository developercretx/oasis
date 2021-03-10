import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/models/Products.model.dart';
import 'package:oasis/screen/Tiles.dart';
import 'package:oasis/utils/App.dart';

class SeriesDisplay extends StatelessWidget {
  final String imgurl;
  final String title;
  final int Id;
  final bool spacing;
  final Products_model model;

  const SeriesDisplay(
      {Key key,
      this.imgurl,
      this.title,
      this.Id,
      this.model,
      this.spacing = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return Tiles(
                Id: Id,
                model: model,
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
        width: width,
        height: height * 0.2,
        child: Stack(
          children: <Widget>[
            Center(
              child: ProgressLoader(
                isDark: true,
              ),
            ),
            Container(
              width: width,
              child: CachedNetworkImage(
                imageUrl: App.imgUrl + imgurl.split('/')[1],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Center(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 5.0,
                            color: Colors.black),
                      ],
                      fontFamily: "book",
                      color: Colors.white,
                      letterSpacing: spacing ? 15 : 0,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
