
import 'package:dimax/models/product_model.dart';

class HomeModel {
  List<Sliders>? sliders;
  List<Categories>? categories;

  HomeModel({this.sliders, this.categories});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

}

class Sliders {
  String? imageAr;
  String? imageEn;
  int? productId;

  Sliders({this.imageAr, this.imageEn});

  Sliders.fromJson(Map<String, dynamic> json) {
    imageAr = json['image_ar'];
    imageEn = json['image_en'];
    productId = json['product_id'];
  }
}

class Categories {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  List<ProductModel>? offers;
  List<ProductModel>? lastProducts;
  List<ProductModel>? specials;

  Categories(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.image,
        this.offers,
        this.lastProducts,
        this.specials});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    if (json['offers'] != null) {
      offers = <ProductModel>[];
      json['offers'].forEach((v) {
        offers!.add(ProductModel.fromJson(v));
      });
    }
    if (json['last_products'] != null) {
      lastProducts = <ProductModel>[];
      json['last_products'].forEach((v) {
        lastProducts!.add(ProductModel.fromJson(v));
      });
    }
    if (json['specials'] != null) {
      specials = <ProductModel>[];
      json['specials'].forEach((v) {
        specials!.add(ProductModel.fromJson(v));
      });
    }
  }
}

