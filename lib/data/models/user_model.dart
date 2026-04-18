class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.isAdmin,
  });

  // تحويل الكائن إلى خريطة
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'isAdmin': isAdmin,
    };
  }

  // تحويل خريطة إلى كائن
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      isAdmin: map['isAdmin'],
    );
  }
}
