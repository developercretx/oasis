import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/models/Slider.model.dart';
import 'package:oasis/screen/SliderSizes.dart';
import 'package:oasis/utils/App.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller;
  sliderModel _slider;
  List<sliderModel> _sliderList = [];
  bool loading = false;

  sliderModel mainSliderIndex;

  int latestCollectionIndex = 0;
  int displayIndex = 0;

  @override
  void initState() {
    controller = new PageController();
    getSlider();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
      ),
    );
  }

  void _animateSlider(int index) {
    print("Index of -->$index");
    print("Lenght of -->${_sliderList.length}");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomAppBar(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: height * 0.5,
            padding: EdgeInsets.all(15.0),
            child: loading
                ? Center(
                    child: ProgressLoader(
                      isDark: false,
                    ),
                  )
                : PageView.builder(
                    controller: controller,
                    itemCount: _sliderList.length,
                    onPageChanged: (currentIndex) {
                      if (mounted) {
                        setState(() {
                          mainSliderIndex = _sliderList[currentIndex];
                        });
                      }
                    },
                    itemBuilder: (ctx, index) {
                      return Container(
                        width: width,
                        height: height,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            height: height,
                            width: width,
                            fit: BoxFit.cover,
                            imageUrl: App.imgUrl +
                                _sliderList[index].imageurl.split('/')[1],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
                              return Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Icon(Icons.error);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
          loading
              ? Container()
              : Container(
                  height: height * 0.02,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ..._sliderList.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundColor:
                                e.imageurl == mainSliderIndex.imageurl
                                    ? Colors.black
                                    : Colors.grey.withOpacity(0.5),
                            radius: 4,
                          ),
                        );
                      })
                    ],
                  ),
                ),
          Container(
            height: height * 0.1,
            alignment: Alignment.center,
            child: Text(
              "Oasis, a leading tiles\nmanufacturer indian brand",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "book"),
            ),
          ),
          Container(
            height: height * 0.3,
            padding: EdgeInsets.all(15.0),
            child: loading
                ? Center(
                    child: ProgressLoader(
                      isDark: false,
                    ),
                  )
                : PageView.builder(
                    onPageChanged: (int index) {
                      _animateSlider(index);
                    },
                    itemCount: App.sliders['sider1'].length,
                    itemBuilder: (ctx, postion) {
                      return Container(
                        child: Stack(
                          children: <Widget>[
                            Center(child: ProgressLoader()),
                            Container(
                              width: width,
                              height: height,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  height: height,
                                  width: width,
                                  fit: BoxFit.cover,
                                  imageUrl: App.sliders['sider1'][postion]
                                      ['img'],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            height: height * 0.1,
            alignment: Alignment.center,
            child: Text(
              "Check out our latest trendsetting design\nto uplift your decor aesthetics",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "book"),
            ),
          ),
          Container(
            height: height * 0.55,
            padding: EdgeInsets.all(15.0),
            child: loading
                ? Center(
                    child: ProgressLoader(
                      isDark: false,
                    ),
                  )
                : PageView.builder(
                    onPageChanged: (int index) {
                      _animateSlider(index);
                    },
                    itemCount: App.sliders['sider2'].length,
                    itemBuilder: (ctx, postion) {
                      return Container(
                        child: Stack(
                          children: <Widget>[
                            Center(child: ProgressLoader()),
                            Container(
                              width: width,
                              height: height,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  height: height,
                                  width: width,
                                  fit: BoxFit.cover,
                                  imageUrl: App.sliders['sider2'][postion]
                                      ['img'],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            height: height * 0.1,
            alignment: Alignment.center,
            child: Text(
              "Social Media Updates",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "book",
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          var url = App.config['social']['facebook'] ??
                              'http://www.facebook.com';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          var url = App.config['social']['instagram'] ??
                              'http://www.instagram.com';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          var url = App.config['social']['twitter'] ??
                              'http://www.twitter.com';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.youtube,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          var url = App.config['social']['youtube'] ??
                              'http://www.youtube.com';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFF403d3d),
            height: height * 0.2,
            child: Center(
              child: Text(
                "Contact",
                style: TextStyle(
                  fontFamily: "book",
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
      isdark: false,
      hasdrawer: true,
      fromscreen: 1,
    );
  }

  getSlider() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    try {
      var response = await http.get(
        App.baseUrl + 'slides',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      Map responseMap = jsonDecode(response.body);
      print("Slides Map ==> " + responseMap.toString());
      if (responseMap['Success'] == true) {
        List _temppro = [];
        _temppro = responseMap['slider'];
        print("Slides ===> $_temppro");
        mainSliderIndex = sliderModel.fromJson(responseMap['slider'][0]);
        for (int i = 0; i < _temppro.length; i++) {
          _slider = sliderModel.fromJson(responseMap['slider'][i]);
          _sliderList.add(_slider);
        }
        if (mounted) {
          setState(() {
            loading = false;
          });
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
      print("Error on Slides Fetching ==> " + err.toString());
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
