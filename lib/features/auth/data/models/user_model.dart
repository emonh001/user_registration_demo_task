class UserModel {
  final int? id;
  final String fullName;
  final String email;
  final String password;
  final String? phone;
  final String createdAt;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.phone,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'created_at': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['full_name'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
      createdAt: map['created_at'],
    );
  }
}