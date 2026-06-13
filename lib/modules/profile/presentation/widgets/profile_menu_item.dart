import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.border.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.textLight,
                BlendMode.srcIn,
              ),
            ),
          ),
          title: AppText.body(title, fontSize: 14),
          trailing: SvgPicture.asset(
            SvgIcons.arrowLeft,
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(AppColors.textLight, BlendMode.srcIn),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppGaps.g12),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGaps.g12),
            child: Divider(height: 1, color: AppColors.border),
          ),
      ],
    );
  }
}
