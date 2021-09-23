import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientsTab extends StatefulWidget {
  const PatientsTab({Key? key}) : super(key: key);

  @override
  _PatientsTabState createState() => _PatientsTabState();
}

class _PatientsTabState extends State<PatientsTab> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
      ),
    );
  }
}
