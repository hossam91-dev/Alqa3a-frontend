import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HallInfoSection extends StatelessWidget {
  final String name;
  final String address;
  final double price;
  final int capacity;

  const HallInfoSection({
    super.key,
    required this.name,
    required this.address,
    required this.price,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppGaps.g8,
      children: [
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: AppText.displayLarge(name),
        ),
        Row(
          spacing: AppGaps.g4,
          children: [
            SvgPicture.asset(
              SvgIcons.map,
              width: 15,
              colorFilter: ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            AppText.body(address),
          ],
        ),
        Gap(AppGaps.g16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.body('سعر الحجز'),
                AppText.headline(
                  '$price ج.م',
                  color: AppColors.primary,
                ),
              ],
            ),
            Row(
              spacing: AppGaps.g4,
              children: [
                SvgPicture.asset(
                  SvgIcons.users,
                  width: 13,
                ),
                AppText.body('سعه $capacity فرد')
              ],
            ),
          ],
        ),
      ],
    );
  }
}
