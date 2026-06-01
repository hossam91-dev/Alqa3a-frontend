import 'package:alqa3a/core/error/app_exception.dart';
import 'package:alqa3a/core/utils/result.dart';
import 'package:alqa3a/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial());

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
  }) async {
    emit(AuthLoading());
    final result = await _authRepository.register(
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      role: UserRole.fromString(role),
    );
    switch (result) {
      case Success(data: var user):
        emit(AuthNeedsVerification(user.email));
      case Failure(error: var error):
        emit(AuthError(error.message));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    switch (result) {
      case Success(data: var user):
        emit(AuthSuccess(user));
      case Failure(error: var error):
        if (error.message.contains('تفعيل')) {
          emit(AuthNeedsVerification(email));
        } else {
          emit(AuthError(error.message));
        }
    }
  }

  Future<void> googleSignIn() async {
    emit(AuthGoogleSingInLoading());
    try {
      final googleSignIn = GoogleSignIn.instance;

      final googleUser = await googleSignIn.authenticate();

      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        emit(AuthError('فشل الحصول على رمز التعريف من Google'));
        return;
      }

      final result = await _authRepository.googleSignIn(idToken);
      switch (result) {
        case Success(data: var user):
          emit(AuthSuccess(user));
        case Failure(error: var error):
          emit(AuthError(error.message));
      }
    } catch (e) {
      print('Google Sign In Error: $e');
      emit(AuthError('فشل تسجيل الدخول بـ Google'));
    }
  }
  Future<void>sendOtp()async{
    final result = await _authRepository.sendOtp();
    switch(result){
      case Success():
        emit(AuthResendOtpSuccess());
      case Failure(error: var error):
        emit(AuthError(error.message));
    }
  }

  Future<void> verifyOtp(String code) async {
    emit(AuthLoading());
    final result = await _authRepository.verifyOtp(code);
    switch (result) {
      case Success(data: _):
        final meResult = await _authRepository.getMe();
        switch (meResult) {
          case Success(data: var user):
            emit(AuthOtpVerified(user.role));
          case Failure(error: var error):
            emit(AuthError(error.message));
        }
      case Failure(error: var error):
        emit(AuthError(error.message));
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    final result = await _authRepository.forgotPassword(email);
    switch (result) {
      case Success(data: _):
        emit(AuthPasswordResetSent());
      case Failure(error: var error):
        emit(AuthError(error.message));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(AuthLoading());
    final result = await _authRepository.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    switch (result) {
      case Success(data: _):
        emit(AuthPasswordResetSuccess());
      case Failure(error: var error):
        emit(AuthError(error.message));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
    emit(AuthLoggedOut());
  }
}
