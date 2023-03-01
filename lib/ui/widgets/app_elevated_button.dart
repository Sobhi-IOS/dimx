

import 'package:dimax/helpers/helper.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';


class AppElevatedButton extends StatelessWidget with Helper{
  final String text;
  final Color textColor;
  final Color buttonColor;
  final FontWeight fontWeight;
  final double? fontSize;
  final String? fontFamily;
  final TextAlign textAlign;
  final void Function() onPressed;

  AppElevatedButton(
      {Key? key,
        required this.text,
        required this.onPressed,
        this.textColor = Colors.white,
        this.fontWeight = FontWeight.bold,
        this.textAlign = TextAlign.start,
        this.buttonColor = PRIMARY_COLOR,
        this.fontFamily,
        this.fontSize,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: AppTextWidget(
        content: text,
        fontFamily: fontFamily,
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize??18,
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50.h),
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
           18.h,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
