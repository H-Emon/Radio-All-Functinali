import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_punjab_today/Screens/View_All_Screen/Audio_Screens/single_parson_audio.dart';

import '../../../Api Call/Get_Audio_Category/get_audio_category_data.dart';

import '../../../Widgets/Custom_AppBar/custom_appbar.dart';
import '../../../Widgets/Custom_ListTile/custom_listtile.dart';

class AudioCategoryScreen extends StatefulWidget {
  const AudioCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AudioCategoryScreen> createState() => _AudioCategoryScreenState();
}

class _AudioCategoryScreenState extends State<AudioCategoryScreen> {
  @override
  void initState() {
    super.initState();
    final AudioCategoryModel =
        Provider.of<AudioCategoryDataClass>(context, listen: false);
    AudioCategoryModel.getAudioCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    final AudioCategoryModel = Provider.of<AudioCategoryDataClass>(context);
    return Scaffold(
        appBar: CoustomAppBar(
          title: "Category",
          onAction: () {
            Navigator.pop(context);
          },
        ),
        body: AudioCategoryModel.loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: AudioCategoryModel.audios!.categories!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Container(
                      //   height: 60.h,
                      //   child: AdWidget(ad: myBanner),
                      // ),
                      GestureDetector(
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>SiglePersonAudioPlay(id: AudioCategoryModel.audios!.categories![index].id.toString(),)));
                        },
                        child: CoustomListtile(
                            image: AudioCategoryModel.audios!.categories![index].imgPath!,
                            title: AudioCategoryModel.audios!.categories![index].name!,
                            subTitle:AudioCategoryModel.audios!.categories![index].audioCount.toString()),
                      ),
                    ],
                  );
                },
              ));
  }
}
