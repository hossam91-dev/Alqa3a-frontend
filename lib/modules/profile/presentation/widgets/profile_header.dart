import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../shared/auth/presentation/cubit/auth_cubit.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback onEditProfile;

  const ProfileHeader({
    super.key,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context,state){
        if(state is AuthSuccess){
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.border,
                  backgroundImage: state.user.avatarUrl != null ? NetworkImage(state.user.avatarUrl!) : null,
                  child: state.user.avatarUrl == null
                      ? const Icon(Icons.person, size: 50, color: AppColors.textLight)
                      : null,
                ),
              ),


              const Gap(AppGaps.g12),
              AppText.title(state.user.fullName, fontSize: 18),
              const Gap(AppGaps.g8),
              OutlinedButton(
                onPressed: onEditProfile,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                ),
                child: AppText.body('تعديل الملف الشخصي', color: AppColors.textLight),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },

    );
  }
}
