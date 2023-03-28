import 'package:dimax/models/user_model.dart';

class OrderModel {
  int? id;
  num? fainalTotal;
  num? generalTotal;
  bool? isDiscount;
  int? ratio;
  String? status;
  String? note;
  String? code;
  String? address;
  String? createdAt;
  String? delegateNumber;
  String? invoiceNumber;
  UserModel? userModel;


  OrderModel();

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fainalTotal = json['fainal_total'];
    generalTotal = json['general_total'];
    isDiscount = json['is_discount'];
    ratio = json['ratio'];
    status = json['status'];
    note = json['note'];
    code = json['code'];
    address = json['address'];
    createdAt = json['created_at'];
    delegateNumber = json['delegate_number'];
    invoiceNumber = json['invoice_number'];
    userModel = json['user_data'] != null ?  UserModel.fromJson(json['user_data']) : null;

  }
}