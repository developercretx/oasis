import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainWebViewHome extends StatefulWidget {
  MainWebViewHome({Key key}) : super(key: key);

  @override
  _MainWebViewHomeState createState() => _MainWebViewHomeState();
}

class _MainWebViewHomeState extends State<MainWebViewHome> {
  bool isLoading = false;

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
        child: WebView(
                onPageFinished: (sl) {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                onWebViewCreated: (con) {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                initialUrl: 'http://oasistiles.in',
                javascriptMode: JavascriptMode.unrestricted,
              ),
          ),
    );
  }
}
