class CategoryPersonModel {
  String? status;
  List<Categories>? categories;

  CategoryPersonModel({this.status, this.categories});

  CategoryPersonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? imgPath;
  int? type;
  String? createdAt;
  String? updatedAt;
  int? audioCount;

  Categories(
      {this.id,
        this.name,
        this.imgPath,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.audioCount});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgPath = json['img_path'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    audioCount = json['audio_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img_path'] = this.imgPath;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['audio_count'] = this.audioCount;
    return data;
  }
}
