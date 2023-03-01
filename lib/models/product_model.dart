
class ProductModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descAr;
  String? descEn;
  int? price;
  var isOffer;
  int? offerPrice;
  String? mainImage;
  bool? isSpecial;
  bool? isFavorite;
  int? quantity;



  ProductModel();

  ProductModel.fromJson(Map<String, dynamic> json,{bool fromApi =true}) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descAr = json['desc_ar'];
    descEn = json['desc_en'];
    price = json['price'];
    isOffer = fromApi ? json['is_offer'] : json['is_offer'] == true ? 1 : 0 ;
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    isSpecial = json['is_special'];
    mainImage = json['main_image'];
    quantity = json['quantity'];
  }
}