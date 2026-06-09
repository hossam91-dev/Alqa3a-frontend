import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/gaps.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppGaps.g20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            SvgIcons.info,
            colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
          const Gap(AppGaps.g12),
          const AppText.title(
            AppStrings.doYouHaveQuestion,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          const Gap(AppGaps.g8),
          AppText.body(
            AppStrings.helpHint,
            color: AppColors.white.withAlpha(170),
            textAlign: TextAlign.center,
            fontSize: 12,
          ),
          const Gap(AppGaps.g16),
          AppButton(
            text: AppStrings.talkToUs,
            onPressed: () {},
            style: AppButtonStyle.filled,
            backgroundColor: AppColors.white,
            textColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
