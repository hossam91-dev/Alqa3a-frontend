import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity, AppException>> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required UserRole role,
  });

  Future<Result<UserEntity, AppException>> login({
    required String email,
    required String password,
  });

  Future<Result<UserEntity, AppException>> googleSignIn(String idToken);

  Future<Result<UserEntity, AppException>> getMe();

  Future<Result<void, AppException>> sendOtp();

  Future<Result<void, AppException>> verifyOtp(String code);

  Future<Result<void, AppException>> forgotPassword(String email);

  Future<Result<void, AppException>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<void> logout();
}
