import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomNavBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          4,
          (index) => Expanded(
            child: NavBarTap(
              isSelected: selectedIndex == index,
              onTap: onTap,
              icon: getIcon(index),
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}

IconData getIcon(int index) {
  const icons = {
    0: Icons.home,
    1: Icons.search,
    2: Icons.favorite,
    3: Icons.person,
  };
  return icons[index] ?? Icons.home;
}


class NavBarTap extends StatelessWidget {
  final bool isSelected;
  final Function(int) onTap;
  final IconData icon;
  final int index;

  const NavBarTap({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Center(
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isSelected ? AppColors.white : AppColors.textBody,
            size: 24,
          ),
        ),
      ),
    );
  }
}