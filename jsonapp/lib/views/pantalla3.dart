import 'package:flutter/material.dart';
import 'package:jsonapp/class/userClass.dart';
import 'package:jsonapp/src/function/api_homepage.dart';
import 'package:http/http.dart' as http;
import 'package:jsonapp/src/function/api_login.dart';
import 'package:jsonapp/views/pantalla4.dart';
import 'package:jsonapp/views/pantallaPrincipal.dart';

class ThreePage extends StatefulWidget {
  const ThreePage({super.key, required this.title, required this.email, required this.password});

  final String title;
  final String email;
  final String password;

  @override
  State<ThreePage> createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
  DataUser user = DataUser();
  Login log = Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const MyHomePage(title: 'Principal')));
              },
              icon: Icon(Icons.exit_to_app_sharp)
          )
        ],
      ),
      body: FutureBuilder<List<Usuario>>(
          future: log.dataUserHome(http.Client(), widget.email, widget.password),
          builder: (ctx, snapshot){
            if(snapshot.hasError){
              return const Center(child: Text("Error"));
            }else if(snapshot.hasData){
              return UserList(usuario: snapshot.data!);
            }
            return const Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key, required this.usuario});

  final List<Usuario> usuario;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            width: 400,
            child: Card(
              elevation: 15,
              child: Center(
                child: Text("Bienvenido ${usuario[index].name}, \ntiene ${usuario[index].notifications} notificaciones pendientes",
                    softWrap: true, textAlign: TextAlign.justify, style: const TextStyle(fontSize: 20)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> FourPage(title: "Pantalla4", token: usuario[index].jwt)));
              },
              child: const Text("Ver")
          )
        ],
      ),
    );
  }
}