import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/shipment.dart';

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
          body: TabBarView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [..._newShipments()],
            ),
            const Text("Second"),
            const Text("Third"),
          ]),
        ),
      ),
    );
  }
}

List<Widget> _newShipments() {
  //get new shipments list
  var shipments = [
    Shipment(
        id: "1",
        clientId: "1",
        status: "readyForCollection",
        samples: [],
        destination: "Harare",
        dateCreated: DateUtils.dateOnly(DateTime.now()).toString()),
    Shipment(
        id: "2",
        clientId: "2",
        status: "readyForCollection",
        samples: [],
        destination: "Norton",
        dateCreated: DateUtils.dateOnly(DateTime.now()).toString()),
    Shipment(
        id: "3",
        clientId: "3",
        status: "readyForCollection",
        samples: [],
        destination: "Zvimba",
        dateCreated: DateUtils.dateOnly(DateTime.now()).toString())
  ];

  return shipments
      .map((e) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Expanded(
              child: ExpansionTile(
                  title: Row(
                    children: [
                      const Text("Destination : "),
                      Text(e.destination),
                    ],
                  ),
                  subtitle: SizedBox(
                    height: 60.0,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Client : "),
                            Text(e.clientId),
                          ],
                        ),
                        Row(
                          children: const[
                             Text("Date Created-"),
                             Text("2021-10-04"),
                          ],
                        ),
                        Row(
                          children: const [
                            Text("Status"),
                            Text("Ready for Shipment"),
                          ],
                        )
                      ],
                    ),
                  ),
                  leading: const Icon(
                    Icons.folder,
                    size: 40.0,
                    color: Colors.blue,
                  ),
                  //trailing: Icon(
                  //  Icons.sync,
                  // color: Colors.green,
                  // ),
                  children: [
                    const Text("Samples"),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Accept Shipment")),
                    )
                  ]),
            ),
          ))
      .toList();
}
