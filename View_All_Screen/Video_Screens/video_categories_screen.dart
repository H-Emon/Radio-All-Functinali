import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Api Call/Get_Video_Category/get_video_category_data.dart';
import '../../../Api Call/Model/Categories_Model/Video/video_categories_model.dart';
import '../../../Widgets/Custom_AppBar/custom_appbar.dart';
import '../../../Widgets/Custom_ListTile/custom_listtile.dart';

class VideoCategoryScreen extends StatefulWidget {
  const VideoCategoryScreen({Key? key}) : super(key: key);

  @override
  State<VideoCategoryScreen> createState() => _VideoCategoryScreenState();
}

class _VideoCategoryScreenState extends State<VideoCategoryScreen> {

  @override
  void initState() {
    super.initState();
    final VideoCategoryModel =Provider.of<VideoCategoryDataClass>(context, listen: false);
   VideoCategoryModel.getVideoCategoryData();
  }







  @override
  Widget build(BuildContext context) {
    final videoCategoryModel = Provider.of<VideoCategoryDataClass>(context);
    return  Scaffold(
        appBar: CoustomAppBar(
          title: "Category",
          onAction: () {
            Navigator.pop(context);
          },
        ),
        body:videoCategoryModel.loading
            ? CircularProgressIndicator()
            : ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: videoCategoryModel.videos!.categories!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                // Container(
                //   height: 60.h,
                //   child: AdWidget(ad: myBanner),
                // ),
                GestureDetector(
                  onTap:(){
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (builder)=>SiglePersonAudioPlay(id: AudioCategoryModel.audios!.categories![index].id.toString(),)));
                  },
                  child: CoustomListtile(
                      image: videoCategoryModel.videos!.categories![index].imgPath!,
                      title: videoCategoryModel.videos!.categories![index].name!,
                      subTitle:videoCategoryModel.videos!.categories![index].videoCount.toString()),
                ),
              ],
            );
          },
        ));
  }
}
