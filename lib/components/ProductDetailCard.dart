import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/models/Products.model.dart';
import 'package:oasis/utils/App.dart';

class ProductDetailCard extends StatelessWidget {
  final String Title;
  final String imUrl;
  final int Id;
  final Products_model model;

  const ProductDetailCard(
      {Key key, this.Title, this.imUrl, this.Id, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(25),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: ProgressLoader(),
                  ),
                  Hero(
                    tag: imUrl.toString(),
                    child: Container(
                      padding: EdgeInsets.all(25),
                      height: height,
                      width: width,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: App.imgUrl + imUrl.split('/')[1],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: height * 0.02),
                      alignment: Alignment.center,
                      child: Text(
                        Title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "book",
                            fontSize: 17,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            model.size,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "book",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            model.type,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "book",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
