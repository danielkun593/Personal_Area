// ignore_for_file: missing_return, unrelated_type_equality_checks, unnecessary_new, unnecessary_this
import 'package:flutter/material.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/allReportsData.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/offlineReportData.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/onlineReportData.dart';
import 'package:ubik_gps_application_flutter/views/pages/fragment_home/fragment_reports/otherReportData.dart';

class ReportsData extends StatefulWidget {
  const ReportsData({Key key}) : super(key: key);
  @override
  State<ReportsData> createState() => _ReportsDataState();
}

class _ReportsDataState extends State<ReportsData> {
  Icon iconSearch = const Icon(Icons.search, size: 30);
  Widget searchBar = const Text("REPORTES");

  void _searchPressed() {
    setState(() {
      if (iconSearch.icon == Icons.search) {
        iconSearch = const Icon(Icons.cancel, size: 30);
        searchBar = const ListTile(
          leading: Icon(Icons.search, color: Colors.white, size: 30),
          title: TextField(
            decoration: InputDecoration(
                hintText: 'Search data user',
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
                border: InputBorder.none),
            style: TextStyle(color: Colors.white),
          ),
        );
      } else {
        iconSearch = const Icon(Icons.search, size: 30);
        searchBar = const Text("REPORTES");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: searchBar,
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  _searchPressed();
                },
                icon: iconSearch)
          ],
          bottom: TabBar(
            isScrollable: false,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            tabs: const [
              Tab(text: 'TODO'),
              Tab(text: 'ONLINE'),
              Tab(text: 'OFFLINE'),
              Tab(text: 'OTRO'),
            ],
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: const TabBarView(
          physics: ScrollPhysics(),
          children: [
            allReport(),
            onlineReport(),
            offlineReport(),
            otherReport()
          ],
        ),
      ),
    );
  }
}
