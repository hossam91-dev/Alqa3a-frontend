

import 'package:flutter/material.dart';

import '../constants/gaps.dart';
import '../theme/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.13,
      height: MediaQuery.sizeOf(context).height * 0.06,
      padding: EdgeInsets.all(AppGaps.g10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: CircularProgressIndicator(
        color: AppColors.white,
         strokeWidth: 4,
      ),
    );
  }
}

