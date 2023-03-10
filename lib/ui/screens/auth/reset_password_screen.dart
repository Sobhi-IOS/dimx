import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/code_text_field.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with Helper{
  String _code = '';
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;
  late TextEditingController _codeEditingController;

  @override
  void initState() {
    super.initState();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();
    _codeEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();
    _codeEditingController.dispose();
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
            content: 'reset_password'.tr,
            color: PRIMARY_TEXT_COLOR,
            fontSize: 18,
          ),
        ),


        body: ListView(
          padding: EdgeInsets.all(32.h),
          shrinkWrap: true,
          children: [
            SizedBox(height: 70.h),
            AppTextWidget(
              content: 'reset_msg'.tr,
              color: Colors.grey,
              line: 5,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: 20.h,),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(controller: _codeEditingController, label: 'code'.tr)
            ),


            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                controller: _newPasswordEditingController,
                label: 'password'.tr,
                isPassword: true,
              ),
            ),


            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                controller: _newPasswordConfirmationEditingController,
                label: 'confirm_password'.tr,
                isPassword: true,
              ),
            ),


            SizedBox(height: 30.h),
            AppElevatedButton(
              text: 'continue'.tr,
              onPressed: () async => await performResetPassword(),
            ),
          ],
        ),
      ),
    );
  }

  Future performResetPassword() async {
    if (checkData()) {
      removeFocus();
      await resetPassword();
    }
  }

  bool checkData() {
    if (isValidCode() && isPasswordSet) {
      if (isPasswordConfirmed) {
        return true;
      }
      showSnackBar(context, text: 'confirm_password_msg_error'.tr, error: true);
    } else {
      showSnackBar(context, text: 'enter_required_data'.tr, error: true);
    }
    return false;
  }

  bool get isPasswordSet {
    return _newPasswordEditingController.text.isNotEmpty && _newPasswordConfirmationEditingController.text.isNotEmpty;
  }

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text == _newPasswordEditingController.text;
  }

  bool isValidCode() => code.isNotEmpty && _code.length == 5;



  String get code {
    return _code = _codeEditingController.text;
  }

  Future resetPassword() async {
    bool status = await AuthGetController.to.resetPassword(password: _newPasswordEditingController.text, code: code);
    if (status) {
      Get.offAll(const LoginScreen());
    }
  }
}
