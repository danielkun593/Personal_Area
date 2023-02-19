class Usuario {
  final String jwt;
  final String name;
  final String email;
  final int notifications;

  Usuario({required this.jwt, required this.name, required this.email, required this.notifications});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      jwt: json['jwt'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      notifications: json['notifications'] as int,
    );
  }
}
