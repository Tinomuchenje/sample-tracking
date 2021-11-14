import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  final String message;
  const CustomBanner({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      height: 25,
      width: double.infinity,
      child: Center(child: Text(message)),
    );
  }
}
