class Assesor{
  String name;
  String email;
  String phone;
  String typeAssesor;

  Assesor(this.name, this.phone, this.email, this.typeAssesor);

  Assesor.fromJson(Map<String, dynamic> json):
        name = json['nombre'],
        phone = json['telefono'],
        email = json['correo'],
        typeAssesor = json['asesoria'];

  Map<String, dynamic> toJson(){
    return{
      'nombre' : name,
      'telefono' : phone,
      'correo' : email,
      'asesoria' : typeAssesor
    };
  }
}

class getAssesorUser{
  String name;
  String email;
  String phone;
  String typeAssesor;

  getAssesorUser(this.name, this.phone, this.email, this.typeAssesor);

  getAssesorUser.fromJson(Map<String, dynamic> json):
        name = json['nombre'],
        phone = json['telefono'],
        email = json['correo'],
        typeAssesor = json['asesoria'];

  Map<String, dynamic> toJson(){
    return{
      'nombre' : name,
      'telefono' : phone,
      'correo' : email,
      'asesoria' : typeAssesor
    };
  }
}