import 'package:flutter/material.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

class CommonCheckBox extends StatelessWidget {
  bool isChecked;
  final Color checkBoxColor;
  final double size;

  CommonCheckBox({
    required this.isChecked,
    this.size = 24,
    this.checkBoxColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isChecked ? checkBoxColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: isChecked ? null : Border.all(width: 1.6, color: AppColors.grey3)),
      child: Icon(
        Icons.check,
        color: isChecked ? AppColors.white : Colors.transparent,
      ),
    );
  }
}
