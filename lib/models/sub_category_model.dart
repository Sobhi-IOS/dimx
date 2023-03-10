class SubCategoryModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;
  bool isSelect= false;

  SubCategoryModel();

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['image'] = image;
    return data;
  }
}