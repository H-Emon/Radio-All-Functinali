
import 'package:flutter/cupertino.dart';
import 'package:radio_punjab_today/Api%20Call/Get_Video_Category/video_categories_service.dart';
import '../Model/Categories_Model/Video/all_video_model.dart';
import '../Model/Categories_Model/Video/video_categories_model.dart';


class VideoCategoryDataClass extends ChangeNotifier{
  VideoCategoryModel ? videos;
  bool loading=false;

  getVideoCategoryData()async{
    loading=true;
    videos=(await getVideoCategoryApi())!;
    loading=false;
    notifyListeners();
  }

}



class AllVideoDataClass extends ChangeNotifier{
  AllVideoModel ? videosList;
  bool loading=false;

  getAllVideoData(id)async{
    loading=true;
    videosList=(await getAllVideos(id))!;
    loading=false;
    notifyListeners();
  }

}


