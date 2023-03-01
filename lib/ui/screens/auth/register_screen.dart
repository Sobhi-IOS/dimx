import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helper {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController passwordController;
  late TextEditingController addressController;
  late TextEditingController bdController;
  bool isMale = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    passwordController = TextEditingController();
    addressController = TextEditingController();
    bdController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    addressController.dispose();
    bdController.dispose();
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
            content: 'register'.tr,
            color: PRIMARY_TEXT_COLOR,
            fontSize: 18,
          ),
        ),

        body: ListView(
          padding: EdgeInsets.all(32.h),
          children: [
            SvgPicture.asset(
              'assets/svg/logo_blue.svg',
              height: 60.h,
              width: 60.h,
            ),

            SizedBox(height: 25.h),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                controller: nameController,
                suffix: const Icon(Icons.person, color: PRIMARY_COLOR),
                textInputType: TextInputType.text,
                label: 'name'.tr,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                isPassword: false,
                controller: emailController,
                suffix: const Icon(Icons.email, color: PRIMARY_COLOR),
                textInputType: TextInputType.emailAddress,
                label: 'email'.tr,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                controller: mobileController,
                suffix: const Icon(Icons.phone_android, color: PRIMARY_COLOR),
                textInputType: TextInputType.phone,
                label: 'mobile'.tr,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                controller: addressController,
                suffix: const Icon(Icons.add_location, color: PRIMARY_COLOR),
                textInputType: TextInputType.text,
                label: 'address'.tr,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                isPassword: true,
                controller: passwordController,
                suffix: const Icon(Icons.lock, color: PRIMARY_COLOR),
                textInputType: TextInputType.text,
                label: 'password'.tr,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: AppTextFieldWidget(
                readeOnly: true,
                controller: bdController,
                suffix: const Icon(Icons.calendar_today, color: PRIMARY_COLOR),
                textInputType: TextInputType.datetime,
                label: 'birthday'.tr,
                onTap: ()=>pickDate(context),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: PRIMARY_COLOR,
                    value: isMale,
                    onChanged: (var selected) {
                      setState(() {
                        isMale = true;
                      });
                    },
                    title: AppTextWidget(
                      content: 'male'.tr,
                      fontSize: 16,
                      color: PRIMARY_TEXT_COLOR,
                    ),
                  ),
                ),

                VerticalDivider(
                  color: Colors.red,
                  width: 20.w,
                  thickness: 5.h,
                ),

                Expanded(
                  child: CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: PRIMARY_COLOR,
                    value: !isMale,
                    onChanged: (var selected) {
                      setState(() {
                        isMale = false;
                      });
                    },
                    title: AppTextWidget(
                      content: 'female'.tr,
                      fontSize: 16,
                      color: PRIMARY_TEXT_COLOR,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 42.h),

            AppElevatedButton(
              text: 'register'.tr,
              buttonColor: PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
              onPressed: ()=>checkForm(context),
            ),

          ],
        ),
      ),
    );
  }

  checkForm(BuildContext context) async{
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty&&
        mobileController.text.isNotEmpty&&
        passwordController.text.isNotEmpty&&
        addressController.text.isNotEmpty&&
        bdController.text.isNotEmpty) {
      removeFocus();
      await register();
    }

    else if (nameController.text.isEmpty){
      showSnackBar(context, text: 'name_is_required'.tr,error: true);
    }
    else if(emailController.text.isEmpty){
      showSnackBar(context, text: 'email_is_required'.tr,error: true);
    }
    else if(mobileController.text.isEmpty){
      showSnackBar(context, text: 'mobile_is_required'.tr,error: true);
    }
    else if(passwordController.text.isEmpty){
      showSnackBar(context, text: 'password_is_required'.tr,error: true);
    }
    else if(addressController.text.isEmpty){
      showSnackBar(context, text: 'address_is_required'.tr,error: true);
    }
    else if(bdController.text.isEmpty){
      showSnackBar(context, text: 'birthday_is_required'.tr,error: true);
    }
  }

  Future pickDate(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 100*365)),
    );
    if (dateTime != null) {
      DateFormat format =  DateFormat('yyyy-MM-dd');
      setState(() {
        bdController.text = format.format(dateTime);
      });
    }
  }

  Future<void> register() async {
    bool status = await AuthGetController.to.register(
      name: nameController.text,
      email: emailController.text,
      mobile: mobileController.text,
      password: passwordController.text,
      address: addressController.text,
      gender: isMale ? '1' : '2',
      dob: bdController.text,
      passwordConfirmation: passwordController.text,
    );
    if (status) {
      Get.offAll(const LoginScreen());
    }
  }
}
