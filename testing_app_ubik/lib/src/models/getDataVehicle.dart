class SelfVehicle{
  final String nombre;
  final String fecha;
  final String recorrido;
  final String year;
  final String marcaModelo;
  final String descripcion;
  final String contacto;

  SelfVehicle({this.nombre, this.fecha, this.recorrido, this.year, this.marcaModelo, this.descripcion, this.contacto});

  factory SelfVehicle.fromJson(Map<String, dynamic> json){
    return SelfVehicle(
      nombre: json['name'],
      fecha: json['fecha'],
      recorrido: json['recorrido'],
      year: json['ano'],
      marcaModelo: json['marca_modelo'],
      descripcion: json['descripcion'],
      contacto: json['contacto']
    );
  }
}