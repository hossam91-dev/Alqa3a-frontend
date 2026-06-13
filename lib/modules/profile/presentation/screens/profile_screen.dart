import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_logout_button.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_stats_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.title('الملف الشخصي', fontSize: 20),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.g16),
        child: Column(
          children: [
            ProfileHeader(
              onEditProfile: () {},
            ),
            const Gap(AppGaps.g24),
            const ProfileStatsCard(
              bookingsCount: 3,
              favoriteHallsCount: 12,
              ratingsCount: 5,
            ),
            const Gap(AppGaps.g24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                    title: 'القاعات المفضلة',
                    icon: SvgIcons.favorite,
                    onTap: () => context.push(AppRoutes.savedHalls),
                  ),
                  ProfileMenuItem(
                    title: 'طرق الدفع',
                    icon: SvgIcons.creditCard,
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    title: 'اللغة (عربي/إنجليزي)',
                    icon: SvgIcons.languages,
                    onTap: () {},
                    showDivider: false,
                  ),
                ],
              ),
            ),
            const Gap(AppGaps.g16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                    title: 'الإشعارات',
                    icon: SvgIcons.notifications,
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    title: 'سياسة الخصوصية',
                    icon: SvgIcons.privacy,
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    title: 'المساعدة والدعم',
                    icon: SvgIcons.suport,
                    onTap: () {},
                    showDivider: false,
                  ),
                ],
              ),
            ),
            ProfileLogoutButton(),
          ],
        ),
      ),
    );
  }
}
