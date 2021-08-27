import 'dart:io';
import 'package:flutter/material.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPalView extends StatelessWidget {
  var _url;

  PayPalView(this._url)
  {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var appBarH = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png',fit: BoxFit.contain,height: appBarH,),
        backgroundColor: ConstStyles.WhiteColor,
        iconTheme: IconThemeData(color: ConstStyles.DarkColor),

      ),
      body: SafeArea(
        child: Container(
          child: WebView(
            initialUrl: _url,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
