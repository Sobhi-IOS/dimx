import 'package:dimax/models/order_model.dart';
import 'package:dimax/models/user_model.dart';

class OrderDetailsModel {
  OrderModel? order;
  UserModel? userModel;
  List<OrderProducts>? orderProducts;

  OrderDetailsModel({this.order, this.orderProducts});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? OrderModel.fromJson(json['order']) : null;
    userModel = json['user_data'] != null ?  UserModel.fromJson(json['user_data']) : null;
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
  }
}


class OrderProducts {
  int? id;
  String? name;
  int? quantity;
  int? price;
  String? size;
  String? color;
  String? mainImage;

  OrderProducts();

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    size = json['size'];
    color = json['color'];
    mainImage = json['main_image'];
  }
}