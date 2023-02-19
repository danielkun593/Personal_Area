import 'package:flutter/material.dart';
import 'package:jsonapp/class/photoClass.dart';
import 'package:jsonapp/class/userClass.dart';
import 'package:jsonapp/src/function/api_homepage.dart';
import 'package:jsonapp/src/function/api_photo.dart';
import 'package:http/http.dart' as http;

class TwoPage extends StatefulWidget {
  const TwoPage({super.key, required this.title});

  final String title;

  @override
  State<TwoPage> createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  DataUser user = DataUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Usuario>>(
          future: user.dataUserHome(http.Client()),
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
      child: SizedBox(
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
    );
  }
}