import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/utils/App.dart';

class GallaryItems extends StatelessWidget {
  final String imgurl;
  final String title;

  const GallaryItems({Key key, this.imgurl, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.4,
      padding: EdgeInsets.only(
        bottom: height * 0.02,
        left: width * 0.04,
        right: width * 0.04,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Stack(
              children: <Widget>[
                Center(
                  child: ProgressLoader(),
                ),
                Container(
                  width: width,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: App.imgUrl + imgurl.split('/')[1],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
