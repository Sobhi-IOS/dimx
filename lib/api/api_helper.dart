import 'dart:convert';

import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class ApiHelper with Helper {

  Uri getUrl(String url) {
    return Uri.parse(url);
  }

  bool isSuccessRequest(int statusCode) {
    return statusCode < 400;
  }
  handleNotAuthorizedRequest(){
    SharedPreferencesController().logout();
    showSnackBar(Get.context, text: '401_msg'.tr,error: true);
    Get.offAll(const LoginScreen());
  }
  void handleServerError(context) {
    showSnackBar(context, text: 'server_error'.tr, error: true);
  }

  void showMessage(context, http.Response response, {bool error = false}) {
    if(error){
      List errors = jsonDecode(response.body)['error'];
      showSnackBar(context, text: errors.first, error: error);
    }else{
      String msg = jsonDecode(response.body)['message'];
      showSnackBar(context, text: msg, error: error);
    }

  }

  Map<String, String> get header {
    return {
      'Authorization': 'Bearer ${SharedPreferencesController().token}',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json',
    };
  }

  Map<String, String> get baseHeader {
    return {
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json',
    };
  }
}
