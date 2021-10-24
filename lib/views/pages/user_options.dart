import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/enums/user_type_enum.dart';
import 'package:sample_tracking_system_flutter/views/authentication/login_screen.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text("Please select user for login",
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 26.0,
                          color: Colors.lightBlue,
                          fontStyle: FontStyle.normal)),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: ElevatedButton(
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
                ),
              ),
              const SizedBox(width: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: ElevatedButton(
                    child: const Text("Rider"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginPage(userType: UserType.rider)));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
