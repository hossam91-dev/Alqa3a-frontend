import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ActionTextSpan extends StatelessWidget {
  final String message;
  final String actionText;
  final VoidCallback onPressed;
  final TextStyle? messageStyle;
  final TextStyle? actionStyle;

  const ActionTextSpan({
    super.key,
    required this.message,
    required this.actionText,
    required this.onPressed,
    this.messageStyle,
    this.actionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: message,
            style: messageStyle ?? 
              DefaultTextStyle.of(context).style,
          ),
          TextSpan(
            text: actionText,
            style: (actionStyle ?? 
              const TextStyle(color: AppColors.primary))
              .copyWith(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            recognizer: TapGestureRecognizer()
              ..onTap = onPressed,
          ),
        ],
      ),
    );
  }
}