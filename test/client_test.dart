import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/providers/client_provider.dart';

void main(){
  test("Get All Patients from Network", () async {
    final clientProvider = ClientProvider();
    var clients = await clientProvider.getAllNetworkClients();
    // print(clients);
    assert(true);
  });
}