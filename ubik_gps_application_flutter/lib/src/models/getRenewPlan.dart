// ignore_for_file: file_names
class GetRenewPlan{
  final String name;
  final String email;
  final String phone;
  final String dispositivos;
  final String plan;
  final String value;

  GetRenewPlan({this.name, this.email, this.phone, this.dispositivos, this.plan, this.value});

  factory GetRenewPlan.fromJson(Map<String, dynamic> json){
    return GetRenewPlan(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      dispositivos: json['dispositivos'],
      plan: json['plan'],
      value: json['costo']
    );
  }
}