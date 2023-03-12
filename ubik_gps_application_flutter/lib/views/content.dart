// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:ubik_gps_application_flutter/components/textString.dart';
import 'package:ubik_gps_application_flutter/icons/icon_create.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_login.dart';
import 'package:ubik_gps_application_flutter/src/models/userData.dart';
import 'package:ubik_gps_application_flutter/views/login.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_notification/notification.dart';
import 'package:ubik_gps_application_flutter/views/pages/home.dart';
import 'package:ubik_gps_application_flutter/views/pages/map_gps_ubik.dart';
import 'package:ubik_gps_application_flutter/views/pages/menu_user.dart';
import 'package:ubik_gps_application_flutter/views/pages/settings.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key key, @required this.email, @required this.password, @required this.token}) : super(key: key);

  final String email;
  final String password;
  final String token;

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> with SingleTickerProviderStateMixin{
  ApiLogin userdata = ApiLogin();

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }
  PageController pageController;

  iconNotications(List<Usuario> data){
    Widget notifications;
    for(var i in data){
      notifications = Text(i.notifications.toString(), style:const TextStyle(color: Colors.white, fontSize: 18));
    }
    return notifications;
  }
  infoCarga(){
    Widget cardCarga;
    cardCarga = const SizedBox(height: 225, width: 375, child: Center(child: CircularProgressIndicator()),);
    return cardCarga;
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          title: const TextString(text: "Ubik GPS"),
          leading: Container(
            padding: const EdgeInsets.only(left: 12),
            child: Image.asset("images/icon_ubik_logo.png", scale: 1),
          ),
          backgroundColor: Colors.transparent,
          elevation: 10,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Notificacion()));
                      },
                      icon: Stack(
                        children: [
                          const Icon(Icons.notifications, size: 42),
                          Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle
                                ),
                                child: FutureBuilder(
                                    future: userdata.dataUserHome(http.Client(), widget.email, widget.password),
                                    builder: (ctx, snapshot){
                                      if(snapshot.hasData){
                                        return iconNotications(snapshot.data);
                                      }
                                      else if(snapshot.hasError){
                                        return infoCarga();
                                      }
                                      return infoCarga();
                                    }
                                ),
                              )
                          ),
                        ],
                      )),
                  const SizedBox(width: 15),
                  IconButton(
                      onPressed: () {
                        logOut();
                      },
                      icon: const Icon(Icons.logout, size: 40)),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CircleNavBar(
          activeIcons:  const [
            Icon(Icons.home, color: Colors.white, size: 40),
            Icon(Icomoon.logoUbik, color: Colors.white, size: 65),
            Icon(Icons.settings, color: Colors.white, size: 40),
            Icon(Icons.menu, color: Colors.white, size: 40),
          ],
          inactiveIcons: const [
            Icon(Icons.home, color: Colors.white, size: 40),
            Icon(Icomoon.logoUbik, color: Colors.white, size: 65),
            Icon(Icons.settings, color: Colors.white, size: 40),
            Icon(Icons.menu, color: Colors.white, size: 40),
          ],
          color: const Color(0xffbb0404),
          height: 75,
          circleWidth: 70,
          activeIndex: tabIndex,
          onTap: (v) {
            tabIndex = v;
            pageController.jumpToPage(tabIndex);
          },
          //padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          shadowColor: Colors.blueGrey,
          elevation: 10,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (v) {
            tabIndex = v;
          },
          children:[
            Home(email: widget.email, password: widget.password, token: widget.token),
            MapGps(token: widget.token),
            MenuUser(),
            Settings(),
          ],
        )
    );
  }

  logOut() {
    setState(() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Cerrar Sesion", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: const Text("¿Estas seguro de querar cerrar sesion?", style: TextStyle(fontSize: 20), softWrap: true, textAlign: TextAlign.justify),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                                (route) => false);
                      },
                      child: const Text(
                        "Si",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red, fontSize: 20),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No", style: TextStyle(fontSize: 20)))
                ],
              )
            ],
            elevation: 3,
          ));
    });
  }
}