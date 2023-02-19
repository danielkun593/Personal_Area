import 'package:flutter/material.dart';
import 'package:jsonapp/class/asessorClass.dart';
import 'package:jsonapp/class/deviceClass.dart';
import 'package:jsonapp/src/function/api_assesor.dart';
import 'package:jsonapp/src/function/api_device.dart';
import 'package:http/http.dart' as http;

class FourPage extends StatefulWidget {
  const FourPage({super.key, required this.title, required this.token});

  final String title;
  final String token;

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  ApiAsessor asessor = ApiAsessor();
  String typeAsesor = "Asesoria de siniestros";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Assesor>>(
        future: asessor.getAsesor(http.Client(), widget.token, typeAsesor),
          builder: (ctx, snapshot){
            if(snapshot.hasError){
              return const Center(child: Text("Error"));
            }else if(snapshot.hasData){
              return DeviceList(asesor: snapshot.data!);
            }
            return const Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}

class DeviceList extends StatelessWidget {
  const DeviceList({super.key, required this.asesor});

  final List<Assesor> asesor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: asesor.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Column(
              children: [
                Text(asesor[index].name),
                Text(asesor[index].email),
                Text(asesor[index].phone),
                Text(asesor[index].typeAssesor),
              ],
            )
          );
        }
    );
  }
}