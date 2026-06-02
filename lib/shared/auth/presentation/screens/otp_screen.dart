import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/utils/app_toast.dart';
import 'package:alqa3a/core/utils/helpers/otp_controller.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_state.dart';
import 'package:alqa3a/shared/auth/presentation/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final OtpController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = OtpController(length: 6);
    _checkToken();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
  Future<void> _checkToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    print('Token in OTP Screen: $token');
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthOtpVerified) {
              context.go(AppRoutes.getHomeByRole(state.role));
            }
            if (state is AuthError) {
              AppToast.show(
                context,
                message: state.message,
                type: ToastType.error,
                position: ToastPosition.top,
              );
            }
            if (state is AuthResendOtpSuccess) {
              AppToast.show(
                context,
                message: 'تم اعاده ارسال الكود بنجاح',
                type: ToastType.success,
                position: ToastPosition.top,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CustomLoadingIndicator(
                  petalColor: AppColors.primary,
                ),
              );
            }
            return OtpFormView(
              controller: _otpController,
              onVerify: (code) {
                context.read<AuthCubit>().verifyOtp(code);
              },
              onResend: () {
                context.read<AuthCubit>().sendOtp();
              },
            );
          },
        ),
      ),
    );
  }
}
