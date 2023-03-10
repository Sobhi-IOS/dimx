class CategoryModel {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;

  CategoryModel();
  
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['image'] = image;
    return data;
  }
}