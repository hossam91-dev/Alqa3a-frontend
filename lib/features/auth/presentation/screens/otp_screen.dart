import 'package:alqa3a/core/utils/helpers/otp_controller.dart';
import 'package:alqa3a/features/auth/presentation/widgets/otp_form.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final OtpController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = OtpController(length: 6); 
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body:  Center(
          child: OtpFormView(controller: _otpController, onVerify: (code){}),
        ),
      ),
    );
  }
}