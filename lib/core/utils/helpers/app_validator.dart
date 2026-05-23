import 'package:alqa3a/core/constants/app_strings.dart';

class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.validEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 8) {
      return AppStrings.passwordLength;
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordUppercase;
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return AppStrings.passwordLowercase;
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return AppStrings.passwordNumber;
    }

    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      return AppStrings.passwordSpecialCharacter;
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmYourPassword;
    }
    if (value != originalPassword) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fullNameRequired;
    }

    final nameRegex = RegExp(
      r"^[a-zA-Z\u0621-\u064A']+( [a-zA-Z\u0621-\u064A']+)+$",
    );

    if (!nameRegex.hasMatch(value.trim())) {
      return AppStrings.validFullName;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneRequired;
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return AppStrings.validPhone;
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${AppStrings.required}';
    }
    return null;
  }
}
