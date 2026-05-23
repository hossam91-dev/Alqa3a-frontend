import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/utils/helpers/otp_controller.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/features/auth/presentation/widgets/custom_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class OtpFormView extends StatelessWidget {
  final OtpController controller;
  final Function(String) onVerify;
  final VoidCallback? onResend;

  const OtpFormView({
    super.key,
    required this.controller,
    required this.onVerify,
    this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.baseHorizontal,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppText.headline(AppStrings.otpCode),
          Gap(AppGaps.g8),
          const AppText.caption(
            AppStrings.otpDescription,
            textAlign: TextAlign.center,
          ),
          Gap(AppGaps.g32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(controller.length, (index) {
              return SizedBox(
                width: 50,
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) =>
                      controller.handleBackspace(index, event, context),
                  child: TextField(
                    controller: controller.controllers[index],
                    focusNode: controller.focusNodes[index],
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(counterText: ""),
                    onChanged: (value) =>
                        controller.handleOnChanged(index, value, context),
                  ),
                ),
              );
            }),
          ),

          Gap(AppGaps.g24),
          ValueListenableBuilder<bool>(
            valueListenable: controller.isOtpCompleteNotifier,
            builder: (context, isCompleted, child) {
              return ElevatedButton(
                onPressed: isCompleted
                    ? () => onVerify(controller.otpCodeNotifier.value)
                    : null,

                child: const AppText.button( AppStrings.verify,color: AppColors.white,),
              );
            },
          ),
          Gap(AppGaps.g48),
          ActionTextSpan(
            message: AppStrings.didntReceiveOtp,
            actionText: AppStrings.resendOtp,
            onPressed: () {
              onResend?.call();
            },
          ),
        ],
      ),
    );
  }
}
