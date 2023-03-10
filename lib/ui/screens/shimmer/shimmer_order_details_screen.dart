import 'package:dimax/ui/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrderDetailsScreen extends StatelessWidget {
  const ShimmerOrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Colors.white,
          elevation: 0.1,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(height: 30.h, width: 90.w),
                SizedBox(height: 10.h,),

                ShimmerWidget(height: 30.h, width: 120.w),
                SizedBox(height: 10.h,),


                ShimmerWidget(height: 30.h, width: 80.w),
                SizedBox(height: 10.h,),
                ShimmerWidget(height: 30.h, width: 180.w),
              ],
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.all(5.h),
            itemBuilder: (context, index) {
              return Card(
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ShimmerWidget(height: 80.h, width: 80.h),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerWidget(height: 30.h, width: 80.h),
                            SizedBox(height: 5.h,),
                            ShimmerWidget(height: 30.h, width: 50.h),
                          ],
                        ),
                      ),
                      SizedBox(width: 15.w,),
                      // Spacer(),
                      ShimmerWidget(height: 30.h, width: 80.h),
                    ],),
                ),
              );
            },),
        ),

        Padding(
          padding:  EdgeInsets.all(15.h),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(height: 30.h, width: 50.h),
                  SizedBox(height: 3.h,),
                  ShimmerWidget(height: 30.h, width: 80.h),
                ],
              ),
              const Spacer(),
              ShimmerWidget(height: 50.h, width: 120.h),
            ],
          ),
        ),
        SizedBox(height: 20.h,)
      ],
    );
  }
}
