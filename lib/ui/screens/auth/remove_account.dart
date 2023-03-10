import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/bn_screen/home_screen.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RemoveAccountScreen extends StatefulWidget {
  const RemoveAccountScreen({Key? key}) : super(key: key);

  @override
  _RemoveAccountScreenState createState() => _RemoveAccountScreenState();
}

class _RemoveAccountScreenState extends State<RemoveAccountScreen> with Helper {
  late TextEditingController _currentPasswordEditingController;
  late TextEditingController _confirmationEditingController;

  @override
  void initState() {
    super.initState();
    _currentPasswordEditingController = TextEditingController();
    _confirmationEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordEditingController.dispose();
    _confirmationEditingController.dispose();
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
            content: 'remove_account'.tr,
            color: PRIMARY_TEXT_COLOR,
            fontSize: 18,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(32.h),
          children: [

            SizedBox(height: 70.h),

            AppTextWidget(
              content: 'remove_account_msg'.tr,
              color: Colors.grey,
              fontSize: 15,
              line: 5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.normal,
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h,top: 60.h),
              child: AppTextFieldWidget(
                controller: _currentPasswordEditingController,
                label: 'current_pass'.tr,
                isPassword: true,
              ),
            ),



            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                controller: _confirmationEditingController,
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
      await removeAccount();
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
    return _currentPasswordEditingController.text.isNotEmpty &&
        _confirmationEditingController.text.isNotEmpty &&
        _currentPasswordEditingController.text.isNotEmpty;
  }

  bool get isPasswordConfirmed {
    return _confirmationEditingController.text ==
        _currentPasswordEditingController.text;
  }

  Future removeAccount() async {
    bool status = await AuthGetController.to.removeAccount(
        currentPassword: _currentPasswordEditingController.text,
        newPassword: _confirmationEditingController.text);
    if(status){
      SharedPreferencesController().logout();
      Get.offAll(const MainScreen());
    }
  }

}
