import 'package:flutter/material.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  _DashboardTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   actions: [
      //     const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //     ),
      //     IconButton(
      //       onPressed: () => {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(
      //             content: Text("Syncing"),
      //             backgroundColor: Colors.green,
      //           ),
      //         )
      //       },
      //       icon: const Icon(Icons.sync),
      //     )
      //   ],
      //   backgroundColor: Colors.blue,
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       const SizedBox(
      //         height: 25,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Text(
      //           'Menu',
      //           style: textTheme.headline6,
      //         ),
      //       ),
      //       const Divider(
      //         height: 1,
      //         thickness: 1,
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Patients'),
      //         selected: _selectedDestination == 0,
      //         onTap: () => selectDestination(0),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.batch_prediction),
      //         title: const Text('Batch'),
      //         selected: _selectedDestination == 1,
      //         onTap: () => selectDestination(1),
      //       ),
      //     ],
      //   ),
      // ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          makeDashboardItem("Due Collection", 200.toString(),
              Icons.check_circle_outline, Colors.white),
          makeDashboardItem(
              "In Transit", 300.toString(), Icons.moped, Colors.white),
          makeDashboardItem(
              "Accepted", 30.toString(), Icons.task_alt, Colors.green.shade100),
          makeDashboardItem("Rejected", 30.toString(), Icons.highlight_off,
              Colors.red.shade100),
          makeDashboardItem(
              "Not Synced", 3.toString(), Icons.sync_problem, Colors.white),
          makeDashboardItem(
              "Delivered", 30.toString(), Icons.all_inbox, Colors.white),
          makeDashboardItem(
              "Total", 30.toString(), Icons.select_all, Colors.white),
        ],
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  Card makeDashboardItem(
      String title, String count, IconData icon, Color color) {
    return Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              const SizedBox(height: 50.0),
              Center(
                  child: Icon(
                icon,
                size: 40.0,
                color: Colors.black,
              )),
              const SizedBox(height: 20.0),
              Center(
                child: Text(
                  count,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              Center(
                child: Text(title,
                    style:
                        const TextStyle(fontSize: 18.0, color: Colors.black)),
              )
            ],
          ),
        ));
  }
}
