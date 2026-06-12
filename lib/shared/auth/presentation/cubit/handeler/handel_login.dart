import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/utils/app_toast.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginHandler extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  const LoginHandler({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

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
        if (state is AuthNeedsVerification) {
          context.go(AppRoutes.otp, extra: state.email);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CustomLoading(

            ),
          );
        }
        return AppButton(
          text: AppStrings.login,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthCubit>().login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
            }
          },
        );
      },
    );
  }
}
