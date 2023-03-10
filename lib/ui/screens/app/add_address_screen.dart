import 'package:dimax/get/address_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/models/address_model.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_field_widget.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AddAddressScreen extends StatefulWidget {

  AddressModel? addressModel;

  AddAddressScreen({Key? key, this.addressModel}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> with Helper{
  late TextEditingController _nameEditingController;

  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController(text: widget.addressModel != null ?widget.addressModel!.name:'');

  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: widget.addressModel==null? 'add'.tr : 'edit'.tr,
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
          AppTextWidget(
            content: 'add_address_msg'.tr,
            color: Colors.grey,
            fontSize: 15,
            line: 5,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 60.h),

          AppTextFieldWidget(
            controller: _nameEditingController,
            label: 'address'.tr,
            line: 2,
          ),

          SizedBox(height: 60.h),



          SizedBox(
            height: 43.h,
          ),
          AppElevatedButton(
            text: widget.addressModel==null? 'add'.tr:'edit'.tr,
            onPressed: () async => await performContactUs(),
          ),
        ],
      ),
    );
  }

  Future performContactUs() async {
    if (checkData()) {
      await addAddress();
    }
  }

  bool checkData() {
    if (_nameEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, text: 'enter_required_data'.tr, error: true);
    return false;
  }

  Future addAddress() async {
    if(widget.addressModel != null){
      AddressModel address = AddressModel();
      address.id = widget.addressModel!.id;
      address.name = _nameEditingController.text;
      bool status = await AddressGetController.to.updateAddress(val: address);
      if (status) {
        Navigator.pop(context);
      }
    }else{
      AddressModel addressModel = AddressModel();
      addressModel.name = _nameEditingController.text;
      bool status =  await AddressGetController.to.createAddress(val: addressModel);
      if(status){
        setState(() {
          _nameEditingController.text = '';
        });
      }
    }
  }
}
