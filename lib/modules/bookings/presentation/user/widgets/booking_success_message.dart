import 'package:alqa3a/core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/svg_icons.dart';
import '../../../../../core/theme/app_colors.dart';

class BookingSuccessMessage extends StatelessWidget {
  const BookingSuccessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppGaps.g20),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(40),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        SvgIcons.circleCheck,
        colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn) ,
        width: 40,
      ),
    );
  }
}
