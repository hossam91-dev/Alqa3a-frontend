import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HallRulesSection extends StatelessWidget {
  const HallRulesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppGaps.g16),
        Container(
          padding: EdgeInsets.all(AppGaps.g12),
          decoration: BoxDecoration(
            color: AppColors.errorBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(SvgIcons.circleCheck,width: 15,),
                  Gap(AppGaps.g8),
                  AppText.body('دفعة مقدمة 25% لتأكيد الحجز')
                ],
              ),
              Gap(AppGaps.g8),
              Row(
                children: [
                  SvgPicture.asset(SvgIcons.circleCheck,width: 15,),
                  Gap(AppGaps.g8),
                  AppText.body('إمكانية التعديل قبل الموعد بـ 30 يوم')
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
