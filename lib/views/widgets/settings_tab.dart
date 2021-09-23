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
        leading: Icon(Icons.menu),
        title: Text('Settings'),
        actions: [],
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ListTile(title: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change password"),
            trailing: Icon(Icons.chevron_right),
            onTap: () => {},
          ),
          Divider(thickness: 1,),

          ListTile(title: Text("Sync",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),),
          ListTile(
            leading: Icon(Icons.sync),
            title: Text("Sync Settings"),
            trailing: Icon(Icons.chevron_right),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.dns),
            title: Text("Server Settings"),
            trailing: Icon(Icons.chevron_right),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
