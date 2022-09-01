import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Api Call/Get_Audio_Category/get_audio_category_data.dart';
import '../../../dwonload_video.dart';
import '../../../music.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';



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

  void initState() {

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        // isPlaying = state = PlayerState.PLAYING;
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

      body: singleAudio.loading? Container(child:CircularProgressIndicator(),):
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
                    height: 100,

                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 40,

                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  height: 40,
                                  width: 250,
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
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 30,

                                    child: IconButton(
                                      onPressed: () async {
                                        audioPlayer.setUrl(singleAudio.audio!.audio!.data![index].audioPath!);
                                        if (isPlaying) {
                                          await audioPlayer.pause();
                                        } else {
                                          await audioPlayer.resume();
                                        }
                                      },
                                      icon: Icon(isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow),
                                      color: Colors.red,
                                      iconSize: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      height: 40,
                                      width: 15,
                                      child: IconButton(
                                        icon: Icon(Icons.more_vert),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                            const DownloadingDialog(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${position.inMinutes.floorToDouble()}'),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  max: duration.inSeconds.toDouble(),
                                  value: position.inSeconds.toDouble(),
                                  onChanged: (value) async {
                                    final position =
                                    Duration(seconds: value.toInt());
                                    await audioPlayer.seek(position);

                                    await audioPlayer.resume();
                                  },
                                ),
                              ),
                              Text(
                                  "${duration.inMinutes.floorToDouble() - position.inMinutes.floorToDouble()}"),
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




















            Column(
            children: [
              FloatingActionButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>AudioPage(link:singleAudio.audio!.audio!.data![index].audioPath!,)));
              })
            ],
          );
       },
      
      ),
    );
  }
}



