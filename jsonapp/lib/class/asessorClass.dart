class Assesor{
  final String name;
  final String email;
  final String phone;
  final String typeAssesor;

  Assesor({required this.name, required this.phone, required this.email, required this.typeAssesor});

  factory Assesor.fromJson(Map<String, dynamic> json){
    return Assesor(
        name: json['nombre'] as String,
        phone: json['telefono'] as String ,
        email: json['correo'] as String,
        typeAssesor: json['asesoria'] as String
    );
  }
}