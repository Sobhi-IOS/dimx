import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {

  final double height;
  final double width;
  bool? rounded;

  ShimmerWidget(
      {Key? key, required this.height, required this.width, this.rounded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey.shade50,
      baseColor: Colors.grey.shade200,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: rounded! ? BoxShape.circle : BoxShape.rectangle,
          color: Colors.grey.shade200,
        ),),

    );
    ;
  }
}
