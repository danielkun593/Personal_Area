import 'package:flutter/material.dart';
import 'package:jsonapp/src/function/api_login.dart';
import 'package:jsonapp/views/pantalla1.dart';
import 'package:jsonapp/views/pantalla2.dart';
import 'package:http/http.dart' as http;
import 'package:jsonapp/views/pantallaCarga.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Login log = Login();
  bool success = false;
  late String email, password;
  final _formKey = GlobalKey<FormState>();
  final _user = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _user,
                  validator: (String? value) {
                    if(value != null && value.isEmpty){
                      return 'Ingrese el email';
                    }
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _password,
                  validator: (String? value) {
                    if(value != null && value.isEmpty){
                      return 'Ingrese el password';
                    }
                  },
                ),
                const SizedBox(height: 15),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OnePage(title: "Pantalla1")));
                        },
                        child: const Text("Pantalla1")
                    ),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=> const TwoPage(title: "Pantalla2")));
                        },
                        child: const Text("Pantalla2")
                    ),
                    ElevatedButton(
                        onPressed: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (builder)=> const ThreePage(title: "Pantalla3")));
                          //Navigator.push(context, MaterialPageRoute(builder: (builder)=> Carga(email: email, password: password)));

                          email = _user.text;
                          password = _password.text;

                          if (_formKey.currentState!.validate()) {
                            //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
                            loginSuccess(http.Client(), email, password);
                          }
                        },
                        child: const Text("Pantalla3")
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }

  loginSuccess(http.Client client, String e, String p) async{
    success = await log.dataUserLogin(client, e, p);
    if(success == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Carga(email: e, password: p)));
    }else if(success == false){
      print("falso");
    }
  }
}
