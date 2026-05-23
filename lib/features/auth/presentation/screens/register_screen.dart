import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/utils/helpers/app_validator.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/app_text_field.dart';
import 'package:alqa3a/features/auth/presentation/widgets/custom_text_span.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
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
                      controller: _fullNameController,
                      validator: (value) =>
                          AppValidators.validateFullName(value),
                    ),
                    Gap(AppGaps.g16),
                    AppText.caption(AppStrings.phoneNumber),
                    Gap(AppGaps.g8),
                    AppTextField(
                      hint: '01xxxxxxxx',
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      validator: (value) => AppValidators.validatePhone(value),
                    ),
                    Gap(AppGaps.g16),
                    AppText.caption(AppStrings.email),
                    Gap(AppGaps.g8),
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      hint: 'email@example.com',
                      controller: _emailController,
                      validator: (value) => AppValidators.validateEmail(value),
                    ),
                    Gap(AppGaps.g16),
                    AppText.caption(AppStrings.password),
                    Gap(AppGaps.g8),
                    AppTextField(
                      isPassword: true,
                      hint: '••••••••',
                      controller: _passwordController,
                      validator: (value) =>
                          AppValidators.validatePassword(value),
                    ),
                    Gap(AppGaps.g16),
                    AppText.caption(AppStrings.confirmPassword),
                    Gap(AppGaps.g8),
                    AppTextField(
                      isPassword: true,
                      hint: '••••••••',
                      controller: _confirmPasswordController,
                      validator: (value) =>
                          AppValidators.validateConfirmPassword(
                            value,
                            _passwordController.text,
                          ),
                    ),
                    Gap(AppGaps.g16),
                    AppButton(
                      text: AppStrings.createAccount,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Perform registration action
                        }
                      },
                    ),

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
      ),
    );
  }
}
