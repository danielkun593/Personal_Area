// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
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
  const AddCar({Key key}) : super(key: key);

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

  final fecha = TextEditingController();
  final kilometro = TextEditingController();
  final marca = TextEditingController();
  final modelo = TextEditingController();
  final anio  = TextEditingController();
  final descripcion  = TextEditingController();
  final name = TextEditingController();
  final number = TextEditingController();

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
                          textEditingController: fecha,
                          icon: const Icon(Icons.calendar_month),
                          textInputType: TextInputType.text,
                        ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                        flex: 1,
                        child: EditTextField(
                          icon: const Icon(Icons.speed),
                          textEditingController: kilometro,
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
                          textEditingController: marca,
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
                        textEditingController: anio,
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
                          textEditingController: modelo,
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
                  hintext: "Agregar descripcion breve del vehiculo",
                  icon: const Icon(Icons.description),
                ),
                const SizedBox(height: 10),
                ButtonWidget(
                  function: (){
                    nameu = name.text; numberu = number.text; dater = fecha.text;
                    km = kilometro.text.toString(); marcav = marca.text; yearv = anio.text;
                    modelv = modelo.text; descriptionv = descripcion.text;
                    registerVehicle(nameu, dater, km, marcav, yearv, modelv, descriptionv, numberu);
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
        fecha.text = formattedDate; //set output date to TextField value.
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
                    anio.text = "${dateTime.year}";
                  });
                  Navigator.pop(context);
                }
            ),
          ),
        )
    );
  }
  Future<void> registerVehicle(
      String name, String date, String km, String marca, String anio, String model,
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
        registerOK = await smartCare.setVehicle(name, date, km, marca, anio, model, description, number);
        if (registerOK == true) {
          print("ok");
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("DATOS AGREGADOS SATISFACTORIAMENTE"),
                content: const Text("Se ha completado la inserccion y puesta en venta de su vehiculo, para mas informacion consulte en la central",
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