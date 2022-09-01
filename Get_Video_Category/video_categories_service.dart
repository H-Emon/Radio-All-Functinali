import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/Categories_Model/Video/all_video_model.dart';
import '../Model/Categories_Model/Video/video_categories_model.dart';


Future< VideoCategoryModel?> getVideoCategoryApi() async {
  VideoCategoryModel? result;

  try {
    final response =
    await http.get(Uri.parse("https://app2019.radiopunjabtoday.com/api/category/video"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      return result = VideoCategoryModel.fromJson(data);
    } else {
      print("error");
    }
  } catch (e) {

    print(e.toString());
  }
  return result;
}





Future< AllVideoModel?> getAllVideos(id) async {
  AllVideoModel? result;

  try {
    final response =
    await http.get(Uri.parse("https://app2019.radiopunjabtoday.com/api/category/21/video?page=$id"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      return result =AllVideoModel.fromJson(data);
    } else {
      print("error");
    }
  } catch (e) {

    print(e.toString());
  }
  return result;
}







