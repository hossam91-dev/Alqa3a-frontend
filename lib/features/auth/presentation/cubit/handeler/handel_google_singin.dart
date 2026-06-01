import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/utils/app_toast.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:alqa3a/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_loading_indicator.dart';

class GoogleSignInHandler extends StatelessWidget {
  const GoogleSignInHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, newState) {
        return previous != newState;
      },
      listener: (context, state) {
        if (state is AuthError) {
          AppToast.show(
            message: state.message,
            context,
            type: ToastType.error,
            position: ToastPosition.top,
          );
        }
        if (state is AuthSuccess) {
          context.go(AppRoutes.getHomeByRole(state.user.role));
        }
      },
      builder: (context, state) {
        if (state is AuthGoogleSingInLoading) {
          return const Center(
            child: CustomLoadingIndicator(petalColor: AppColors.primary),
          );
        }
        return OutlinedButton(
          onPressed: () {
            context.read<AuthCubit>().googleSignIn();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(SvgIcons.google),
              Gap(AppGaps.g8),
              AppText.button(
                AppStrings.loginWithGoogle,
                color: AppColors.primary,
              ),
            ],
          ),
        );
      },
    );
  }
}
