// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/components/buttonIconDesign.dart';
import 'package:ubik_gps_application_flutter/components/cardWidgetInformation.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';

class BuyCar extends StatefulWidget{
  const BuyCar({Key key}) : super(key: key);

  @override
  _BuyCarState createState()=> _BuyCarState();
}

class _BuyCarState extends State<BuyCar>{

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Column(
            children: const [
              Text("VEHICULOS A LA VENTA"),
              Text("73 vehiculos añadidos"),
            ],
          ),
          centerTitle: true,
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: MediaQuery.of(context).size.height*0.02),
          child: ListView(
            children: [
              CardWidgetInformation(
                height: 440,
                width: 400,
                radius: 25,
                child: Column(
                  children: [
                    const ListTile(
                      title: Text("SAIL - 2022", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      subtitle: Text("Chevrolet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                    ),
                    Image.network("https://www.chevrolet.com.ec/content/dam/chevrolet/south-america/ecuador/espanol/index/cars/01-images/2022-showroom-joy-HB.jpg?imwidth=600", scale: 1),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("1.8 MPFI ELITE 8V FLEX  4 P AUTOMATICO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                              Icon(Icons.calendar_month),
                              SizedBox(width: 5),
                              Text("2020 / 2022", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                              SizedBox(width: 15),
                              Icon(Icons.speed),
                              SizedBox(width: 5),
                              Text("59000 km", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                              SizedBox(width: 60),
                              Icon(Icons.price_change_sharp),
                              SizedBox(width: 5),
                              Text("16000 USD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal))
                            ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.location_on),
                                SizedBox(width: 5),
                                Text("Location car", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                              ]
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.whatshot,
                          namebutton: "Mensajear",
                          color: const Color(0xff5baf14),
                          circular: 10,
                          size: 30,
                        ),
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.phone,
                          namebutton: "Contactar",
                          color: const Color(0xff3281ce),
                          circular: 10,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CardWidgetInformation(
                height: 440,
                width: 400,
                radius: 25,
                child: Column(
                  children: [
                    const ListTile(
                      title: Text("SAIL - 2022", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      subtitle: Text("Chevrolet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                    ),
                    Image.network("https://www.chevrolet.com.ec/content/dam/chevrolet/south-america/ecuador/espanol/index/cars/01-images/2022-showroom-joy-HB.jpg?imwidth=600", scale: 1),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("1.8 MPFI ELITE 8V FLEX  4 P AUTOMATICO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 5),
                                Text("2020 / 2022", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 15),
                                Icon(Icons.speed),
                                SizedBox(width: 5),
                                Text("59000 km", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 60),
                                Icon(Icons.price_change_sharp),
                                SizedBox(width: 5),
                                Text("16000 USD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal))
                              ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.location_on),
                                SizedBox(width: 5),
                                Text("Location car", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                              ]
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.whatshot,
                          namebutton: "Mensajear",
                          color: const Color(0xff5baf14),
                          circular: 10,
                          size: 30,
                        ),
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.phone,
                          namebutton: "Contactar",
                          color: const Color(0xff3281ce),
                          circular: 10,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CardWidgetInformation(
                height: 440,
                width: 400,
                radius: 25,
                child: Column(
                  children: [
                    const ListTile(
                      title: Text("SAIL - 2022", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      subtitle: Text("Chevrolet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                    ),
                    Image.network("https://www.chevrolet.com.ec/content/dam/chevrolet/south-america/ecuador/espanol/index/cars/01-images/2022-showroom-joy-HB.jpg?imwidth=600", scale: 1),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("1.8 MPFI ELITE 8V FLEX  4 P AUTOMATICO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 5),
                                Text("2020 / 2022", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 15),
                                Icon(Icons.speed),
                                SizedBox(width: 5),
                                Text("59000 km", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 60),
                                Icon(Icons.price_change_sharp),
                                SizedBox(width: 5),
                                Text("16000 USD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal))
                              ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.location_on),
                                SizedBox(width: 5),
                                Text("Location car", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                              ]
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.whatshot,
                          namebutton: "Mensajear",
                          color: const Color(0xff5baf14),
                          circular: 10,
                          size: 30,
                        ),
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.phone,
                          namebutton: "Contactar",
                          color: const Color(0xff3281ce),
                          circular: 10,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CardWidgetInformation(
                height: 440,
                width: 400,
                radius: 25,
                child: Column(
                  children: [
                    const ListTile(
                      title: Text("SAIL - 2022", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      subtitle: Text("Chevrolet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                    ),
                    Image.network("https://www.chevrolet.com.ec/content/dam/chevrolet/south-america/ecuador/espanol/index/cars/01-images/2022-showroom-joy-HB.jpg?imwidth=600", scale: 1),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("1.8 MPFI ELITE 8V FLEX  4 P AUTOMATICO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 5),
                                Text("2020 / 2022", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 15),
                                Icon(Icons.speed),
                                SizedBox(width: 5),
                                Text("59000 km", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 60),
                                Icon(Icons.price_change_sharp),
                                SizedBox(width: 5),
                                Text("16000 USD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal))
                              ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.location_on),
                                SizedBox(width: 5),
                                Text("Location car", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                              ]
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.whatshot,
                          namebutton: "Mensajear",
                          color: const Color(0xff5baf14),
                          circular: 10,
                          size: 30,
                        ),
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.phone,
                          namebutton: "Contactar",
                          color: const Color(0xff3281ce),
                          circular: 10,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CardWidgetInformation(
                height: 440,
                width: 400,
                radius: 25,
                child: Column(
                  children: [
                    const ListTile(
                      title: Text("SAIL - 2022", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      subtitle: Text("Chevrolet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                    ),
                    Image.network("https://www.chevrolet.com.ec/content/dam/chevrolet/south-america/ecuador/espanol/index/cars/01-images/2022-showroom-joy-HB.jpg?imwidth=600", scale: 1),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("1.8 MPFI ELITE 8V FLEX  4 P AUTOMATICO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 5),
                                Text("2020 / 2022", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 15),
                                Icon(Icons.speed),
                                SizedBox(width: 5),
                                Text("59000 km", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 60),
                                Icon(Icons.price_change_sharp),
                                SizedBox(width: 5),
                                Text("16000 USD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal))
                              ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.location_on),
                                SizedBox(width: 5),
                                Text("Location car", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                              ]
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.whatshot,
                          namebutton: "Mensajear",
                          color: const Color(0xff5baf14),
                          circular: 10,
                          size: 30,
                        ),
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.phone,
                          namebutton: "Contactar",
                          color: const Color(0xff3281ce),
                          circular: 10,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CardWidgetInformation(
                height: 440,
                width: 400,
                radius: 25,
                child: Column(
                  children: [
                    const ListTile(
                      title: Text("SAIL - 2022", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      subtitle: Text("Chevrolet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                    ),
                    Image.network("https://www.chevrolet.com.ec/content/dam/chevrolet/south-america/ecuador/espanol/index/cars/01-images/2022-showroom-joy-HB.jpg?imwidth=600", scale: 1),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("1.8 MPFI ELITE 8V FLEX  4 P AUTOMATICO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 5),
                                Text("2020 / 2022", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 15),
                                Icon(Icons.speed),
                                SizedBox(width: 5),
                                Text("59000 km", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                SizedBox(width: 60),
                                Icon(Icons.price_change_sharp),
                                SizedBox(width: 5),
                                Text("16000 USD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal))
                              ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: const [
                                Icon(Icons.location_on),
                                SizedBox(width: 5),
                                Text("Location car", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                              ]
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.whatshot,
                          namebutton: "Mensajear",
                          color: const Color(0xff5baf14),
                          circular: 10,
                          size: 30,
                        ),
                        ButtonIconWidget(
                          function: (){},
                          iconData: Icons.phone,
                          namebutton: "Contactar",
                          color: const Color(0xff3281ce),
                          circular: 10,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}