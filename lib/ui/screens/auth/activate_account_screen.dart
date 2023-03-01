import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivateAccountScreen extends StatefulWidget {

  const ActivateAccountScreen({Key? key}) : super(key: key);

  @override
  _ActivateAccountScreenState createState() => _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends State<ActivateAccountScreen> with Helper{
  String _code = '';
  late TextEditingController _codeTextController;

  @override
  void initState() {
    super.initState();

    _codeTextController = TextEditingController();

  }

  @override
  void dispose() {
    _codeTextController.dispose();
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
            content: 'activate_account'.tr,
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
              content: 'activate_account_msg'.tr,
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: 45.h),

            Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: AppTextFieldWidget(controller: _codeTextController, label: 'code'.tr)
            ),



            SizedBox(height: 30.h),
            AppElevatedButton(
              text: 'continue'.tr,
              onPressed: () async => await performActivateAccount(),
            ),
          ],
        ),
      ),
    );
  }

  Future performActivateAccount() async {
    if (checkData()) {
      removeFocus();
      await activateAccount();
    }
  }

  bool checkData() {
    if (isValidCode()) {
      return true;
    } else {
      showSnackBar(context, text: 'enter_required_data'.tr, error: true);
    }
    return false;
  }


  bool isValidCode() => code.isNotEmpty && _code.length == 5;

  String get code {
    return _code = _codeTextController.text;
  }

  Future activateAccount() async {
    bool status = await AuthGetController.to.activateAccount(code: code);
    if (status) {
      Get.offAll(const MainScreen());
    }
  }
}
