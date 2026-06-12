import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HallBottomBar extends StatelessWidget {
  final String hallId;
  final double price;

  const HallBottomBar({
    super.key,
    required this.hallId,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppGaps.g16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        spacing: AppGaps.g10,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.body('إجمالي الحجز'),
              AppText.headline(
                '$price ج.م',
                color: AppColors.primary,
              ),
            ],
          ),
          Expanded(
            child: AppButton(
              text: 'احجز الآن',
              onPressed: () {
                context.pushReplacement(
                  AppRoutes.bookingPath(hallId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
