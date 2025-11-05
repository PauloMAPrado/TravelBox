class User {
  final String? id;
  final String name;
  final String cpf;
  final String email;
  final String phone;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id,
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.password,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'email': email,
      'phone': phone,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}