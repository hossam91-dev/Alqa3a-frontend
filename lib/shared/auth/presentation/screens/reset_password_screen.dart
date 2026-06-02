import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/app_text_field.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/handeler/handel_reset_password.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_padding.dart';
import '../../../../core/utils/helpers/app_validator.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.baseHorizontal,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: AppText.headline(AppStrings.resetPasswordHint),
                  ),
                  Gap(AppGaps.g32),
                  AppText.caption(AppStrings.email),
                  Gap(AppGaps.g8),
                  AppTextField(
                    prefixIconPath: SvgIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    hint: 'email@example.com',
                    validator: (value) => AppValidators.validateEmail(value),
                  ),
                  Gap(AppGaps.g16),
                  AppText.caption(AppStrings.otpCode),
                  Gap(AppGaps.g8),
                  AppTextField(
                    prefixIconPath: SvgIcons.code,
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    validator: (value) => AppValidators.validateRequired(
                      value,
                      AppStrings.otpCode,
                    ),
                  ),
                  Gap(AppGaps.g16),
                  AppText.caption(AppStrings.newPassword),
                  Gap(AppGaps.g8),
                  AppTextField(
                    isPassword: true,
                    hint: '••••••••',
                    prefixIconPath: SvgIcons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    validator: (value) => AppValidators.validatePassword(value),
                  ),
                  Gap(AppGaps.g16),
                  ResetPasswordHandler(
                      emailController: _emailController,
                      codeController: _codeController,
                      passwordController: _passwordController,
                      formKey: _formKey
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
