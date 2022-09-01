import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Api Call/Get_Audio_Category/get_audio_category_data.dart';
import '../../../music.dart';

class SiglePersonAudioPlay extends StatefulWidget {
  final String id;
  SiglePersonAudioPlay({ required this.id,Key? key}) : super(key: key);

  @override
  State<SiglePersonAudioPlay> createState() => _SiglePersonAudioPlayState();
}

class _SiglePersonAudioPlayState extends State<SiglePersonAudioPlay> {
  AudioPlayer advancedPlayer=AudioPlayer();

  bool isPlaying=false;

  bool isPaused=false;

  bool isLoop=false;

  void initState() {
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
          return Column(
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



