import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            title: const Text("Shipments"),
            backgroundColor: Colors.lightBlue[900],
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: ("New"),
                ),
                Tab(
                  text: ("In progress"),
                ),
                Tab(
                  text: ("Closed"),
                )
              ],
            ),
          ),
          body: const TabBarView(children: [
            Center(
                child: Text(
              "One",
              style: TextStyle(fontSize: 50),
            )),
            Center(
                child: Text(
              "Two",
              style: TextStyle(fontSize: 50),
            )),
            Center(
                child: Text(
              "Three",
              style: TextStyle(fontSize: 50),
            ))
          ]),
        ),
      ),
    );
  }
}

_shipments() {
  //Receive shipments
}
