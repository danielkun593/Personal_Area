class Assesor{
  final String name;
  final String email;
  final String phone;
  final String typeAssesor;

  Assesor({this.name, this.phone, this.email, this.typeAssesor});

  factory Assesor.fromJson(Map<String, dynamic> json){
    return Assesor(
        name: json['nombre'] as String,
        phone: json['telefono'] as String,
        email: json['correo'] as String,
        typeAssesor: json['asesoria'] as String
    );
  }
}