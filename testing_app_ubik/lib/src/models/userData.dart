// ignore_for_file: sdk_version_ui_as_code
class Usuario {
  final String jwt;
  final String name;
  final String email;
  final int notifications;

  Usuario({this.jwt, this.name, this.email, this.notifications});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      jwt: json['jwt'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      notifications: json['notifications'] as int,
    );
  }
}
