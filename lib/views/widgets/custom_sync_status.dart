import 'package:flutter/material.dart';

class CustomSyncStatusIcon extends StatelessWidget {
  bool positiveStatus;
  CustomSyncStatusIcon({Key? key, required this.positiveStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.sync,
      color: positiveStatus ? Colors.green : Colors.orange,
    );
  }
}