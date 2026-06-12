import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.white,
      body: const Center(
        child: CustomLoading(),
      ),
    );
  }
}