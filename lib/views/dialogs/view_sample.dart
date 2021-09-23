import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewSampleDialog extends StatelessWidget {
  const ViewSampleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Sample : 123456'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.update))
        ],
      ),
    );
  }
}

