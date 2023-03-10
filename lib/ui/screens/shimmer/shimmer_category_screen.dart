import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoryScreen extends StatelessWidget {
  const ShimmerCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.h,
        childAspectRatio: 1 / 1.15,
        mainAxisSpacing: 10.w,
      ),
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey.shade200,
                child: Container(
                  height: 130.h,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Shimmer.fromColors(
                highlightColor: Colors.grey.shade50,
                baseColor: Colors.grey.shade200,
                child: Container(
                  height: 18.h,
                  width: 100.w,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
