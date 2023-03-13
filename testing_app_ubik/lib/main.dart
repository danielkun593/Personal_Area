import 'package:flutter/material.dart';
import 'package:testing_app_ubik/flutter_map_testing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapGps(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJnbWVyaXphbGRlQGdtYWlsLmNvbSIsImlhdCI6MTY3ODczMTE3NiwiZXhwIjoxNjc5ODExMTc2fQ.B7_WC1G03I9vmEDZgMtbcRguNUIsc6IG6sy3F7gGAzw"),
    );
  }
}