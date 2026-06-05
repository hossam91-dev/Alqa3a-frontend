import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.home)) return 0;
    if (location.startsWith(AppRoutes.halls)) return 1;
    if (location.startsWith(AppRoutes.myBookings)) return 2;
    if (location.startsWith(AppRoutes.profile)) return 3;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    final routes = [
      AppRoutes.home,
      AppRoutes.halls,
      AppRoutes.myBookings,
      AppRoutes.profile,
    ];
    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: [
          BottomNavigationBarItem(
            icon: _NavBarIcon(
              iconPath: SvgIcons.home,
              isSelected: currentIndex == 0,
            ),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: _NavBarIcon(
              iconPath: SvgIcons.halls,
              isSelected: currentIndex == 1,
            ),
            label: AppStrings.halls,
          ),
          BottomNavigationBarItem(
            icon: _NavBarIcon(
              iconPath: SvgIcons.booking,
              isSelected: currentIndex == 2,
            ),
            label: AppStrings.bookings,
          ),
          BottomNavigationBarItem(
            icon: _NavBarIcon(
              iconPath: SvgIcons.profile,
              isSelected: currentIndex == 3,
            ),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final String iconPath;
  final bool isSelected;
  const _NavBarIcon({
    super.key,
    required this.iconPath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: 20,
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.primary : AppColors.textLight,
        BlendMode.srcIn,
      ),
    );
  }
}
