import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/gaps.dart';
import '../../../../../core/constants/svg_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/empty_screen.dart';

class HallsWithDiscountsEmpty extends StatelessWidget {
  const HallsWithDiscountsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppGaps.g16),
          decoration: BoxDecoration(
              color: AppColors.successBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppColors.success,
                  width: 1
              )
          ),
          child: EmptyScreen(
            message: AppStrings.noOffersFound,
            icon: SvgIcons.ticketX,
            title: AppStrings.comingSoon,
            iconColor: AppColors.success,
          ),
        ));
  }
}
