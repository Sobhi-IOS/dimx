import 'package:dimax/models/order_model.dart';
import 'package:dimax/ui/screens/app/order_detials_screen.dart';
import 'package:dimax/ui/widgets/app_text_button.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderWidget extends StatelessWidget {

  final OrderModel orderModel;

  const OrderWidget({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(8.h),
      color: Colors.white,

      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                AppTextWidget(
                  content: orderModel.createdAt??'',
                  fontSize: 14,
                  color: PRIMARY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                  // line: 2,
                ),
                const Spacer(),

                AppTextWidget(
                  content: '${orderModel.fainalTotal??0.0}' + 'aed'.tr,
                  fontSize: 18,
                  color: PRIMARY_TEXT_COLOR,
                  fontWeight: FontWeight.bold,
                  // line: 2,
                ),
              ],
            ),
            SizedBox(height: 20.h,),

            Row(
              children: [
                AppTextWidget(
                  content: 'order_id'.tr + ': #',
                  fontSize: 16,
                  color: PRIMARY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                  // line: 2,
                ),

                AppTextWidget(
                  content: orderModel.invoiceNumber??'unlisted'.tr,
                  fontSize: 16,
                  color: PRIMARY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                  // line: 2,
                ),
              ],
            ),

            SizedBox(height: 10.h,),

            Row(
              children: [
                CircleAvatar(backgroundColor: PRIMARY_COLOR,radius: 8.h),
                SizedBox(width: 5.w,),
                AppTextWidget(
                  content: '${orderModel.status}',
                  fontSize: 16,
                  color: PRIMARY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                  // line: 2,
                ),

                const Spacer(),
                AppTextButton(text: 'view_details'.tr,
                    textColor: Colors.black,buttonColor: Colors.grey.shade100,
                    fontSize: 16,
                    onPressed: (){Get.to(OrderDetailsScreen(id: orderModel.id!));})
              ],

            ),
          ],
        ),
      ),
    );
  }
}
