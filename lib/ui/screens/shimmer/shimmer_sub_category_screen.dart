import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerSubCategoryScreen extends StatelessWidget {
  const ShimmerSubCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          highlightColor: Colors.grey.shade50,
          baseColor: Colors.grey.shade200,
          child: Container(
            padding: EdgeInsets.all(10.h),
            margin: EdgeInsets.all(5.h),
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.h),
              border: Border.all(color: PRIMARY_COLOR),
              color: Colors.grey.shade200,
            ),
          ),
        );
      },
    );
  }
}
