import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Settings'),
        actions: const [],
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const ListTile(
            title: Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change password"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {},
          ),
          const Divider(
            thickness: 1,
          ),
          const ListTile(
            title: Text(
              "Sync",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text("Sync Settings"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.dns),
            title: const Text("Server Settings"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
