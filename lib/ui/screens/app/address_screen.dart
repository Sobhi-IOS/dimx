import 'package:dimax/get/address_get_controller.dart';
import 'package:dimax/get/favorite_get_controller.dart';
import 'package:dimax/ui/screens/app/add_address_screen.dart';
import 'package:dimax/ui/screens/app/confirm_order_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_address_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_product_screen.dart';
import 'package:dimax/ui/widgets/address_widget.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/base_widget.dart';
import 'package:dimax/ui/widgets/product_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AddressScreen extends StatefulWidget {

  final bool fromConfirmOrder;
  const AddressScreen({Key? key, this.fromConfirmOrder = false}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  void initState() {
    AddressGetController.to.getAddress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'addresses'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(32.h),
        child: Column(
          children:  [
            Row(
              children: [
                AppTextWidget(content: 'saved_addresses'.tr,fontSize: 14,),
                const Spacer(),
                GestureDetector(
                  onTap: ()=>Get.to(AddAddressScreen()),
                  child: Row(
                    children: [
                      const Icon(Icons.add),
                      SizedBox(width: 3.w,),
                      AppTextWidget(content: 'add_address'.tr,fontSize: 14,),
                    ],
                  ),
                ),

              ],
            ),
            Expanded(
              child: GetX<AddressGetController>(
                builder: (controller) {
                  return BaseWidget(
                      lodgingWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
                        child: const ShimmerAddressScreen(),
                      ),
                      widget: ListView.builder(
                        itemCount: controller.address.length,
                        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              if(widget.fromConfirmOrder){
                                Get.back(
                                    result: controller.address.elementAt(index),
                                );
                              }
                            },
                              child: AddressWidget(addressModel: controller.address.elementAt(index),)

                          );
                        },
                      ),
                      loading: AddressGetController.to.loading.value,
                      complete: AddressGetController.to.complete.value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
