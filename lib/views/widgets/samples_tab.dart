import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/add_sample.dart';
import 'package:sample_tracking_system_flutter/views/dialogs/view_sample.dart';

class SamplesTab extends StatefulWidget {
  const SamplesTab({Key? key}) : super(key: key);

  @override
  _SamplesTabState createState() => _SamplesTabState();
}

class _SamplesTabState extends State<SamplesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddSampleDialog(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
        title: const Text('Samples'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
                onPressed: () {
                  // showSearch(context: context, delegate: SearchBar());
                },
                icon: const Icon(Icons.search)), //Icon(Icons.search),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.sort),
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
      body:
          Consumer<SamplesProvider>(builder: (context, samplesProvider, child) {
        return _samplesList(samplesProvider.samples);
      }),
    );
  }

  ListView _samplesList(samples) {
    return ListView.builder(
      itemCount: samples.length,
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
          title: Text(samples[index].sample_id.toString()),
          subtitle: const Text('Sample narration'),
          leading: const Icon(
            Icons.label,
            color: Colors.blue,
          ),
          trailing: const Icon(
            Icons.sync,
            color: Colors.green,
          ),
        );
      },
    );
  }
}
