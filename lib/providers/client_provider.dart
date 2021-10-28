import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/client.dart';
import 'package:sample_tracking_system_flutter/utils/dao/client_dao.dart';
import 'package:http/http.dart' as http;

class ClientProvider extends ChangeNotifier{

  List<Client> clients = [];

  Future<List<Client>> get AllClients async{
     await ClientDao().getAllClient().then((value){
       this.clients = value;
       notifyListeners();
     }).catchError((error){
       print(error);
     });
     return this.clients;
  }

  Future <List<dynamic>?> getAllNetworkClients() async {
    List<dynamic> all_clients = [];
    var request = http.Request('GET', Uri.parse(clientUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      all_clients = json.decode(await response.stream.bytesToString());
      // print(all_clients);
    }
    else {
    print(response.reasonPhrase);
    }
    this.clients = all_clients as List<Client>;
    notifyListeners();
    return all_clients;
  }
}