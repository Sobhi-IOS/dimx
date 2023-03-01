
import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> with Helper{
  late TextEditingController _nameEditingController;
  late TextEditingController _phoneEditingController;
  late TextEditingController _msgEditingController;

  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController(text: SharedPreferencesController().loggedIn?SharedPreferencesController().userModel.name:'');
    _phoneEditingController = TextEditingController(text:SharedPreferencesController().loggedIn?SharedPreferencesController().userModel.mobile:'');
    _msgEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _phoneEditingController.dispose();
    _msgEditingController.dispose();
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
            content: 'contact_us'.tr,
            color: PRIMARY_TEXT_COLOR,
            fontSize: 18.sp,
          ),
        ),
        body: ListView(
          padding: EdgeInsetsDirectional.all(50.h),
          children: [
            SizedBox(
              height: 70.h,
            ),

            AppTextWidget(
              content: 'contact_us_msg'.tr,
              color: Colors.grey,
              fontSize: 15,
              line: 5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.normal,
            ),

            SizedBox(height: 60.h),

            AppTextFieldWidget(
              controller: _nameEditingController,
              label: 'name'.tr,
            ),
            SizedBox(height: 15.h),

            AppTextFieldWidget(
              controller: _phoneEditingController,
              label: 'mobile'.tr,
               textInputType: TextInputType.phone,
            ),
            SizedBox(height: 15.h),
            AppTextFieldWidget(
              controller: _msgEditingController,
              label: 'message'.tr,
              line: 8,
            ),

            SizedBox(
              height: 43.h,
            ),
            AppElevatedButton(
              text: 'send'.tr,
              onPressed: () async => await performContactUs(),
            ),
          ],
        ),
      ),
    );
  }

  Future performContactUs() async {
    if (checkData()) {
      await contactUs();
    }
  }

  bool checkData() {
    if (_nameEditingController.text.isNotEmpty &&
        _phoneEditingController.text.isNotEmpty &&
        _msgEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, text: 'enter_required_data'.tr, error: true);
    return false;
  }

  Future contactUs() async {
    bool status =  await AuthGetController.to.contactUs(phone: _phoneEditingController.text, msg: _msgEditingController.text,name: _nameEditingController.text);
    if(status){
      setState(() {
        _msgEditingController.text = '';
        _nameEditingController.text = '';
        _phoneEditingController.text = '';
      });
    }
  }
}
