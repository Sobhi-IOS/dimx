import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingWidget extends StatelessWidget {
  final String label;
  final Icon leading;
  final IconData? trailingIcon;
  final Color labelColor;
  final void Function()? onTap;

  SettingWidget({Key? key,
    required this.label,
    required this.leading,
    this.trailingIcon,
    this.onTap,
    this.labelColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        margin: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.h),
        child: Row(
          children: [
            leading,
            SizedBox(width: 15.w),
            AppTextWidget(
              content: label,
              color: labelColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            const Spacer(),
            trailingIcon != null ? Icon(trailingIcon, size: 13.h, color: Colors.grey,) : Container(),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.h),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 3),
                blurRadius: 7,
                spreadRadius: 0)
          ],
        ),
      ),
    );
  }
}
