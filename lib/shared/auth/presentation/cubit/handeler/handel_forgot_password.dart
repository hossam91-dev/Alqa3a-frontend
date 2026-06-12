import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/utils/app_toast.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_button.dart';

class ForgotPasswordHandler extends StatelessWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  const ForgotPasswordHandler({
    super.key,
    required this.emailController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetSent) {
          context.go(AppRoutes.resetPassword);
        }
        if (state is AuthError) {
          AppToast.show(
            context,
            message: state.message,
            type: ToastType.error,
            position: ToastPosition.top,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: CustomLoading(),
          );
        }
        return AppButton(
          text: AppStrings.sendCode,
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              context.read<AuthCubit>().forgotPassword(emailController.text);
            }
          },
        );
      },
    );
  }
}
