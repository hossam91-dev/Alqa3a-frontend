import '../../domain/entities/user_entity.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthGoogleSingInLoading extends AuthState {}
class AuthResendOtpSuccess extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess(this.user);
}



class AuthNeedsVerification extends AuthState {
  final String email;
  AuthNeedsVerification(this.email);
}

class AuthOtpSent extends AuthState {}

class AuthOtpVerified extends AuthState {
  final UserRole role;
  AuthOtpVerified(this.role);
}

class AuthPasswordResetSent extends AuthState {}

class AuthPasswordResetSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggedOut extends AuthState {}