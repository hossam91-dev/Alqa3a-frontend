import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

enum AppButtonStyle { filled, outlined }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final AppButtonStyle style;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.style = AppButtonStyle.filled,
    this.backgroundColor,
    this.textColor,
  });

  const AppButton.outlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.backgroundColor,
    this.textColor,
  }) : style = AppButtonStyle.outlined;

  @override
  Widget build(BuildContext context) {
    if (style == AppButtonStyle.outlined) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(double.infinity, height ?? 45),
          side: BorderSide(color: backgroundColor ?? AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: AppText.button(
          text,
          color: textColor ?? AppColors.primary,
        ),
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height ?? 45),
        backgroundColor: backgroundColor ?? AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: AppText.button(
        text,
        color: textColor ?? AppColors.white,
      ),
    );
  }
}
