import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductScreen extends StatelessWidget {
  const ShimmerProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.h,
        childAspectRatio: 1 / 1.6,
        mainAxisSpacing: 10.w,
      ),
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.bottomCenter,
          color: Colors.grey.shade50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                child: Shimmer.fromColors(
                  highlightColor: Colors.grey.shade100,
                  baseColor: Colors.grey.shade200,
                  child: Container(
                    height: 140.h,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),

              Shimmer.fromColors(
                highlightColor: Colors.grey.shade100,
                baseColor: Colors.grey.shade200,
                child: Container(
                  height: 18.h,
                  width: 200.w,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                ),
              ),

              SizedBox(height: 5.h,),

              Shimmer.fromColors(
                highlightColor: Colors.grey.shade100,
                baseColor: Colors.grey.shade200,
                child: Container(
                  height: 18.h,
                  width: 100.w,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                ),
              ),


              SizedBox(height: 15.h,),

              Shimmer.fromColors(
                highlightColor: Colors.grey.shade100,
                baseColor: Colors.grey.shade200,
                child: Container(
                  height: 18.h,
                  width: 50.w,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                ),
              ),

              SizedBox(height: 20.w,),

            ],
          ),
        );
      },
    );
  }
}
