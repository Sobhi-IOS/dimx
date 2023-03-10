class UserModel {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? mobile;
  String? image;
  String? code;
  String? dob;
  String? gender;
  String? fcmToken;
  int? type;
  String? address;
  String? activationCode;
  bool? activationStatus;
  String? deletedAt;
  int? rate;
  String? token;

  UserModel();
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mobile = json['mobile'];
    image = json['image'];
    code = json['code'];
    dob = json['dob'];
    gender = json['gender'].toString();
    fcmToken = json['fcm_token'];
    type = json['type'];
    address = json['address'];
    activationCode = json['activation_code'];
    activationStatus = json['activation_status'];
    deletedAt = json['deleted_at'];
    rate = json['rate'];
    token = json['token'];
  }
}