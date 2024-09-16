import 'package:flutter/material.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final EdgeInsets? margin;
  final Color? color;

  const CustomDivider({super.key, this.margin, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.sizeOf(context).width,
      color: color ?? AppColors.grey4,
      margin: margin,
    );
  }
}
