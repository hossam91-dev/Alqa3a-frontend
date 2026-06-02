import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';

import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/app_text_field.dart';

import 'package:alqa3a/shared/auth/presentation/cubit/handeler/handel_forgot_password.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_padding.dart';
import '../../../../core/utils/helpers/app_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.baseHorizontal,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppText.headline(AppStrings.forgotPassword),
                  Gap(AppGaps.g8),
                  AppText.body(AppStrings.forgotPasswordHint),
                  Gap(AppGaps.g32),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                      child: AppText.caption(AppStrings.email,)),
                  Gap(AppGaps.g8),
                  AppTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIconPath: SvgIcons.mail,
                    hint: 'email@example.com',
                    validator: (value) => AppValidators.validateEmail(value),
                  ),
                  Gap(AppGaps.g16),
                  ForgotPasswordHandler(
                    emailController: _emailController,
                    formKey: _formKey,
                  ),
                  Gap(AppGaps.g50),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: AppText.button(AppStrings.returnToLogin,color: AppColors.primary,),
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
