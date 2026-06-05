import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/gaps.dart';
import '../theme/app_colors.dart';
import 'app_text.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({
    super.key,
    required this.message,


  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppGaps.g8),
      child: Container(
        padding: EdgeInsets.all(AppGaps.g16),
        decoration: BoxDecoration(
            color: AppColors.errorBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: AppColors.error,
                width: 1
            )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppGaps.g6,
          children: [
            SvgPicture.asset(
              SvgIcons.error,
              width: 50,
              colorFilter: ColorFilter.mode(
                AppColors.error,
                BlendMode.srcIn,
              ),
            ),
            AppText.headline('خطا',color: AppColors.error,fontSize: 20,),
            AppText.body(message, textAlign: TextAlign.center),

          ],
        ),
      ),
    );
  }
}
