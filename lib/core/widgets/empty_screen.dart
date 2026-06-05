import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_text.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  final String icon;
  final String title;
  final Color? iconColor;
  const EmptyScreen({
    super.key,
    required this.message,
    required this.icon,
    required this.title, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppGaps.g6,
      children: [
        SvgPicture.asset(
          icon,
          width: 50,
          colorFilter: ColorFilter.mode(iconColor?? AppColors.primary, BlendMode.srcIn,),
        ),
        AppText.headline(title),
        AppText.body(message,textAlign: TextAlign.center),

      ],
    );
  }
}
