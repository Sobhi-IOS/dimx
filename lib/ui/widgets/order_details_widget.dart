import 'package:dimax/models/order_details.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailsWidget extends StatelessWidget {

  OrderProducts orderProducts;


  OrderDetailsWidget({required this.orderProducts});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            NetworkImageWidget(height: 80.h,boxFit: BoxFit.cover ,width: 80.h, image:  orderProducts.color!)
            ,SizedBox(width: 8.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    content: orderProducts.name??'',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    line: 2,
                  ),
                  SizedBox(height: 5.h,),
                  AppTextWidget(
                    content: "${orderProducts.price.toString()} " + 'aed'.tr,
                    fontSize: 14,
                    color: Colors.black,
                    line: 2,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 5.h,),
                  orderProducts.size != null ? AppTextWidget(
                    content: 'size'.tr +': '+ (orderProducts.size??''),
                    fontSize: 14,
                    color: Colors.black,
                    line: 2,
                    textAlign: TextAlign.center,
                  ):Container(),
                ],
              ),
            ),
            SizedBox(width: 15.w,),
            // Spacer(),
            AppTextWidget(
              content: 'quantity'.tr + ': '+  orderProducts.quantity.toString(),
              fontSize: 14,
              color: Colors.black,
              line: 2,
              textAlign: TextAlign.center,
            ),
          ],),
      ),
    );
  }
}
