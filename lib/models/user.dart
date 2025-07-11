import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final String username;
  final String birth;
  final String adress;
   final String token;
  User({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
    required this.birth,
    required this.adress,
     required this.token,
  });

  User copyWith({
    String? id,
    String? email,
    String? password,
    String? username,
    String? birth,
    String? adress,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      birth: birth ?? this.birth,
      adress: adress ?? this.adress,
     token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'username': username});
    result.addAll({'birth': birth});
    result.addAll({'adress': adress});
     result.addAll({'token': token});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      username: map['username'] ?? '',
      birth: map['birth'] ?? '',
      adress: map['address'] ?? '',
       token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, email: $email, password: $password, username: $username, birth: $birth, address: $adress , token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.password == password &&
        other.username == username &&
        other.birth == birth &&
        other.adress == adress &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        password.hashCode ^
        username.hashCode ^
        birth.hashCode ^
        adress.hashCode ^
       token.hashCode;
  }
}
