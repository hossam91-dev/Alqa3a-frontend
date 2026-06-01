import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool enabled;
  final String prefixIconPath;

  const AppTextField({
    super.key,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.enabled = true,
    required this.prefixIconPath,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isSuccess = false;
  bool _obscureText = true;

  void _handleValidation(String value) {
    if (value.isEmpty) {
      if (_isSuccess) {
        setState(() => _isSuccess = false);
      }
      return;
    }
    final isCurrentInputValid = widget.validator?.call(value) == null;

    if (_isSuccess != isCurrentInputValid) {
      setState(() {
        _isSuccess = isCurrentInputValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.isPassword
          ? TextInputType.visiblePassword
          : widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enabled,
      onChanged: _handleValidation,

      decoration: InputDecoration(
        hintText: widget.hint,

        focusedBorder: _isSuccess
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.success, width: 1.5),
              )
            : null,

        enabledBorder: _isSuccess
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.success, width: 1.5),
              )
            : null,

        suffixIcon: widget.isPassword
            ? GestureDetector(
              child: _TextFormIcon(
              prefixIconPath:  _obscureText ? SvgIcons.eyeOff : SvgIcons.eye,
                color: _isSuccess ? AppColors.success : AppColors.textLight,
              ),
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
            : _isSuccess
            ? _TextFormIcon(
                prefixIconPath: SvgIcons.circleCheck,
                color: AppColors.success,
              )
            : null,
        prefixIcon: _TextFormIcon(prefixIconPath: widget.prefixIconPath),
      ),
    );
  }
}

class _TextFormIcon extends StatelessWidget {
  final String prefixIconPath;
  final Color? color;
  const _TextFormIcon({required this.prefixIconPath, this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SvgPicture.asset(
        width: 20,
        prefixIconPath,
        color: color ?? AppColors.textLight,
      ),
    );
  }
}
