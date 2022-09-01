import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Api Call/Get_Audio_Category/get_audio_category_data.dart';

import '../../../dwonload_video.dart';
import '../../../music.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/colors.dart';



class SiglePersonAudioPlay extends StatefulWidget {
  final String id;
  SiglePersonAudioPlay({ required this.id,Key? key}) : super(key: key);

  @override
  State<SiglePersonAudioPlay> createState() => _SiglePersonAudioPlayState();
}

class _SiglePersonAudioPlayState extends State<SiglePersonAudioPlay> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  int? _currentIndex;

  void initState() {

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {

        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });



    super.initState();
    final SingleAudioModel = Provider.of<SingleAudioDataClass>(context, listen: false);
    SingleAudioModel.getSinglePersonData(widget.id);
  }



  @override
  Widget build(BuildContext context) {
   final singleAudio= Provider.of<SingleAudioDataClass>(context);
    return Scaffold(
      appBar: AppBar(
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
          "Music",
          style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: singleAudio.loading? Container(child:Center(child: CircularProgressIndicator()),):
      ListView.builder(
        itemCount:singleAudio.audio!.audio!.data!.length,
       itemBuilder:(context, index){
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 3,
                  child: Container(
                    height: 60,
                    width:322,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                      singleAudio.audio!.audio!.data![index].title!,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                          singleAudio.audio!.audio!.data![index].title!,
                                        style: TextStyle(
                                            fontSize: 13.5,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  audioPlayer.setUrl(singleAudio.audio!.audio!.data![index].audioPath!);
                                  if (isPlaying) {
                                    await audioPlayer.pause();
                                    _currentIndex=index;
                                  } else {
                                    await audioPlayer.resume();
                                    _currentIndex=index;
                                  }
                                },
                                icon:_currentIndex == index
                                    ? isPlaying
                                    ? Icon(
                                  Icons.pause,
                                  size: 30,
                                  color: Colors.red[800],
                                )
                                    : Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                  color: Colors.red[800],
                                )
                                    : Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                  color: Colors.red[800],
                                ),

                              ),
                              IconButton(
                                icon: Icon(Icons.file_download, color:Colors.redAccent,),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>DownloadingDialog(Alink:singleAudio.audio!.audio!.data![index].imgPath!)
                                  );
                                },
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
       },
      
      ),

    );
  }
}



