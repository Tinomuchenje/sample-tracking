import 'package:flutter/material.dart';

class CustomSyncStatusIcon extends StatelessWidget {
  final bool positiveStatus;
  const CustomSyncStatusIcon({Key? key, required this.positiveStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.sync,
      color: positiveStatus ? Colors.green : Colors.orange,
    );
  }
}
