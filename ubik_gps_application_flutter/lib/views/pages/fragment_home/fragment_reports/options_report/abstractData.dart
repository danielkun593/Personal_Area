// ignore_for_file: public_member_api_docs, library_private_types_in_public_api, camel_case_types
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubik_gps_application_flutter/components/decorationBackground.dart';
import 'package:ubik_gps_application_flutter/src/models/sharedPreferencesClass.dart';

class abstractData extends StatefulWidget {
  const abstractData({Key key, @required this.title, @required this.name}) : super(key: key);

  final String title;
  final String name;

  @override
  _abstractDataState createState() => _abstractDataState();
}

class _abstractDataState extends State<abstractData> {
  UserPreferences userPreferences = UserPreferences();
  String name = 'GABRIEL MERIZALDE';

  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now()
  );


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    final diference = dateTimeRange.duration;

    return Container(
      decoration: DecorationBack.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Column(
            children: [Text(widget.name), Text(widget.title)],
          ),
          centerTitle: true,
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: TextButton.icon(
                onPressed: () async {
                  DateTimeRange newDateRange = await showDateRangePicker(
                      context: context,
                      initialDateRange: dateTimeRange,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2999),
                      builder: (context, child){
                        return Theme(data: ThemeData.dark(), child: child);
                      }
                  );
                  if(newDateRange == null){return;}
                  setState(()=> dateTimeRange = newDateRange);
                },
                icon: const Icon(Icons.calendar_month, color: Colors.white, size: 30),
                label: diference == null ? const Text('DATOS PREVIOS', style: TextStyle(fontSize: 20, color: Colors.white)) : Text('ULTIMOS ${diference.inDays} DIAS', style: const TextStyle(fontSize: 20, color: Colors.white)),
              )
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: const Center(child: Text('RESUMEN')),
        ),
      ),
    );
  }
}
