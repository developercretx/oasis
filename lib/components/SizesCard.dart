import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/screen/Products.dart';
import 'package:oasis/utils/App.dart';

class SizesCard extends StatelessWidget {
  final String Title;
  final int Id;
  final String img;

  const SizesCard({Key key, this.Title, this.Id, this.img}) : super(key: key);

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
              return Products(
                Id: Id,
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
        padding: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Container(
              width: width,
              decoration: BoxDecoration(
                color: Color(0xFF3F3D3E),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: App.config['sizes'][img] != null
                      ? CachedNetworkImageProvider(
                          App.config['sizes'][img],
                        )
                      : AssetImage("images/background.png"),
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            Center(
              child: Text(
                Title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: "book",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
