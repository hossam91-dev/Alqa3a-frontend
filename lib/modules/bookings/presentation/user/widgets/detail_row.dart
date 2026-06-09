import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/gaps.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';

class DetailRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 20,
          colorFilter: ColorFilter.mode(AppColors.textMuted, BlendMode.srcIn),
        ),
        const Gap(AppGaps.g12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.body(label, color: AppColors.textMuted, fontSize: 12),
            AppText.body(value, fontWeight: FontWeight.bold),
          ],
        ),
      ],
    );
  }
}
