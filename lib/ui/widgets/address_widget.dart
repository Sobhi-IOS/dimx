import 'package:dimax/get/address_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/models/address_model.dart';
import 'package:dimax/ui/screens/app/add_address_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddressWidget extends StatelessWidget with Helper{

  late AddressModel addressModel;
  AddressWidget({Key? key, required this.addressModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 0.5,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Row(
          children: [
             CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.location_on,
                color: PRIMARY_COLOR,
                size: 35.h,
              ),
            ),
            SizedBox(width: 8.w,),
            Expanded(child: AppTextWidget(content:addressModel.name!,fontSize: 14,line: 5,)),
            PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
                itemBuilder: (context){
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: AppTextWidget(content: 'delete'.tr),
                    ),

                    PopupMenuItem<int>(
                      value: 1,
                      child: AppTextWidget(content: 'edit'.tr),
                    ),

                  ];
                },
                onSelected:(value)async{
                  if(await checkInternet(context)){
                    if(value == 0){
                      AddressGetController.to.deleteAddress(addressId: addressModel.id!);
                    }else if(value == 1){
                      Get.to(AddAddressScreen(addressModel: addressModel,));
                    }
                  }
                }
            ),

          ],
        ),
      ),
    );
  }
}
