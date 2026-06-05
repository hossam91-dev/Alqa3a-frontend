import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

enum AppButtonStyle { filled, outlined }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final AppButtonStyle style;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.style = AppButtonStyle.filled,
  });

  const AppButton.outlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
  }) : style = AppButtonStyle.outlined;

  @override
  Widget build(BuildContext context) {
    if (style == AppButtonStyle.outlined) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(double.infinity, height ?? 45),
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: AppText.button(
          text,
          color: AppColors.primary,
        ),
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height ?? 45),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: AppText.button(
        text,
        color: AppColors.white,
      ),
    );
  }
}
