import 'package:dimax/ui/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerProductDetailsScreen extends StatelessWidget {
  const ShimmerProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          ShimmerWidget(height: 380.h, width: double.infinity),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight:  Radius.circular(20.h),topLeft:  Radius.circular(20.h)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0.1, 2),
                    blurRadius: 4,
                    spreadRadius: 0)
              ],
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.h),topRight: Radius.circular(25.h))),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      ShimmerWidget(height: 25.h, width: 120.h),

                      ShimmerWidget(height: 52.h, width: 52.h,rounded: true,),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  ShimmerWidget(height: 25.h, width: 100.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerWidget(height: 25.h, width: 80.h),


                      Row(
                        children: [
                          ShimmerWidget(height: 40.h, width: 40.h,rounded: true,),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 5.w),
                            child: ShimmerWidget(height: 25.h, width: 20.h),
                          ),
                          ShimmerWidget(height: 40.h, width: 40.h,rounded: true,),
                        ],
                      )

                    ],
                  ),
                  Divider(height: 16.h,color: Colors.grey.shade200,),


                  ShimmerWidget(height: 25.h, width: 80.h),
                  SizedBox(height: 5.h,),
                  ShimmerWidget(height: 25.h, width: 220.h),

                  Divider(height: 16.h,color: Colors.grey.shade200,),
                  ShimmerWidget(height: 25.h, width: 80.h),
                  SizedBox(height: 8.h,),


                  Row(
                    children: [
                      ShimmerWidget(height: 45.h, width: 80.h),
                      SizedBox(width: 10.w,),
                      ShimmerWidget(height: 45.h, width: 80.h),
                    ],
                  ),




                  Divider(height: 25.h,color: Colors.grey.shade200,),
                  ShimmerWidget(height: 25.h, width: 80.h),
                  SizedBox(height: 8.h,),

                  Row(
                    children: [
                      ShimmerWidget(height: 45.h, width: 80.h),
                      SizedBox(width: 10.w,),
                      ShimmerWidget(height: 45.h, width: 80.h),
                      SizedBox(width: 10.w,),
                      ShimmerWidget(height: 45.h, width: 80.h),

                    ],
                  ),

                  Divider(height: 25.h,color: Colors.grey.shade200,),


                  Row(children: [

                    ShimmerWidget(height: 25.h, width: 70.h),
                    ShimmerWidget(height: 25.h, width: 40.h),

                  ],),



                  SizedBox(
                    height: 40.h,
                  ),

                  ShimmerWidget(height: 50.h, width: double.infinity),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
