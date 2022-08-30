import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';


class NewsDetailScreen extends StatelessWidget {
   final String imgUrl,dateTime,dataDate,titleText,bodyText ;
  const NewsDetailScreen({
    required this.titleText,
    required this.dateTime,
    required this.dataDate,
    required this.bodyText,
    required this.imgUrl,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
         "News",
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height:250,
              width:double.infinity,
              child: Image.network(imgUrl,fit:BoxFit.fill,)),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(dateTime,style:TextStyle(color:Colors.red[400]),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(dataDate,style:TextStyle(color:Colors.red[400]),),
              ),
            ],
          ),
          SizedBox(
            height:5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Text(titleText, style:TextStyle(fontSize:18),),
          ),
          SizedBox(
            height:10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Text(bodyText,textAlign:TextAlign.justify,style:TextStyle(fontSize:14),),
          ),
          SizedBox(
            height:100.h,
          ),


        ],
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

//newsModel.post!.items![index].image!

//newsModel.post!.items![index].contentText!,