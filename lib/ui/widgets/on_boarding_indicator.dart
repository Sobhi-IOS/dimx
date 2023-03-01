import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingIndicator extends StatelessWidget {
  final bool isSelected;
  const OnBoardingIndicator({Key? key, this.isSelected = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 10.h,
      width: 10.h,
      decoration: BoxDecoration(
        color: isSelected ? PRIMARY_COLOR : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}