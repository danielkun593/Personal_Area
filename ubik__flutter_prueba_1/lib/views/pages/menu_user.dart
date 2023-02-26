import 'package:flutter/material.dart';

class MenuUser extends StatefulWidget {
  const MenuUser({Key key}) : super(key: key);

  @override
  MenuUserState createState() => MenuUserState();
}

class MenuUserState extends State<MenuUser> {

  String exampleDevice;
  List exampleItem = ['Carro000', 'Carro001', 'Carro002', 'Carro003', 'Carro004'];
  String examplePrev;
  List exampleMant = ['Frenos', 'Llantas', 'Aceite/Filtro', 'Filtro/Aire'];
  bool swithch = false;
  bool swithch1 = false;
  bool swithch2 = false;
  bool swithch3 = false;
  int recorridokm = 0013460701;
  int frenos = 250;
  int llantas = 200;
  int aceite = 30;
  int filtro = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
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
        body: SingleChildScrollView(
          child: Container(
              width: 500,
              padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 120,
                  bottom: 120
              ),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const Text( 'MANTENIMIENTO PROGRAMADO', softWrap: true, textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 15),
                      const Text('Kilometros Recorridos', softWrap: true, textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      Text('$recorridokm', softWrap: true, textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent, fontFamily: '7LED'),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: DropdownButton(
                            hint: const Text("Selecciona el dispositivo",textAlign: TextAlign.center),
                            style: const TextStyle(fontSize: 25, color: Colors.blueGrey),
                            icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.blueGrey),
                            iconSize: 40,
                            isExpanded: true,
                            underline: Container(),
                            value: exampleDevice,
                            onChanged: (v){
                              setState((){
                                exampleDevice = v;
                              });
                            },
                            items: exampleItem.map((valueItem){
                              return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem)
                              );

                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: DropdownButton(
                            hint: const Text("Matenimiento preventivo",textAlign: TextAlign.center),
                            style: const TextStyle(fontSize: 25, color: Colors.blueGrey),
                            icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.blueGrey),
                            iconSize: 40,
                            isExpanded: true,
                            value: examplePrev,
                            underline: Container(),
                            onChanged: (v){
                              setState((){
                                examplePrev = v;
                              });
                            },
                            items: exampleMant.map((valueItem){
                              return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem)
                              );

                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      //CAMBIOS, SLIDER OPTIONS
                      Container(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          children: [
                            Flexible(
                                flex:1,
                                fit: FlexFit.tight,
                                child: Image.asset("images/brakeChange.png", height: 50, color: Colors.grey)
                            ),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Cambio de Frenos', softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54)),
                                    Switch.adaptive(
                                      value: swithch, activeColor: Colors.greenAccent,
                                      onChanged: (bool value){
                                        setState((){
                                          swithch = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                    Text(
                                      "$frenos Km", textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54 ),
                                    ),
                                    const SizedBox(height: 10),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                          thumbColor: Colors.greenAccent,
                                          thumbShape:
                                          const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                          overlayShape:
                                          const RoundSliderOverlayShape(overlayRadius: 10.0)),
                                      child: Slider(
                                        value: frenos.toDouble(),
                                        /// maximum and minimum values
                                        min: 000.0,
                                        max: 550.0,
                                        activeColor: Colors.greenAccent,
                                        inactiveColor: Colors.green,
                                        onChanged: (double newvalue) {
                                          setState(() {
                                            frenos = newvalue.round();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      //CAMBIOS, SLIDER OPTIONS
                      Container(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          children: [
                            Flexible(
                                flex:1,
                                fit: FlexFit.tight,
                                child: Image.asset("images/tyreChange.png", height: 60, color: Colors.grey)
                            ),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Cambio de llantas', softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54)),
                                        Switch.adaptive(
                                          value: swithch1, activeColor: Colors.greenAccent,
                                          onChanged: (bool value){
                                            setState((){
                                              swithch1 = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                    Text(
                                      "$llantas Km", textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54 ),
                                    ),
                                    const SizedBox(height: 10),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                          thumbColor: Colors.greenAccent,
                                          thumbShape:
                                          const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                          overlayShape:
                                          const RoundSliderOverlayShape(overlayRadius: 10.0)),
                                      child: Slider(
                                        value: llantas.toDouble(),
                                        /// maximum and minimum values
                                        min: 000.0,
                                        max: 550.0,
                                        activeColor: Colors.greenAccent,
                                        inactiveColor: Colors.green,
                                        onChanged: (double newvalue) {
                                          setState(() {
                                            llantas = newvalue.round();
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      //CAMBIOS, SLIDER OPTIONS
                      Container(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          children: [
                            Flexible(
                                flex:1,
                                fit: FlexFit.tight,
                                child: Image.asset("images/oilChange.png", height: 60, color: Colors.grey)
                            ),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Cambio de Aceite', softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54)),
                                        Switch.adaptive(
                                          value: swithch2, activeColor: Colors.greenAccent,
                                          onChanged: (bool value){
                                            setState((){
                                              swithch2 = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                    Text(
                                      "$aceite Km", textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54 ),
                                    ),
                                    const SizedBox(height: 10),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                          thumbColor: Colors.greenAccent,
                                          thumbShape:
                                          const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                          overlayShape:
                                          const RoundSliderOverlayShape(overlayRadius: 10.0)),
                                      child: Slider(
                                        value: aceite.toDouble(),
                                        /// maximum and minimum values
                                        min: 000.0,
                                        max: 550.0,
                                        activeColor: Colors.greenAccent,
                                        inactiveColor: Colors.green,
                                        onChanged: (double newvalue) {
                                          setState(() {
                                            aceite = newvalue.round();
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      //CAMBIOS, SLIDER OPTIONS
                      Container(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          children: [
                            Flexible(
                                flex:1,
                                fit: FlexFit.tight,
                                child: Image.asset("images/filterChange.png", height: 50, color: Colors.grey)
                            ),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Cambio de Filtros', softWrap: true, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54)),
                                        Switch.adaptive(
                                          value: swithch3, activeColor: Colors.greenAccent,
                                          onChanged: (bool value){
                                            setState((){
                                              swithch3 = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                    Text(
                                      "$filtro Km", textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54 ),
                                    ),
                                    const SizedBox(height: 10),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                          thumbColor: Colors.greenAccent,
                                          thumbShape:
                                          const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                          overlayShape:
                                          const RoundSliderOverlayShape(overlayRadius: 10.0)),
                                      child: Slider(
                                        value: filtro.toDouble(),
                                        /// maximum and minimum values
                                        min: 000.0,
                                        max: 550.0,
                                        activeColor: Colors.greenAccent,
                                        inactiveColor: Colors.green,
                                        onChanged: (double newvalue) {
                                          setState(() {
                                            filtro = newvalue.round();
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      //
                      const Text( 'MANTENIMIENTO PERSONALIZADO', softWrap: true, textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.only(right: 25, left: 25),
                        child: const Text("Elige el dispositivo y agrega la configuracion correcta.", softWrap: true, textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 22, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //
                      Container(
                        padding: const EdgeInsets.only(right: 25, left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Nombre personalizado", softWrap: true, textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                              ),
                            ),

                          ],
                        )
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              primary: Colors.redAccent),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            child: const Text(
                              'Guardar',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}