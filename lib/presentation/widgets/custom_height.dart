import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomHeight extends StatelessWidget {
  const CustomHeight({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
    );
  }
}
