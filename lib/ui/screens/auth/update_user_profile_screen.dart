import 'dart:io';

import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/network_image_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({Key? key}) : super(key: key);

  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> with Helper {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController addressController;
  late TextEditingController bdController;
  late bool isMale;
  late ImagePicker _imagePicker;
  XFile? _pickedFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: SharedPreferencesController().userModel.name);
    emailController = TextEditingController(text: SharedPreferencesController().userModel.email);
    mobileController = TextEditingController(text: SharedPreferencesController().userModel.mobile);
    addressController = TextEditingController(text: SharedPreferencesController().userModel.address);
    bdController = TextEditingController(text: SharedPreferencesController().userModel.dob);
    isMale = SharedPreferencesController().userModel.gender=='1'? true:false;
    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
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
            content: 'edit_profile'.tr,
            color: PRIMARY_TEXT_COLOR,
            fontSize: 18,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(32.h),
          children: [

            Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 120.h,
                width: 120.h,
                child: GestureDetector(
                  onTap: ()async{
                    PermissionStatus status = await Permission.storage.request();
                    if(status.isGranted){
                      pickImage();
                    }
                  },
                  child: Container(width: 60.h,height: 60.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      clipBehavior: Clip.antiAlias,
                    child:getImageFile()
                  ),
                ),
              ),
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
              text: 'update'.tr,
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
        addressController.text.isNotEmpty&&
        bdController.text.isNotEmpty) {

      if(!checkChangeData()){
        removeFocus();
        await update();
      }else{
        showSnackBar(context, text: 'data not changed',error: true);
      }

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
      initialDate: DateTime.now().subtract(const Duration(days: 10*365)),
      firstDate: DateTime.now().subtract(const Duration(days: 100*365)),
      lastDate: DateTime.now().subtract(const Duration(days: 10*365)),
    );
    if (dateTime != null) {
      DateFormat format =  DateFormat('yyyy-MM-dd');
      setState(() {
        bdController.text = format.format(dateTime);
      });
    }
  }

  Future<void> update() async {
    await AuthGetController.to.updateUserProfile(
        name: nameController.text,
        email: emailController.text,
        mobile: mobileController.text,
        address: addressController.text,
        gender: isMale?'1':'2',
        dob: bdController.text,
        image: _pickedFile!=null ? _pickedFile!.path : '');
  }

  Future<void> pickImage() async {
    _pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery,);
    if (_pickedFile != null) {
      setState(() {
      });
    }
  }


  Widget getImageFile(){
    if(_pickedFile != null ){
      return Image.file(File(_pickedFile!.path),fit: BoxFit.cover,);
    }else if(AuthGetController.to.userModel.value.image != ''){
      return NetworkImageWidget(height: double.infinity, width: double.infinity,boxFit: BoxFit.cover, image: SharedPreferencesController().userModel.image!);
    }
    else{
      return Container();
    }
  }

  bool checkChangeData(){
    if(
      nameController.text == AuthGetController.to.userModel.value.name &&
      emailController.text == AuthGetController.to.userModel.value.email &&
      mobileController.text == AuthGetController.to.userModel.value.mobile &&
      addressController.text == AuthGetController.to.userModel.value.address&&
      _pickedFile == null &&
      bdController.text == AuthGetController.to.userModel.value.dob &&
      SharedPreferencesController().userModel.gender == (isMale? '1':'2')
    ){
      return true;
    }
    return false;
  }

}
