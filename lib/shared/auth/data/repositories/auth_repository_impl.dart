import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  Future<Result<UserEntity, AppException>> _handleAuthResponse(
    Future<Result<dynamic, AppException>> Function() call,
  ) async {
    final result = await call();
    switch (result) {
      case Success(data: var data):
        await _secureStorage.write(
          key: 'access_token',
          value: data.accessToken,
        );
        return Success(data.user.toEntity());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<UserEntity, AppException>> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required UserRole role,
  }) {
    return _handleAuthResponse(
      () => _remoteDataSource.register(
        fullName: fullName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        role: role,
      ),
    );
  }

  @override
  Future<Result<UserEntity, AppException>> login({
    required String email,
    required String password,
  }) {
    return _handleAuthResponse(
      () => _remoteDataSource.login(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Result<UserEntity, AppException>> googleSignIn(String idToken) {
    return _handleAuthResponse(
      () => _remoteDataSource.googleSignIn(idToken),
    );
  }

  @override
  Future<Result<UserEntity, AppException>> getMe() async {
    final result = await _remoteDataSource.getMe();
    switch (result) {
      case Success(data: var data):
        return Success(data.toEntity());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<void, AppException>> sendOtp() {
    return _remoteDataSource.sendOtp();
  }

  @override
  Future<Result<void, AppException>> verifyOtp(String code) {
    return _remoteDataSource.verifyOtp(code);
  }

  @override
  Future<Result<void, AppException>> forgotPassword(String email) {
    return _remoteDataSource.forgotPassword(email);
  }

  @override
  Future<Result<void, AppException>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) {
    return _remoteDataSource.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> logout() async {
    await _secureStorage.delete(key: 'access_token');
  }
}