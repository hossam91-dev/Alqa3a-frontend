import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/auth/presentation/cubit/auth_cubit.dart';
import '../../../../shared/auth/presentation/cubit/auth_state.dart';

class ProfileLogoutButton extends StatelessWidget {

  const ProfileLogoutButton({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context,state){
        if(state is AuthLoggedOut){
          context.go(AppRoutes.login);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppGaps.g16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          onTap: ()=>context.read<AuthCubit>().logout(),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.errorBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.logout, color: AppColors.primary, size: 20),
          ),
          title: AppText.body(
            'تسجيل الخروج',
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppGaps.g12),
        ),
      ),
    );
  }
}
