import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/app_toast.dart';
import '../../../../../core/widgets/app_button.dart';

class ResetPasswordHandler extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController codeController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const ResetPasswordHandler({
    super.key,
    required this.emailController,
    required this.codeController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthPasswordResetSuccess){
          context.go(AppRoutes.login);
          AppToast.show(
            message: AppStrings.resetPasswordSuccessMessage,
            context,
            type: ToastType.success,
            position: ToastPosition.top,
          );
        }
        if (state is AuthError) {
          AppToast.show(
            message: state.message,
            context,
            type: ToastType.error,
            position: ToastPosition.top,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: CustomLoadingIndicator(petalColor: AppColors.primary),
          );
        }
        return AppButton(
          text: AppStrings.resetPassword,
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              context.read<AuthCubit>().resetPassword(
                email: emailController.text,
                code: codeController.text,
                newPassword: passwordController.text,
              );
            }
          },
        );
      },
    );
  }
}
