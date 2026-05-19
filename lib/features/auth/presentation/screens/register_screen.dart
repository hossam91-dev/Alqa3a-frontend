import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/app_text_field.dart';
import 'package:alqa3a/features/auth/presentation/widgets/custom_text_span.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.baseHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: AppText.title(AppStrings.createNewAccount),
                  ),
                  Gap(AppGaps.g32),
                  AppText.caption(AppStrings.fullName),
                  Gap(AppGaps.g8),
                  AppTextField(
                    hint: 'الاسم كامل',
                    keyboardType: TextInputType.name,
                  ),
                  Gap(AppGaps.g16),
                  AppText.caption(AppStrings.phoneNumber),
                  Gap(AppGaps.g8),
                  AppTextField(
                    hint: '01xxxxxxxx',
                    keyboardType: TextInputType.phone,
                  ),
                  Gap(AppGaps.g16),
                  AppText.caption(AppStrings.email),
                  Gap(AppGaps.g8),
                  AppTextField(
                    keyboardType: TextInputType.emailAddress,
                    hint: 'email@example.com',
                  ),
                  Gap(AppGaps.g16),
                  AppText.caption(AppStrings.password),
                  Gap(AppGaps.g8),
                  AppTextField(isPassword: true, hint: '••••••••'),
                  Gap(AppGaps.g16),
                 AppText.caption( AppStrings.confirmPassword),
                  Gap(AppGaps.g8),
                  AppTextField(isPassword: true, hint: '••••••••'),
                  Gap(AppGaps.g16),
                  AppButton(text: AppStrings.createAccount, onPressed: () {}),
                 
                  Gap(AppGaps.g50),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: ActionTextSpan(
                      message: AppStrings.alreadyHaveAccount,
                      actionText: AppStrings.login,
                      onPressed: () => context.pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}