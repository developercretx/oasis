import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oasis/components/CustomAppBar.dart';
import 'package:oasis/components/DownloadCard.dart';
import 'package:oasis/components/ProgressLoader.dart';
import 'package:oasis/models/Brochure.model.dart';
import 'package:oasis/utils/App.dart';

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  bool loading = false;
  brochureModel _broucher;
  List<brochureModel> _broucherlist = [];

  @override
  void initState() {
    getBrochure();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF3F3D3E), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return CustomAppBar(
      fromscreen: 5,
      hasdrawer: true,
      isdark: true,
      body: loading
          ? Center(
              child: ProgressLoader(
                isDark: false,
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: height * 0.07,
                    bottom: height * 0.01,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Catalogue",
                    style: TextStyle(
                      fontFamily: "book",
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: _broucherlist.length,
                    itemBuilder: (context, index) => DownloadCard(
                      Title: _broucherlist[index].title,
                      pdfurl: _broucherlist[index].pdfurl,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: height * 0.8 / height * 0.8),
                  ),
                )
              ],
            ),
    );
  }

  Future getBrochure() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    try {
      var response = await http.get(
        App.baseUrl + 'downloads',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      Map responseMap = jsonDecode(response.body);
      print("Category Map ==> " + responseMap.toString());
      if (responseMap['Success'] == true) {
        List _temppro = [];
        _temppro = responseMap['downloads']['data'];
        print("companies ===> $_temppro");
        for (int i = 0; i < _temppro.length; i++) {
          _broucher =
              brochureModel.fromJson(responseMap['downloads']['data'][i]);
          _broucherlist.add(_broucher);
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
      print("Error on Category Fetching ==> " + err.toString());
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
      ),
    );
  }
}
