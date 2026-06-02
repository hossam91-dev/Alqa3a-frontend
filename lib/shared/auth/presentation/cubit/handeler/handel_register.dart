import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/utils/app_toast.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/custom_loading_indicator.dart';

class RegisterHandler extends StatelessWidget {
  final TextEditingController fullName;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;
  final ValueNotifier<String> role;
  final GlobalKey<FormState> formKey;
  const RegisterHandler({
    super.key,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthNeedsVerification) {
          context.go(AppRoutes.otp);
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
          return const Center(
            child: CustomLoadingIndicator(petalColor: AppColors.primary),
          );
        }
        return AppButton(
          text: AppStrings.createAccount,
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              context.read<AuthCubit>().register(
                fullName: fullName.text,
                email: email.text,
                password: password.text,
                phoneNumber: phone.text,
                role: role.value,
              );
            }
          },
        );
      },
    );
  }
}
