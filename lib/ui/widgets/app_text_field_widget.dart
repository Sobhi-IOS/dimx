import 'package:dimax/helpers/helper.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFieldWidget extends StatelessWidget with Helper{

  final TextEditingController? controller;

  final String label;
  final TextAlign textAlign;
  final bool isPassword;
  final TextInputType textInputType;
  final bool readeOnly;
  final int line;
  final Function()? onTap;
  final Widget? suffix;

  AppTextFieldWidget(
      {Key? key,
        required this.controller,
        required this.label,
        this.line = 1,
        this.textInputType = TextInputType.text,
        this.readeOnly = false,
        this.isPassword = false,
        this.suffix,
        this.onTap,
        this.textAlign =TextAlign.start,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.h),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(0, 3),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
      ),
      child: TextFormField(
        maxLines: line,
        controller: controller,
        readOnly: readeOnly,
        textAlign: textAlign,
        onTap: onTap,
        style: TextStyle(fontFamily: getFontFamily(), fontWeight: FontWeight.normal, color: PRIMARY_TEXT_COLOR, fontSize: getFontSize(16),),
        obscureText: isPassword,
        keyboardType: textInputType,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            suffixIcon: suffix,
            hintText: label,
            contentPadding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
            enabledBorder: createBorder(color: Colors.white),
            border: createBorder(color: PRIMARY_COLOR),
            focusedBorder: createBorder(color: PRIMARY_COLOR),
            errorBorder: createBorder(color: Colors.red),
            focusedErrorBorder: createBorder(color: Colors.red),
            errorStyle: TextStyle(color: Colors.red,fontSize: getFontSize(12),fontFamily: getFontFamily()),
            hintStyle: TextStyle(fontFamily: getFontFamily(), color: GRAY_COLOR, fontSize: getFontSize(14),
          ),

        ),
      ),
    );
  }

  OutlineInputBorder createBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.h),
      borderSide: BorderSide(color: color, width: 1.5.w),
    );
  }
}
