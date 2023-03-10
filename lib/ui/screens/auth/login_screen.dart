
import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/app/marketed_main_screen.dart';
import 'package:dimax/ui/screens/auth/forget_password_screen.dart';
import 'package:dimax/ui/screens/auth/register_screen.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helper{

  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  late TapGestureRecognizer recognizer;


  @override
  void initState() {
    super.initState();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    recognizer = TapGestureRecognizer();
    recognizer.onTap = navigateToCreateAccountScreen;
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    recognizer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: removeFocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: AppTextWidget(content: 'login'.tr, color: PRIMARY_TEXT_COLOR, fontSize: 18,),
        ),

        body: ListView(

          padding: EdgeInsets.all(32.h),

          children: [

            SizedBox(height: 45.h),

            SvgPicture.asset('assets/svg/logo.svg', height: 83.h, width: 61.21.w,),

            SizedBox(height: 80.h),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                controller: emailEditingController,
                textInputType: TextInputType.emailAddress,
                label: 'email'.tr,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                isPassword: true,
                controller: passwordEditingController,
                label: 'password'.tr,
              ),
            ),

            GestureDetector(
              onTap: () => Get.to(const ForgetPasswordScreen()),
              child: Container(
                alignment: AlignmentDirectional.centerEnd,
                child: AppTextWidget(content: 'forget_password'.tr),
              ),
            ),

            SizedBox(height: 42.h),

            AppElevatedButton(
              text: 'login'.tr,
              buttonColor: PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
              onPressed: ()=> checkForm(),
            ),

            SizedBox(height: 170.h),

            Container(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'dont_have_account'.tr,
                  style: TextStyle(color: Colors.grey, fontFamily: getFontFamily(), fontSize: getFontSize(15),),
                  children: [
                    TextSpan(
                      recognizer: recognizer,
                      text: '  '+'sign_up'.tr,
                      style: TextStyle(color:PRIMARY_TEXT_COLOR, fontFamily: getFontFamily(), fontSize: getFontSize(15)),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  navigateToCreateAccountScreen() {
    Get.to(const RegisterScreen());
  }

  checkForm(){
    if (emailEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty) {
      removeFocus();
      login();
    }else if(emailEditingController.text.isEmpty){
      showSnackBar(context, text: 'email_is_required'.tr ,error: true);
    }else if(passwordEditingController.text.isEmpty){
      showSnackBar(context, text: 'password_is_required'.tr ,error: true);
    }
  }

  Future<void> login() async {
    bool status = await AuthGetController.to.login(
        context: context,
        email: emailEditingController.text,
        password: passwordEditingController.text,
        fcmToken: SharedPreferencesController().getFcmToken??'');
    if (status) {
      if(SharedPreferencesController().isUser){
        Get.offAll(const MainScreen());
      }
      else if(SharedPreferencesController().isMarketed){
        Get.offAll(const MarektedMainScreen());
      }
    }
  }

}


