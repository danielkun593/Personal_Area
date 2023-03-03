// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ubik_gps_application_flutter/components/buttonDesign.dart';
import 'package:ubik_gps_application_flutter/components/buttonIconDesign.dart';
import 'package:ubik_gps_application_flutter/components/cardWidget.dart';
import 'package:ubik_gps_application_flutter/components/dateEditTextField.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/components/editTextField.dart';
import 'package:ubik_gps_application_flutter/components/textString.dart';
import 'package:ubik_gps_application_flutter/icons/icon_create.dart';
import 'package:ubik_gps_application_flutter/src/functions/api_smartcare_addbuy.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/smartcare.dart';

class AddCar extends StatefulWidget{
  const AddCar({Key key, @required this.token}) : super(key: key);

  final String token;

  @override
  _AddCarState createState()=> _AddCarState();
}

class _AddCarState extends State<AddCar>{
  String imagePicker;
  String nameu, dater, marcav, yearv, modelv, descriptionv, numberu, km;
  final ImagePicker _picker = ImagePicker();
  DateTime _selectedYear = DateTime.now();
  bool registerOK = false;
  ApiSmartCare smartCare = ApiSmartCare();

<<<<<<< HEAD
  final _fecha = TextEditingController();
  final _kilometro = TextEditingController();
  final _marca = TextEditingController();
  final _modelo = TextEditingController();
  final _anio  = TextEditingController();
  final _descripcion  = TextEditingController();
  final _name = TextEditingController();
  final _number = TextEditingController();
=======
  final fecha = TextEditingController();
  final kilometro = TextEditingController();
  final marca = TextEditingController();
  final modelo = TextEditingController();
  final anio  = TextEditingController();
  final descripcion  = TextEditingController();
  final name = TextEditingController();
  final number = TextEditingController();
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const TextString(text: 'VENDE TU VEHICULO',),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 20, left: 10, right: 10, top: MediaQuery.of(context).size.height*0.035),
          child: SingleChildScrollView(
            child: Column(
              children:<Widget>[
                const TextString(text: "Datos del vehiculo"),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: DateEditTextField(
                          onTap: (){
                            pickedDate();
                          },
                          hintext: "Fecha de registro",
<<<<<<< HEAD
                          textEditingController: _fecha,
=======
                          textEditingController: fecha,
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
                          icon: const Icon(Icons.calendar_month),
                          textInputType: TextInputType.text,
                        ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                        flex: 1,
                        child: EditTextField(
                          icon: const Icon(Icons.speed),
                          textEditingController: _kilometro,
                          textInputType: TextInputType.number,
                          hintext: "Kilometraje",
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: EditTextField(
                          icon: const Icon(Icomoon.carUbik),
                          textEditingController: _marca,
                          textInputType: TextInputType.text,
                          hintext: "Marca del vehiculo",
                        )
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: DateEditTextField(
                        onTap: (){
                          pickedYearDate();
                        },
                        hintext: "Año del vehiculo",
<<<<<<< HEAD
                        textEditingController: _anio,
=======
                        textEditingController: anio,
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
                        icon: const Icon(Icons.calendar_month),
                        textInputType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: EditTextField(
                          icon: const Icon(Icomoon.modelCar),
                          textEditingController: _modelo,
                          textInputType: TextInputType.text,
                          hintext: "Modelo del vehiculo",
                        )
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: ButtonIconWidget(
                          function: ()async{
                            PickedFile _picketFile = await _picker.getImage(source: ImageSource.gallery);
                            imagePicker = _picketFile.path;
                            setState((){});
                          },
                          iconData: Icons.image,
                          size: 35,
                          color: const Color(0xffbb1515),
                          circular: 5,
                          namebutton: "Cargar imagen",
                        )
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                        flex: 1,
                        child: ButtonIconWidget(
                          function: ()async{
                            PickedFile _picketFile = await _picker.getImage(source: ImageSource.camera);
                            imagePicker = _picketFile.path;
                            setState((){});
                          },
                          iconData: Icons.camera,
                          size: 35,
                          color: const Color(0xffbb1515),
                          circular: 5,
                          namebutton: "Usar camara",
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const CardWidget(
                  width: 500,
                  height: 300,
                  circular: 10,
                  widget: Center(
                    child: Text("Imagen", style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(height: 15),
                const TextString(text: "Datos del vendedor"),
                const SizedBox(height: 15),
<<<<<<< HEAD
                EditTextField(
                  textEditingController: _name,
                  textInputType: TextInputType.text,
                  hintext: "Nombre Completos del vendedor",
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                EditTextField(
                  textEditingController: _number,
                  textInputType: TextInputType.text,
                  hintext: "Numero telefonico registrado",
                  icon: const Icon(Icons.phone),
                ),
                const SizedBox(height: 10),
                EditTextField(
                  textEditingController: _descripcion,
                  textInputType: TextInputType.text,
=======
                EditTextField(
                  textEditingController: name,
                  textInputType: TextInputType.text,
                  hintext: "Nombre Completos del vendedor",
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                EditTextField(
                  textEditingController: number,
                  textInputType: TextInputType.text,
                  hintext: "Numero telefonico registrado",
                  icon: const Icon(Icons.phone),
                ),
                const SizedBox(height: 10),
                EditTextField(
                  textEditingController: descripcion,
                  textInputType: TextInputType.text,
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
                  hintext: "Agregar descripcion breve del vehiculo",
                  icon: const Icon(Icons.description),
                ),
                const SizedBox(height: 10),
                ButtonWidget(
                  function: (){
<<<<<<< HEAD
                    nameu = _name.text; numberu = _number.text; dater = _fecha.text;
                    km = _kilometro.text.toString(); marcav = _marca.text; yearv = _anio.text;
                    modelv = _modelo.text; descriptionv = _descripcion.text;
                    registerVehicle(http.Client(), widget.token, nameu, dater, km, marcav, yearv, modelv, descriptionv, numberu);
=======
                    nameu = name.text; numberu = number.text; dater = fecha.text;
                    km = kilometro.text.toString(); marcav = marca.text; yearv = anio.text;
                    modelv = modelo.text; descriptionv = descripcion.text;
                    registerVehicle(nameu, dater, km, marcav, yearv, modelv, descriptionv, numberu);
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
                  },
                  color: const Color(0xffbb1515),
                  height: 20,
                  width: 50,
                  circular: 10,
                  namebutton: "Agregar datos",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickedDate() async{
    DateTime pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101)
    );
    if(pickedDate != null ){
      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
<<<<<<< HEAD
        _fecha.text = formattedDate; //set output date to TextField value.
=======
        fecha.text = formattedDate; //set output date to TextField value.
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
      });
    }else{
      print("Date is not selected");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Fecha no seleccionada", textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 25, left: 30, right: 30),
      ));
    }
  }
  Future<void> pickedYearDate() async{
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: const Text("Seleccione el año de adquisicion del vehiculo"),
          content: SizedBox(
            height: 250,
            width: 300,
            child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 25, 1),
                lastDate: DateTime(DateTime.now().year + 25, 1),
                initialDate: DateTime.now(),
                selectedDate: _selectedYear,
                onChanged:(dateTime){
                  setState(() {
                    _selectedYear = dateTime;
<<<<<<< HEAD
                    _anio.text = "${dateTime.year}";
=======
                    anio.text = "${dateTime.year}";
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
                  });
                  Navigator.pop(context);
                }
            ),
          ),
        )
    );
  }
<<<<<<< HEAD
  Future<void> registerVehicle(http.Client client, String token, String name,
      String date, String km, String marca, String anio, String model,
=======
  Future<void> registerVehicle(
      String name, String date, String km, String marca, String anio, String model,
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
      String description, String number
      ) async{
    try{
      if(name.isEmpty && date.isEmpty && km.isEmpty && marca.isEmpty && anio.isEmpty && model.isEmpty &&
          description.isEmpty && number.isEmpty){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("CAMPOS VACIOS!!"),
              content: const Text(
                  "Ningun campo del registro para vender el vehiculo debe quedar vacio", style: TextStyle(fontSize: 22)),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cerrar",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight:
                            FontWeight.bold))),
              ],
            ));
      }
      else if(name.isEmpty || date.isEmpty || km.isEmpty || marca.isEmpty || anio.isEmpty || model.isEmpty ||
          description.isEmpty || number.isEmpty){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("CAMPOS VACIOS!!"),
              content: const Text(
                  "Todos los campos pertenecientes al vehiculo deben rellenarse sin excepcion.",
                  style: TextStyle(fontSize: 22)),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cerrar",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight:
                            FontWeight.bold))),
              ],
            ));
      }
      else{
<<<<<<< HEAD
        registerOK = await smartCare.setVehicle(client, token, name, date, km, marca, anio, model, description, number);
=======
        registerOK = await smartCare.setVehicle(name, date, km, marca, anio, model, description, number);
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
        if (registerOK == true) {
          print("ok");
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("DATOS AGREGADOS SATISFACTORIAMENTE"),
<<<<<<< HEAD
                content: const Text("Se ha completado la insercion y puesta en venta de su vehiculo, para mas informacion consulte en la central",
=======
                content: const Text("Se ha completado la inserccion y puesta en venta de su vehiculo, para mas informacion consulte en la central",
>>>>>>> 1d4bf42f06c44f9ba9989754458cb0f0a37f91cf
                    style: TextStyle(fontSize: 22), softWrap: true),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SmartCare()), (route) => false);
                      },
                      child: const Text("Listo",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ));
        }
        else{
          print("not ok");
        }
      }
    }
    catch(e){}
  }
}