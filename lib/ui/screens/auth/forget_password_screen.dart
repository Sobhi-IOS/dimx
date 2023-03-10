
import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/ui/screens/auth/reset_password_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> with Helper{
  late TextEditingController _emailEditingController;
  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
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
          title: AppTextWidget(
            content: 'forget_password_title'.tr,
            color: PRIMARY_TEXT_COLOR,
            fontSize: 18,
          ),
        ),

        body: ListView(
          padding: EdgeInsets.all(32.h),
          children: [

            SizedBox(height: 70.h,),

            AppTextWidget(
              content: 'forget_password_msg'.tr,
              color: Colors.grey,
              line: 5,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,

            ),

            SizedBox(height: 60.h,),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                label: 'email'.tr,
                controller: _emailEditingController,
                textInputType: TextInputType.emailAddress,
              ),
            ),

            SizedBox(height: 30.h,),

            AppElevatedButton(
              text: 'continue'.tr,
              onPressed: ()async=> await performForgetPassword()
            ),
          ],
        ),
      ),
    );
  }


  Future performForgetPassword() async {
    if (checkData()) {
      removeFocus();
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, text: 'email_is_required'.tr, error: true);
    return false;
  }

  Future forgetPassword() async {
    bool status = await AuthGetController.to.forgetPassword(email: _emailEditingController.text);
    if (status) {
      Get.to(ResetPasswordScreen(email: _emailEditingController.text,));
    }
  }

}

