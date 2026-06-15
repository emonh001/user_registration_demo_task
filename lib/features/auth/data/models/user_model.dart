class UserModel {
  final int? id;
  final String fullName;
  final String email;
  final String password;
  final String? phone;
  final String createdAt;
  final String? imagePath;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.phone,
    required this.createdAt,
    this.imagePath
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'created_at': createdAt,
      'image_path': imagePath,
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
      imagePath: map['image_path'],
    );
  }
}