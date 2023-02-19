import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBackground extends StatefulWidget{
  const AddBackground({Key key}) : super(key: key);

  @override
  _AddBackgroundState createState()=> _AddBackgroundState();
}

class _AddBackgroundState extends State<AddBackground>{
  final bool _obscureText = true;
  String imagePicker;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xff170101),
              Color(0xFF360505),
              Color(0xFF490C0C),
              Color(0xff980d0d),
              Color(0xffbb0404),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Cambiar imagen de fondo"),
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 650,
                  width: 450,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Elige una imagen de fondo", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:[
                              Expanded(
                                  flex:1,
                                  child:ElevatedButton.icon(
                                      onPressed: () async {
                                        PickedFile _picketFile = await _picker.getImage(source: ImageSource.gallery);
                                        imagePicker = _picketFile.path;
                                        setState((){});
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          primary: const Color.fromRGBO(76, 142, 48, 20)
                                      ),
                                      icon: const Icon(Icons.add_photo_alternate_rounded),
                                      label: const Text('Cargar fotos',
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)))
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  flex:1,
                                  child:ElevatedButton.icon(
                                      onPressed: () async{
                                        PickedFile _picketFile = await _picker.getImage(source: ImageSource.camera);
                                        imagePicker = _picketFile.path;
                                        setState((){});
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          primary: const Color.fromRGBO(76, 142, 48, 20)
                                      ),
                                      icon: const Icon(Icons.camera_alt),
                                      label: const Text('Abrir camara',
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)))
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex:1,
                                child: SizedBox(
                                    height: 300,
                                    width: 450,
                                    child: Card(
                                      color: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: imagePicker == null ? Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.add_photo_alternate, size: 120),
                                              SizedBox(height: 5),
                                              Text("Añadir imagen de fondo",
                                                  style: TextStyle(fontSize: 18),
                                                  softWrap: true
                                              )
                                            ],
                                          )) : Image.file(File(imagePicker)),
                                    )
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {Navigator.pop(context, exitCode);},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    primary: const Color.fromRGBO(76, 142, 48, 20)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: const Text('Guardar cambios',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}