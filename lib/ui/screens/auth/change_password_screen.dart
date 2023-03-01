import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with Helper {
  late TextEditingController _oldPasswordEditingController;
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;

  @override
  void initState() {
    super.initState();
    _oldPasswordEditingController = TextEditingController();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();
    _newPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: removeFocus,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppTextWidget(
            content: 'change_password'.tr,
            color: PRIMARY_TEXT_COLOR,
            fontSize: 18,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(32.h),
          children: [

            SizedBox(height: 70.h),

            AppTextWidget(
              content: 'chang_password_msg'.tr,
              color: Colors.grey,
              fontSize: 15,
              line: 5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.normal,
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h,top: 60.h),
              child: AppTextFieldWidget(
                controller: _oldPasswordEditingController,
                label: 'old_password'.tr,
                isPassword: true,
              ),
            ),


            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                controller: _newPasswordEditingController,
                label: 'new_password'.tr,
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

            SizedBox(height: 30.h,),


            AppElevatedButton(
              text: 'continue'.tr,
              onPressed: () async => await performChangePassword(),
            ),
          ],
        ),
      ),
    );
  }

  Future performChangePassword() async {
    if (checkData()) {
      removeFocus();
      await changePassword();
    }
  }

  bool checkData() {
    if (isPasswordSet) {
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
    return _newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty &&
        _oldPasswordEditingController.text.isNotEmpty;
  }

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text ==
        _newPasswordEditingController.text;
  }

  Future changePassword() async {
    bool status = await AuthGetController.to.changePassword(
        currentPassword: _oldPasswordEditingController.text,
        newPassword: _newPasswordConfirmationEditingController.text);
    if(status){
      _newPasswordEditingController.text = '';
      _newPasswordConfirmationEditingController.text='';
      _oldPasswordEditingController.text='';
    }
  }

}
