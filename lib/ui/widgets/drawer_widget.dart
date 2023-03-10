import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerWidget extends StatelessWidget {

  final void Function()? onTap;
  final String label;

  const DrawerWidget({Key? key, required this.onTap, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: AppTextWidget(content: label,
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
