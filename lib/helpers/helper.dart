import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Helper {
  void showSnackBar(context, {required String text, bool error = false, int duration = 1500, String? actionTitle, Function()? onPressed,}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error ? Colors.red.shade900.withOpacity(0.7) : Colors.green.withOpacity(0.7),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: Duration(milliseconds: duration),
        content: AppTextWidget(
          content: text,
          color: Colors.white,
          fontSize: 13,
          line: 2,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),

      ),
    );
  }

  Future<bool> checkInternet(context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi||connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    showSnackBar(context, text: 'no_internet_connection'.tr,error: true);
    return false;
  }

  showCustomDialog({required context,required String title,required String description}){
    showDialog(context: context, builder: (context){
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(25.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(content: title,color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),
              SizedBox(height: 7.h,),
              AppTextWidget(content: description,color: Colors.grey,fontSize: 15,fontWeight: FontWeight.normal,line: 3,),
              SizedBox(height: 15.h,),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),

      );
    },barrierDismissible: false);
  }

  dismissDialog({required context}){
    Navigator.pop(context);
  }

  String getFontFamily({String? fontFamily}){
    return fontFamily ?? (SharedPreferencesController().languageCode == 'en' ? 'sf' : 'Almarai');
  }
  double getFontSize(double size){
    return SharedPreferencesController().languageCode == 'en' ? size.sp :(size-1.5).sp;
  }

  void removeFocus(){
    FocusManager.instance.primaryFocus?.unfocus();
  }

  showLoginDialong({required BuildContext context, DialogType dialogType =DialogType.info,
  }){
    AwesomeDialog(
        btnOk: AppElevatedButton(
          onPressed: ()=>Get.to(const LoginScreen()),
          text: 'login'.tr,
        ),
        context: context,
        dialogType: dialogType,
        headerAnimationLoop: false,
        title: 'login_alert_title'.tr,
        desc: 'login_alert_desc'.tr,
        descTextStyle: TextStyle(
          height: SharedPreferencesController().languageCode == 'en' ? 1.2:1.5,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: getFontSize(15),
          fontFamily: getFontFamily(),
        ),
        titleTextStyle: TextStyle(
          height: SharedPreferencesController().languageCode == 'en' ? 1.2:1.5,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: getFontSize(15),
          fontFamily: getFontFamily(),
        ),
        buttonsTextStyle: TextStyle(
          height: SharedPreferencesController().languageCode == 'en' ? 1.2:1.5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: getFontSize(15),
          fontFamily: getFontFamily(),
        )
    ).show();
  }


  showAwesomeDialog({
    required BuildContext context,
    required String title,
    required String desc,
    required buttonText,
    required void Function() onTap,
    DialogType dialogType =DialogType.info,}){
    AwesomeDialog(
        btnOk: AppElevatedButton(
          onPressed: onTap,
          text: buttonText,
        ),
        context: context,
        dialogType: dialogType,
        headerAnimationLoop: false,
        title: title,
        desc: desc,
        descTextStyle: TextStyle(
          height: SharedPreferencesController().languageCode == 'en' ? 1.2:1.5,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: getFontSize(15),
          fontFamily: getFontFamily(),
        ),
        titleTextStyle: TextStyle(
          height: SharedPreferencesController().languageCode == 'en' ? 1.2:1.5,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: getFontSize(15),
          fontFamily: getFontFamily(),
        ),
        buttonsTextStyle: TextStyle(
          height: SharedPreferencesController().languageCode == 'en' ? 1.2:1.5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: getFontSize(15),
          fontFamily: getFontFamily(),
        )
    ).show();
  }

}
