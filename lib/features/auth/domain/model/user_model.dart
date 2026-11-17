class UserModel {
  final String id;
  final String name;
  final String username;
  final String password;
  final int age;
  final String country;
  final List<String> habits;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.age,
    required this.country,
    this.habits = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'age': age,
      'country': country,
      'habits': habits,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      age: map['age'] ?? 0,
      country: map['country'] ?? '',
      habits: List<String>.from(map['habits'] ?? []),
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? username,
    String? password,
    int? age,
    String? country,
    List<String>? habits,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      age: age ?? this.age,
      country: country ?? this.country,
      habits: habits ?? this.habits,
    );
  }
}
