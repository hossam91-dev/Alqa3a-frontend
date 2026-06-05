import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_text.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  final String icon;
  final String title;
  const EmptyScreen({
    super.key,
    required this.message,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppGaps.g6,
      children: [
        AppText.headline(title),
        AppText.body(message,textAlign: TextAlign.center),
        SvgPicture.asset(
          icon,
          width: 50,
          colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn,),
        ),
      ],
    );
  }
}
