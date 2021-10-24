import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/views/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/views/sample/add_sample.dart';
import 'package:sample_tracking_system_flutter/views/patient/search_patient.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_card.dart';

class SamplesTab extends StatefulWidget {
  const SamplesTab({Key? key}) : super(key: key);

  @override
  _SamplesTabState createState() => _SamplesTabState();
}

class _SamplesTabState extends State<SamplesTab> {
  @override
  void didChangeDependencies() {
    getSamples();
    super.didChangeDependencies();
  }

  void getSamples() {
    Provider.of<SamplesProvider>(context, listen: false)
        .allSamplesFromdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showSearch(context: context, delegate: PatientSearch());
            },
          ),
          title: const Text('Samples'),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: IconButton(
          //         onPressed: () {
          //           // showSearch(context: context, delegate: SearchBar());
          //         },
          //         icon: const Icon(Icons.search)), //Icon(Icons.search),
          //   ),
          //   PopupMenuButton(
          //     icon: const Icon(Icons.sort),
          //     itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          //       const PopupMenuItem(
          //         child: ListTile(
          //           leading: Icon(Icons.sort_by_alpha),
          //           title: Text('a-Z'),
          //         ),
          //       ),
          //       const PopupMenuDivider(),
          //       const PopupMenuItem(
          //         child: ListTile(
          //           leading: Icon(Icons.sort),
          //           title: Text('pending'),
          //         ),
          //       ),
          //       const PopupMenuItem(
          //         child: ListTile(
          //           leading: Icon(Icons.sort),
          //           title: Text('due collection'),
          //         ),
          //       ),
          //       const PopupMenuItem(
          //         child: ListTile(
          //           leading: Icon(Icons.sort),
          //           title: Text('accepted'),
          //         ),
          //       ),
          //       const PopupMenuItem(
          //         child: ListTile(
          //           leading: Icon(Icons.sort),
          //           title: Text('rejected'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ],
        ),
        body: Consumer<SamplesProvider>(
          builder: (context, samplesProvider, child) =>
              _samplesList(samplesProvider.allSamples),
        ));
  }

  ListView _samplesList(List<Sample> samples) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: samples.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AddorUpdateSampleDialog(sampleData: samples[index]),
                    fullscreenDialog: true,
                  ),
                );
              },
              title: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(samples[index].clientPatientId.toString()),
                  ],
                ),
              ),
              subtitle: Row(
                children: const [Text('Status : '), Text("Created")],
              ),
              leading: const Icon(
                Icons.biotech,
                size: 45,
                color: Colors.blue,
              ),
              trailing: const Icon(
                Icons.sync,
                color: Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }
}
