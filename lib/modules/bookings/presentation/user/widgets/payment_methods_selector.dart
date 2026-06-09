import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class PaymentMethodsSelector extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onSelect;

  const PaymentMethodsSelector({
    super.key,
    this.initialIndex = 0,
    required this.onSelect,
  });

  @override
  State<PaymentMethodsSelector> createState() => _PaymentMethodsSelectorState();
}

class _PaymentMethodsSelectorState extends State<PaymentMethodsSelector> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _handleSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onSelect(index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> paymentOptions = [
      {'name': AppStrings.creditCard, 'icon': SvgIcons.creditCard},
      {'name': AppStrings.cash, 'icon': SvgIcons.money},
      {'name': AppStrings.wallet, 'icon': SvgIcons.wallet},
    ];

    return Row(
      children: List.generate(paymentOptions.length, (index) {
        final isSelected = _selectedIndex == index;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == paymentOptions.length - 1 ? 0 : 8,
            ),
            child: GestureDetector(
              onTap: () => _handleSelect(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.errorBg : AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      paymentOptions[index]['icon'],
                      colorFilter: ColorFilter.mode(
                        isSelected ? AppColors.primary : AppColors.textLight,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Gap(8),
                    AppText.body(
                      paymentOptions[index]['name'],
                      fontSize: 12,
                      color: isSelected ? AppColors.primary : AppColors.textLight,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
