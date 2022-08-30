import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/colors.dart';

class WebSiteView extends StatefulWidget {
  final String link,appBarTitle;
  const WebSiteView({
    required this.link,
    required this.appBarTitle,
    Key? key}) : super(key: key);

  @override
  State<WebSiteView> createState() => _WebSiteViewState();
}

class _WebSiteViewState extends State<WebSiteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors.appRedColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            //_scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400),
        ),
      ),
      body: WebView(
        javascriptMode:JavascriptMode.unrestricted,
        initialUrl:widget.link,
      ),
      bottomSheet:  Container(
        height: 95.h,
        color: Colors.white,
        child: Card(
          child: ListTile(
            tileColor: Colors.white,
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  'assets/images/radio _logo.jpg',
                  width: 50.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                )),
            title: Text(
              "Radio Punjab Today",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey,
              ),
            ),
            trailing:IconButton(
              onPressed:(){
              },
              icon:Icon( Icons.pause),
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
