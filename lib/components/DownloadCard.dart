import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/screen/PdfScreen.dart';
import 'package:oasis/utils/App.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadCard extends StatelessWidget {
  final String Title;
  final String pdfurl;

  const DownloadCard({Key key, this.Title, this.pdfurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(pdfurl);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: Color(0xFF3F3D3E),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: App.config['download'][Title] == null ||
                          App.config['download'][Title] == ""
                      ? AssetImage("images/background.png")
                      : CachedNetworkImageProvider(
                          App.config['download'][Title]['img'],
                        ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(
              Title,
              style: TextStyle(
                fontFamily: "book",
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfScreen(
                            pdfUrl:
                                'http://api.oasis.cretxinc.com/public/storage/' +
                                    pdfurl.split('/')[1],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "book",
                        color: Color(0xFF3F3D3E),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () async {
                      var url = App.config['download'][Title]['download'];
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      "Download",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "book",
                        color: Color(0xFF3F3D3E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
