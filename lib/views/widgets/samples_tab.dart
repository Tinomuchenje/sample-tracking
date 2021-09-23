import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/add_sample.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/search_bar.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/view_sample.dart';

class SamplesTab extends StatefulWidget {
  const SamplesTab({Key? key}) : super(key: key);

  @override
  _SamplesTabState createState() => _SamplesTabState();
}

class _SamplesTabState extends State<SamplesTab> {
  List<Sample> items = [];

  Future<void> initSamples() async {
    items = await SampleCrud().getSamples();
    print("Samples");
    print(items);
  }

  @override
  Widget build(BuildContext context) {
    initSamples();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            print("Pressed add button");
            // showDialog<void>(context: context, builder: (context)=>dialog);
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddSampleDialog(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
        title: Text('Samples'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
                onPressed: () {
                  // showSearch(context: context, delegate: SearchBar());
                },
                icon: Icon(Icons.search)), //Icon(Icons.search),
          ),
          PopupMenuButton(
            icon: Icon(Icons.sort),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.sort_by_alpha),
                  title: Text('a-Z'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.sort),
                  title: Text('pending'),
                ),
              ),
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.sort),
                  title: Text('due collection'),
                ),
              ),
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.sort),
                  title: Text('accepted'),
                ),
              ),
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.sort),
                  title: Text('rejected'),
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ViewSampleDialog(),
                    fullscreenDialog: true,
                  ),
                );
              },
              title: Text(items[index].sample_id),
              subtitle: Text('Sample narration'),
              leading: Icon(
                Icons.label,
                color: Colors.blue,
              ),
              trailing: Icon(
                Icons.sync,
                color: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}
