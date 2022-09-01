import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Categories_Model/Audio/audio_categories_model.dart';
import '../Model/Categories_Model/Audio/single_person_audio_model.dart';

Future<CategoryPersonModel?> getAudioCategoriesDataApi() async {
  CategoryPersonModel? result;

  try {
    final response =
    await http.get(Uri.parse("https://app2019.radiopunjabtoday.com/api/category/audio"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      return result = CategoryPersonModel.fromJson(data);
    } else {
      print("error");
    }
  } catch (e) {
    print(e.toString());
  }
  return result;
}






Future<SinglePersonModel?> getSinglePersonAudio(id) async {
 SinglePersonModel? result;

  try {
    final response =
    await http.get(Uri.parse("https://app2019.radiopunjabtoday.com/api/category/${id}/audio"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      return result = SinglePersonModel.fromJson(data);
    } else {
      print("error");
    }
  } catch (e) {
    print(e.toString());
  }
  return result;
}