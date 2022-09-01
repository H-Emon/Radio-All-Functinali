import 'package:flutter/cupertino.dart';
import '../Model/Categories_Model/Audio/audio_categories_model.dart';
import '../Model/Categories_Model/Audio/single_person_audio_model.dart';
import 'audio_categories_service.dart';




class AudioCategoryDataClass extends ChangeNotifier{
  CategoryPersonModel? audios;
  bool loading=false;

  getAudioCategoryData()async{
    loading=true;
    audios =(await getAudioCategoriesDataApi())!;
    loading=false;
    notifyListeners();
  }

}


class SingleAudioDataClass extends ChangeNotifier{
 SinglePersonModel? audio;
  bool loading=false;

  getSinglePersonData(id)async{
    loading=true;
    audio =(await getSinglePersonAudio(id))!;
    loading=false;
    notifyListeners();
  }

}