import 'package:dimax/ui/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerCartScreen extends StatelessWidget {
  const ShimmerCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: ShimmerWidget(
                width: double.infinity,
                height: 130.h,
              ),
            );
          },
            itemCount: 3,
            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
            shrinkWrap: true,)
          ,
        ),


        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  ShimmerWidget(height: 40.h, width: 120.w),
                  ShimmerWidget(height: 40.h, width: 80.w)
                ],
              ),
              SizedBox(height: 8.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 40.h, width: 100.w),
                  ShimmerWidget(height: 40.h, width: 60.w)
                ],
              ),
              SizedBox(height: 25.h,),
              ShimmerWidget(height: 60.h, width: double.infinity),
            ],
          ),
        ),

        SizedBox(height: 50.h,),
      ],
    );
  }
}
