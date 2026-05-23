import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool enabled;

  const AppTextField({
    super.key,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.enabled = true,
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

        // استخدام الـ Theme الأساسي في حالة عدم تحقق الشرط، وتخطيه فقط عند النجاح
        focusedBorder: _isSuccess
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.success, width: 2.0),
              )
            : null,

        enabledBorder: _isSuccess
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.success, width: 1.5),
              )
            : null,

        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: _isSuccess ? AppColors.success : null,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : _isSuccess
            ? const Icon(Icons.check_circle, color: AppColors.success)
            : null,
      ),
    );
  }
}
