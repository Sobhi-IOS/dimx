import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CodeTextField extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final void Function(String value) onChanged;

  const CodeTextField({Key? key,
    required this.textController,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 50.h,
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.h),
            borderSide: BorderSide(
              width: 1.w,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.h),
            borderSide: BorderSide(
              width: 1.w,
              color: PRIMARY_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}
