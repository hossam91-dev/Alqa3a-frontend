import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/utils/helpers/app_validator.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/app_text_field.dart';
import 'package:alqa3a/features/auth/presentation/widgets/custom_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                      child: AppText.title(AppStrings.welcomeBack),
                    ),
                    Gap(AppGaps.g32),
                    AppText.caption(AppStrings.email),
                    Gap(AppGaps.g8),
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      hint: 'email@example.com',
                      controller: _emailController,
                      validator:(value)=> AppValidators.validateEmail(value),
                    ),
                    Gap(AppGaps.g16),
                    AppText.caption(AppStrings.password),
                    Gap(AppGaps.g8),
                    AppTextField(
                      isPassword: true,
                       hint: '••••••••',
                      controller: _passwordController,
                      validator:(value)=> AppValidators.validatePassword(value),
                       ),
                    Gap(AppGaps.g16),
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.otp);
                      },
                      child: AppText.button(AppStrings.forgotPassword,color: AppColors.primary,),
                    ),
                    Gap(AppGaps.g16),
                    AppButton(text: AppStrings.login, onPressed: () {
                      if(_formKey.currentState!.validate()){
                        // Perform login action
                      }
                    }),
                    Gap(AppGaps.g48),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Gap(AppGaps.g8),
                        AppText.body(AppStrings.or),
                        Gap(AppGaps.g8),
                        Expanded(child: Divider()),
                      ],
                    ),
                    Gap(AppGaps.g36),
                    OutlinedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SvgPicture.asset('assets/svg/google.svg'),
                        Gap(AppGaps.g8),
                        AppText.button(AppStrings.loginWithGoogle,color: AppColors.primary,),
                      ],),
                    ),
                    Gap(AppGaps.g50),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: ActionTextSpan(
                        message: AppStrings.dontHaveAccount,
                        actionText: AppStrings.registerNow,
                        onPressed: () => context.push(AppRoutes.register),
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
