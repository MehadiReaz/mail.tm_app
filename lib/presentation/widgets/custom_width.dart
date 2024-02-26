import 'package:flutter/material.dart';

class CustomWidth extends StatelessWidget {
  const CustomWidth({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
