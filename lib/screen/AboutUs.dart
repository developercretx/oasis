import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/utils/App.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(App.config['about']);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomAppBar(
      fromscreen: 2,
      isdark: false,
      hasdrawer: true,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/background.png"),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.08),
              alignment: Alignment.center,
              child: Text(
                "About Us",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontFamily: "book", fontSize: 25),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: App.config['about'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        App.config['about'][index]['img'] == null ||
                                App.config['about'][index]['img'] == ""
                            ? Container()
                            : Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: double.parse(
                                    App.config['about'][index]['height'] != null
                                        ? App.config['about'][index]['height']
                                        : "150.00",
                                  ),
                                  width: double.parse(
                                    App.config['about'][index]['width'] != null
                                        ? App.config['about'][index]['width']
                                        : "150",
                                  ),
                                  imageUrl: App.config['about'][index]['img'],
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.02),
                          alignment: Alignment.center,
                          child: Text(
                            App.config['about'][index]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "book",
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: height * 0.02,
                              left: width * 0.04,
                              right: width * 0.04),
                          alignment: Alignment.center,
                          child: Text(
                            App.config['about'][index]['desc'],
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "thin",
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
