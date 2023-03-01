
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dimax/get/order_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/models/address_model.dart';
import 'package:dimax/ui/screens/app/address_screen.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> with Helper{
  late TextEditingController _codeEditingController;
  late TextEditingController _addressEditingController;
  late TextEditingController _msgEditingController;
  late AddressModel? addressModel;

  @override
  void initState() {
    super.initState();
    _codeEditingController = TextEditingController();
    _addressEditingController = TextEditingController();
    _msgEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _codeEditingController.dispose();
    _addressEditingController.dispose();
    _msgEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'confirm_order'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.all(50.h),
        children: [
          SizedBox(
            height: 70.h,
          ),


          SizedBox(height: 60.h),
          AppTextFieldWidget(
            controller: _addressEditingController,
            label: 'address'.tr,
            line: 2,
            suffix: Icon(Icons.arrow_forward_ios, size: 13.h, color: Colors.grey,),
            onTap: ()async{
              AddressModel? address = await Get.to(const AddressScreen(fromConfirmOrder: true,));
              if(address!= null){
                setState(() {
                    addressModel = address;
                  _addressEditingController.text = address.name!;
                });
              }else{
                _addressEditingController.text = '';
              }

            },
            readeOnly: true,
          ),
          SizedBox(height: 15.h),

          AppTextFieldWidget(
            controller: _codeEditingController,
            label: 'code_optional'.tr,
          ),
          SizedBox(height: 15.h),

          AppTextFieldWidget(
            controller: _msgEditingController,
            label: 'note_optional'.tr,
            line: 8,
          ),

          SizedBox(
            height: 43.h,
          ),
          AppElevatedButton(
            text: 'send'.tr,
            onPressed: () async => await confirm(),
          ),
        ],
      ),
    );
  }

  Future performContactUs() async {
    if (checkData()) {
      await confirm();
    }
  }

  bool checkData() {
    if (_codeEditingController.text.isNotEmpty &&
        _addressEditingController.text.isNotEmpty &&
        _msgEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, text: 'enter_required_data'.tr, error: true);
    return false;
  }

  Future confirm() async {
    showAwesomeDialog(context: context,
        title: 'confirm_order'.tr,
        desc: 'confirm_order_msg'.tr,
        buttonText: 'continue'.tr,
        onTap: () async{
          bool status =  await OrderGetController.to.checkOut(
            addressId: addressModel!.id!,code: _codeEditingController.text ,note: _msgEditingController.text
          );
          if(status){
            setState(() {
              _msgEditingController.text = '';
              _codeEditingController.text = '';
              _addressEditingController.text = '';
            });
            showAwesomeDialog(context: context,
                title: 'successfully'.tr,
                desc: 'successfully_msg'.tr,
                buttonText: 'close'.tr,
                dialogType: DialogType.success,
                onTap: () {Get.to(const MainScreen()); }
            );
          }else{
            showAwesomeDialog(context: context,
                title: 'operation_failed'.tr,
                desc: 'operation_failed_msg'.tr,
                buttonText: 'close'.tr,
                dialogType: DialogType.error,
                onTap: () {Get.to(const MainScreen()); }
            );
          }
        }
    );

  }
}
