enum UserRole { superAdmin, admin, teacher, parent }

class UserModel {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> linkedChildIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.linkedChildIds = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.parent,
      ),
      linkedChildIds: List<String>.from(json['linked_child_ids'] ?? []),
    );
  }
}
