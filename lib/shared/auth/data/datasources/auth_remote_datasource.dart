import 'package:alqa3a/core/constants/api_constants.dart';
import 'package:alqa3a/shared/auth/domain/entities/user_entity.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/auth/data/models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSource(this._apiClient);

  Future<Result<AuthResponseModel, AppException>> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required UserRole role,
  }) {
    return _apiClient.post(
      ApiConstants.registerEndpoint,
      data: {
        'fullName': fullName,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'role': role == UserRole.hallOwner ? 'hall_owner' : 'user',
      },
      fromJson: (data) => AuthResponseModel.fromJson(data),
    );
  }

  Future<Result<AuthResponseModel, AppException>> login({
    required String email,
    required String password,
  }) {
    return _apiClient.post(
      ApiConstants.loginEndpoint,
      data: {
        'email': email,
        'password': password,
      },
      fromJson: (data) => AuthResponseModel.fromJson(data),
    );
  }

  Future<Result<AuthResponseModel, AppException>> googleSignIn(
    String idToken,
  ) {
    return _apiClient.post(
      ApiConstants.googleSignInEndpoint,
      data: {'idToken': idToken},
      fromJson: (data) => AuthResponseModel.fromJson(data),
    );
  }

  Future<Result<UserModel, AppException>> getMe() {
    return _apiClient.get(
      ApiConstants.userProfileEndpoint,
      fromJson: (data) => UserModel.fromJson(data),
    );
  }

  Future<Result<void, AppException>> sendOtp() {
    return _apiClient.post(
      ApiConstants.sendOtpEndpoint,
      fromJson: (_) {},
    );
  }

  Future<Result<void, AppException>> verifyOtp(String code) {
    return _apiClient.post(
      ApiConstants.verifyOtpEndpoint,
      data: {'code': code},
      fromJson: (_) {},
    );
  }

  Future<Result<void, AppException>> forgotPassword(String email) {
    return _apiClient.post(
      ApiConstants.forgotPasswordEndpoint,
      data: {'email': email},
      fromJson: (_) {},
    );
  }

  Future<Result<void, AppException>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) {
    return _apiClient.post(
      ApiConstants.resetPasswordEndpoint,
      data: {
        'email': email,
        'code': code,
        'newPassword': newPassword,
      },
      fromJson: (_) {},
    );
  }
}