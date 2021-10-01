import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/user_type_enum.dart';
import 'package:sample_tracking_system_flutter/views/pages/login_page.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Client"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(
                              userType: UserType.client,
                            )));
              },
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              child: const Text("Rider"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LoginPage(userType: UserType.rider)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
