import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String? avatarUrl;
  final bool isEmailVerified;
  final UserRole role;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    this.avatarUrl,
    required this.isEmailVerified,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phone: json['phone'],
      avatarUrl: json['avatarUrl'],
      isEmailVerified: json['isEmailVerified'] ?? false,
      role: UserRole.fromString(json['role'] ?? 'user'),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      phone: phone,
      avatarUrl: avatarUrl,
      isEmailVerified: isEmailVerified,
      role: role,
    );
  }
}