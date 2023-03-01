import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final FontWeight fontWeight;
   double? fontSize;
   String? fontFamily;
  final TextAlign textAlign;
  final void Function() onPressed;

  AppTextButton(
      {required this.text,
        this.textColor = Colors.white,
        this.fontFamily,
        this.fontWeight = FontWeight.normal,
        this.fontSize,
        this.textAlign = TextAlign.start,
        this.buttonColor = Colors.white,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: AppTextWidget(
        content: text,
        fontFamily: fontFamily,
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize??15,
      ),
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.h),
        ),
      ),
      onPressed: onPressed

    );
  }
}
