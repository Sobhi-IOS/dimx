import 'dart:convert';
import 'package:dimax/api/api_helper.dart';
import 'package:dimax/api/api_settings.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/address_model.dart';
import 'package:dimax/models/category_model.dart';
import 'package:dimax/models/homeModel.dart';
import 'package:dimax/models/order_details.dart';
import 'package:dimax/models/order_model.dart';
import 'package:dimax/models/product_details_model.dart';
import 'package:dimax/models/product_model.dart';
import 'package:dimax/models/sub_category_model.dart';
import 'package:dimax/models/user_model.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiController extends ApiHelper{

  static ApiController instance = ApiController._();
  ApiController._();
  factory ApiController() => instance;


  Future login(context, {required String email, required String password, String? fcmToken}) async {
    var body = {'email': email, 'password': password, 'fcm_token': fcmToken};
    var response = await http.post(getUrl(ApiSettings.login), body: body,headers: header);
    print(jsonDecode(response.body));
    if (isSuccessRequest(response.statusCode)) {
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body)['data']);
      switch (jsonDecode(response.body)['data']['type']) {
        case 1:
          await SharedPreferencesController().saveUser(userModel: userModel,isUser: true);
          showMessage(context, response, error: false);
          return userModel;
        case 2:
          await SharedPreferencesController().saveUser(userModel: userModel, isMarketed: true);
          showMessage(context, response, error: false);
          return userModel;
      }
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }
    else{
      handleServerError(context);
    }
    return null;
  }

  Future<bool> register({required String name, required String email, required String mobile, required String password, required String address, required String? gender, required String dob, required String passwordConfirmation,}) async {
    var body = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'address': address,
      'password_confirmation': passwordConfirmation,
    };

    if(dob.isNotEmpty){
      body['dob'] = dob;
    }
    if(gender != null){
      body['gender'] = gender;
    }

    var response = await http.post(getUrl(ApiSettings.register), body: body,headers: baseHeader);
    if (isSuccessRequest(response.statusCode)) {
      showSnackBar(Get.context, text: jsonDecode(response.body)['message']);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
      return false;
    }else{
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> forgetPassword({required String email}) async {
    var response = await http.post(getUrl(ApiSettings.forgetPassword), body: {'email': email}, headers: baseHeader);
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }



  Future<bool> resetPassword({required String code, required String password}) async {
    var response = await http.post(
      getUrl(ApiSettings.resetPassword),
      body: {'code': code, 'password': password,},
      headers: baseHeader
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> removeAccount({required String currentPassword, required String newPassword}) async {
    var response = await http.post(
        getUrl(ApiSettings.removeAccount),
        body: {
          'current_password': currentPassword,
          'password': newPassword,
          'password_confirmation': newPassword,
        },
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    }
    else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    }
    else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> changePassword({required String currentPassword, required String newPassword}) async {
    var response = await http.post(
        getUrl(ApiSettings.changePassword),
        body: {
          'current_password': currentPassword,
          'password': newPassword,
          'password_confirmation': newPassword,
        },
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    }
    else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    }
    else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<void> updateUserProfile({ required String name, required String email, required String mobile, required String address, required String? gender, required String dob, required String image, required Function(UserModel? user) uploadEvent}) async {
    var request = http.MultipartRequest('POST', getUrl(ApiSettings.updateUserProfile),);
    request.headers.addAll(header);
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['mobile'] = mobile;
    request.fields['address'] = address;
    if(dob.isNotEmpty){
      request.fields['dob'] = dob;
    }

    if(gender != null){
      request.fields['gender'] = gender;
    }

    if (image != '') {
      var userImage = await http.MultipartFile.fromPath('image', image);
      request.files.add(userImage);
    }

    var response = await request.send();
    print(response.statusCode.toString()+'kkkkkkkkkkkk');
    response.stream.transform(utf8.decoder).listen((value) {
      if (isSuccessRequest(response.statusCode)) {
        UserModel userModel = UserModel.fromJson(jsonDecode(value)['data']['user_data']);
        showSnackBar(Get.context, text: jsonDecode(value)['message'], error: false);
        uploadEvent(userModel);
      } else if (response.statusCode == 401) {
        handleNotAuthorizedRequest();
      } else if (response.statusCode != 500) {
        List errors = jsonDecode(value)['error'];
        showSnackBar(Get.context, text: errors.first, error: true);
        uploadEvent(null);
      } else {
        handleServerError(Get.context);
        uploadEvent(null);
      }
    });
  }

  Future<List<CategoryModel>> getCategory() async {
    var response = await http.get(getUrl(ApiSettings.categories),headers: baseHeader);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'] as List;
      List<CategoryModel> categories = data.map((e) => CategoryModel.fromJson(e)).toList();
      return categories;
    }else {
      handleServerError(Get.context);
    }
    return [];
  }

  Future<List<ProductModel>> getProductOffers() async {
    var response = await http.get(getUrl(ApiSettings.offers),headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'] as List;
      List<ProductModel> products = data.map((e) => ProductModel.fromJson(e)).toList();
      return products;
    }else {
      handleServerError(Get.context);
    }
    return [];
  }

  Future<List<SubCategoryModel>> getSubCategory({required int categoryId}) async {
    var response = await http.get(getUrl(ApiSettings.subCategories(categoryId: categoryId)), headers: baseHeader);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'] as List;
      List<SubCategoryModel> subCategories = data.map((e) => SubCategoryModel.fromJson(e)).toList();
      return subCategories;
    }
    else {
      handleServerError(Get.context);
    }
    return [];
  }

  Future<List<ProductModel>> getProduct({required int subCategoryId}) async {
    var response = await http.get(
        getUrl(ApiSettings.products(subCategoryId: subCategoryId)),
        headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'] as List;
      List<ProductModel> products = data.map((e) => ProductModel.fromJson(e)).toList();
      return products;
    }else {
      handleServerError(Get.context);
    }
    return [];
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    var response = await http.get(getUrl(ApiSettings.favorite), headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'] as List;
      List<ProductModel> favoriteProducts = data.map((e) => ProductModel.fromJson(e)).toList();
      return favoriteProducts;
    } else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }
    else {
      handleServerError(Get.context);
    }
    return [];
  }

  Future<bool> addFavoriteProducts({required int id}) async {
    var response = await http.post(
        getUrl(ApiSettings.addToFavorite),
        body: {'product_id': id.toString()},
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      return true;
    }else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    } else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> contactUS({required String phone, required String name, required String msg}) async {
    var response = await http.post(
        getUrl(ApiSettings.contactUs),
        body: {
          'name': name,
          'phone': phone,
          'desc': msg,
        },
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> sendCodeActivate() async {
    var response = await http.post(
        getUrl(ApiSettings.sendCode),
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    } else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    } else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> activateAccount({required String code}) async {
    var response = await http.post(
        getUrl(ApiSettings.activationAccount),
        headers: header,
        body: {
          'code': code,
        },
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    } else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }
    else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    }  else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<List<AddressModel>> getAllAddress() async {
    var response = await http.get(getUrl(ApiSettings.address), headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'] as List;
      List<AddressModel> addresses = data.map((e) => AddressModel.fromJson(e)).toList();
      return addresses;
    } else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }  else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return [];
  }

  Future<AddressModel?> createAddress({ required AddressModel address}) async {
    var response = await http.post(
      getUrl(ApiSettings.addAddress),
      headers: header,
      body: {
        'title': address.name,
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      var jsonObject = (jsonDecode(response.body)['data'] as List).first;
      AddressModel addressModel = AddressModel.fromJson(jsonObject);
      showMessage(Get.context, response, error: false);
      return addressModel;
    } else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }
    else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    }  else {
      handleServerError(Get.context);
    }
    return null;
  }

  Future<bool> deleteAddress({ required addressId}) async {
    var response = await http.delete(
      getUrl(ApiSettings.deleteAddress(addressId: addressId)),
      headers: header,
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    } else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }
    else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    }else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> updateAddress({ required AddressModel address}) async {
    var response = await http.post(
      getUrl(ApiSettings.updateAddress),
      headers: header,
      body: {
        'id': address.id.toString(),
        'title': address.name,
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response, error: false);
      return true;
    }
    else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }
    else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    }  else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<HomeModel?> initHome() async {
    var response = await http.get(getUrl(ApiSettings.home), headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'];
      HomeModel home = HomeModel.fromJson(data);
      return home;
    }else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    }  else {
      handleServerError(Get.context);
    }
    return null;
  }

  Future<ProductDetailsModel?> getProductDetails({required int productId}) async {
    var response = await http.get(
        getUrl(ApiSettings.productDetails(productId: productId)),
        headers: SharedPreferencesController().loggedIn ? header : baseHeader);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'];
      var productDetails = ProductDetailsModel.fromJson(data);
      return productDetails;
    }else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    }  else {
      handleServerError(Get.context);
    }
    return null;
  }

  Future<bool> addToCart( {required int quantity, required int productId,String? color , String? size}) async {
    Map<String,dynamic> map = {};
    map.addIf(color!= null, 'color', color);
    map.addIf(size!= null, 'size', size);
    map.addIf(quantity != null, 'quantity', quantity.toString());
    map.addIf(productId!= null, 'product_id', productId.toString());

    var response = await http.post(
        getUrl(ApiSettings.addToCart),
        body: map,
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response);
      return true;
    }else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }  else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<List<ProductDetailsModel>> getCartProducts() async {
    var response = await http.get(getUrl(ApiSettings.getCart), headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data']['products'] as List;
      List<ProductDetailsModel> cartProducts = data.map((e) => ProductDetailsModel.fromJson(e)).toList();
      return cartProducts;
    }else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }  else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return [];
  }

  Future<bool> removeFromCart({required int productId}) async {
    var response = await http.post(
        getUrl(ApiSettings.removeFromCart),
        body: {
          'product_id': productId.toString(),
        },
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }  else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> removeAllFromCart() async {
    var response = await http.post(
        getUrl(ApiSettings.removeAllFromCart),
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(Get.context, response);
      return true;
    }else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }  else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool>  updateCartItem({required int quantity, required int productId}) async {
    var response = await http.post(
        getUrl(ApiSettings.updateCartItem),
        body: {
          'product_id': productId.toString(),
          'quantity': quantity.toString(),
        },
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      return true;
    }else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }  else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> checkOut({String? code, String? note, required int addressId}) async {
    Map<String,dynamic> map = {};
    map.addIf(code!= null, 'code', code);
    map.addIf(code!= null, 'note', note);
    map.addIf(code!= null, 'address_id', addressId.toString());
    var response = await http.post(
        getUrl(ApiSettings.checkOut),
        body: map,
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }  else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<List<OrderModel>> getOrder() async {
    var response = await http.get(getUrl(ApiSettings.order), headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'] as List;
      List<OrderModel> orders  = data.map((e) => OrderModel.fromJson(e)).toList();
      return orders;
    }else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }  else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return [];
  }

  Future<OrderDetailsModel?> getOrderDetails({required int id}) async {
    var response = await http.get(getUrl(ApiSettings.orderDetails(orderID: id)), headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['data'];
      OrderDetailsModel orderDetailsModel = OrderDetailsModel.fromJson(data);
      return orderDetailsModel;
    }else if (response.statusCode != 500) {
      showMessage(Get.context, response, error: true);
    } else {
      handleServerError(Get.context);
    }
    return null;
  }

  Future<String?> policy() async {
    var response = await http.get(getUrl(ApiSettings.policy));
    if (isSuccessRequest(response.statusCode)) {
      String data = jsonDecode(response.body)['data']['text'];
      return data;
    }else {
      handleServerError(Get.context);
    }
    return null;
  }

  Future<String?> condition() async {
    var response = await http.get(getUrl(ApiSettings.condations));
    if (isSuccessRequest(response.statusCode)) {
      String data = jsonDecode(response.body)['data']['text'];
      return data;
    } else {
      handleServerError(Get.context);
    }
    return null;
  }

  Future<String> cancelOrder({required int id}) async {
    var response = await http.post(getUrl(ApiSettings.cancelOrder),headers: header,body: {'order_id':id.toString()});
    if (isSuccessRequest(response.statusCode)) {
      return jsonDecode(response.body)['message'];
    }else if (response.statusCode == 401) {
      handleNotAuthorizedRequest();
    }else {
      handleServerError(Get.context);
    }
    return jsonDecode(response.body)['message'];;
  }
  //USER LOGIN
  Future<bool> loginGuest({required String newFcm}) async {
    var response = await http.post(getUrl(ApiSettings.refreshToken), body: {'fcm': newFcm});
    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> refreshToken({required String newFcm,required String oldFcm}) async {
    var response = await http.post(getUrl(ApiSettings.refreshToken), body: {'fcm': newFcm,'old_fcm':oldFcm});
    if (isSuccessRequest(response.statusCode)) {
      SharedPreferencesController().setFcmToken(newFcm);
      return true;
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

  Future<bool> removeFcmToken() async {
    var response = await http.get(getUrl(ApiSettings.removeFcmToken));
    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else {
      handleServerError(Get.context);
    }
    return false;
  }

}
