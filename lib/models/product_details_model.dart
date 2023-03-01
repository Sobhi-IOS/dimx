class ProductDetailsModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descEn;
  String? descAr;
  int? price;
  bool? isOffer;
  int? offerPrice;
  String? colorEn;
  String? colorAr;
  String? descAdvanceEn;
  String? descAdvanceAr;
  String? size;
  String? mainImage;
  List<AppImages>? images;
  bool? isFavorite;
  bool? isSpecial;
  int? quantity;

  ProductDetailsModel();

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descAr = json['desc_ar'];
    descEn = json['desc_en'];
    price = json['price'];
    isFavorite = json['is_favorite'];
    isSpecial = json['is_special'];
    isOffer = json['is_offer'];
    offerPrice = json['offer_price'];
    colorAr = json['color_ar'];
    colorEn = json['color_en'];
    descAdvanceEn = json['desc_advance_en'];
    descAdvanceAr = json['desc_advance_ar'];
    size = json['size'];
    quantity = json['quantity'];
    mainImage = json['main_image'];
    if (json['images'] != null) {
      images = <AppImages>[];
      json['images'].forEach((v) {
        images!.add(AppImages.fromJson(v));
      });
    }
  }


}
class AppImages {
  String? src;
  AppImages({this.src});

  AppImages.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    return data;
  }
}