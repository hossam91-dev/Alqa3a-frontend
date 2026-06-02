
enum UserRole {
  hallOwner('hall_owner','صاحب قاعه'),
  user('user','مستخدم');

  final String jsonValue;
  final String label;
  const UserRole(this.jsonValue,this.label);

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
          (role) => role.jsonValue == value,
      orElse: () => UserRole.user,
    );
  }

  bool get isHallOwner => this == UserRole.hallOwner;
  bool get isUser => this == UserRole.user;
}





class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String? avatarUrl;
  final bool isEmailVerified;
  final UserRole role;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    this.avatarUrl,
    required this.isEmailVerified,
    required this.role,
  });
}